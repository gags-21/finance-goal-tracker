import 'package:expense_track/constants/theme.dart';
import 'package:expense_track/constants/widgets.dart';
import 'package:expense_track/provider/financial_provider.dart';
import 'package:expense_track/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackerScreen extends StatelessWidget {
  TrackerScreen({super.key});

  final TextEditingController goalTargetController = TextEditingController();
  final TextEditingController monthTargetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? currentUserAuth = FirebaseAuth.instance.currentUser;
    FirebaseStore fireStore = FirebaseStore();
    final finProvider = Provider.of<FinancialsProvider>(context, listen: false);
    finProvider.getSavings(uid: currentUserAuth!.uid);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<int>(
              stream: fireStore.getTarget(
                  uid: currentUserAuth!.uid, targetOf: "buy_home_target"),
              builder: (context, target) {
                int moreToGo = (target.data ?? 0) - finProvider.savings;
                int prediction = moreToGo ~/ finProvider.monthTarget;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // Radial progress
                    const Text(
                      "Buy Dream House",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: RadialExpenseTracker(
                        icon: Icons.home_filled,
                        totalTarget: target.data ?? 0,
                        completedTarget: finProvider.savings,
                      ),
                    ),

                    // Goal / Finance info
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Goal",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "by Jan 2030",
                                style: TextStyle(color: Colors.white38),
                              ),
                            ],
                          ),
                          Text(
                            "\$ ${target.data ?? 0}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      color: Colors.white10,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "More to go!",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                "Prediction",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$ $moreToGo",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                "$prediction months",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // submit goal details
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextField(
                        controller: goalTargetController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: "Enter target amount for buying Home",
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (goalTargetController.text.isEmpty ||
                            goalTargetController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter valid target amount"),
                            ),
                          );
                        } else {
                          fireStore
                              .setTarget(uid: currentUserAuth!.uid, target: {
                                "buy_home_target":
                                    int.tryParse(goalTargetController.text) ?? 0
                              })
                              .then(
                                (value) => goalTargetController.clear(),
                              )
                              .catchError((e) {
                                ScaffoldMessenger.of(context);
                              });
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // submit monthly goal
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextField(
                        controller: monthTargetController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: "Enter target amount for month",
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (monthTargetController.text.isEmpty ||
                            monthTargetController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter valid target amount"),
                            ),
                          );
                        } else {
                          fireStore
                              .setTarget(uid: currentUserAuth!.uid, target: {
                                "month":
                                    int.tryParse(monthTargetController.text) ??
                                        0
                              })
                              .then(
                                (value) => monthTargetController.clear(),
                              )
                              .catchError((e) {
                                ScaffoldMessenger.of(context);
                              });
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
