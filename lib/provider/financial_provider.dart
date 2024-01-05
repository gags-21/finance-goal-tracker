import 'package:expense_track/utils/firebase.dart';
import 'package:flutter/material.dart';

class FinancialsProvider extends ChangeNotifier {
  int _target = 0;
  int _savings = 0;
  int _monthTarget = 0;

  int get target => _target;
  int get savings => _savings;
  int get monthTarget => _monthTarget;

  FirebaseStore firestore = FirebaseStore();

  void getTarget({required String uid, required String targetOf}) async {
    final val = await firestore.getTarget(uid: uid, targetOf: targetOf).first;
    _target = val;
    notifyListeners();
    if (targetOf == "month") {
      _monthTarget = val;
      notifyListeners();
    }
  }

  void getSavings({required String uid}) async {
    final val = await firestore.getSavings(uid: uid).first;
    _savings = val;
  }
}
