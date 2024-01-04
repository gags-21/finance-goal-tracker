import 'package:expense_track/constants/theme.dart';
import 'package:expense_track/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController spendTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? currentUserAuth = FirebaseAuth.instance.currentUser;
    FirebaseStore fireStore = FirebaseStore();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                        style: const TextTheme().bodyMedium,
                      ),
                      Text(
                        "Current Saving ",
                        style: const TextTheme().bodyLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 150,
                    height: 200,
                    child: StreamBuilder<int>(
                        stream: fireStore.getExpense(uid: currentUserAuth!.uid),
                        builder: (context, savedAmount) {
                          // calculating percentage;
                          double savedPer =
                              ((savedAmount.data ?? 0) / 10000) * 100;
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
                                    color: Color.fromARGB(255, 1, 51, 91),
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
                    .setExpense(
                        uid: currentUserAuth.uid,
                        expense: int.tryParse(spendTextController.text) ?? 0)
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
        ],
      ),
    );
  }
}
