import 'package:expense_track/provider/financial_provider.dart';
import 'package:expense_track/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController spendTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? currentUserAuth = FirebaseAuth.instance.currentUser;
    FirebaseStore fireStore = FirebaseStore();
    final finProvider = Provider.of<FinancialsProvider>(context, listen: false);
    finProvider.getTarget(uid: currentUserAuth!.uid, targetOf: "month");
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hi, ${currentUserAuth!.displayName}",
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Text(
                        "Current Saving ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 150,
                    height: 200,
                    child: StreamBuilder<int>(
                        stream: fireStore.getSavings(uid: currentUserAuth!.uid),
                        builder: (context, savedAmount) {
                          // calculating percentage;
                          double savedPer = finProvider.target != 0
                              ? ((savedAmount.data ?? 0) / finProvider.target) *
                                  100
                              : 0;
                          return SfRadialGauge(
                            enableLoadingAnimation: true,
                            axes: [
                              RadialAxis(
                                minimum: 0,
                                maximum: 100,
                                showLabels: false,
                                showTicks: false,
                                axisLineStyle: const AxisLineStyle(
                                  thickness: 0.2,
                                  cornerStyle: CornerStyle.bothCurve,
                                  color: Color.fromARGB(30, 0, 169, 181),
                                  thicknessUnit: GaugeSizeUnit.factor,
                                ),
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    value: savedPer,
                                    cornerStyle: CornerStyle.bothCurve,
                                    width: 0.2,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    color: const Color.fromARGB(255, 1, 51, 91),
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      positionFactor: 0.1,
                                      angle: 90,
                                      widget: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              "\$ ${savedAmount.data ?? 0}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          const Text("SAVED"),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),

          // submit expense
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: TextField(
              controller: spendTextController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hintText: "Enter saved amount",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () {
              if (spendTextController.text.isEmpty ||
                  spendTextController.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter valid amount"),
                  ),
                );
              } else {
                fireStore
                    .setSaving(
                        uid: currentUserAuth.uid,
                        saving: int.tryParse(spendTextController.text) ?? 0)
                    .then(
                      (value) => spendTextController.clear(),
                    )
                    .catchError((e) {
                  ScaffoldMessenger.of(context);
                });
              }
            },
            child: const Text(
              "Submit",
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          // transactions
          const Divider(),
           const SizedBox(
            height: 10,
          ),
          const Text(
            "History",
            textAlign: TextAlign.left,
          ),

          StreamBuilder<Map?>(
              stream: fireStore.getHistory(uid: currentUserAuth.uid),
              builder: (context, historyStream) {
                return historyStream.data != null
                    ? Column(
                        children: historyStream.data!.entries.map((his) {
                        DateTime date = DateTime.parse(his.key);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: ListTile(
                            title: const Text("House savings"),
                            subtitle: Text(
                                "${date.day} / ${date.month} / ${date.year}"),
                            trailing: Text(
                              "\$ ${his.value}",
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.green),
                            ),
                          ),
                        );
                      }).toList())
                    : const SizedBox();
              }),
        ],
      ),
    );
  }
}
