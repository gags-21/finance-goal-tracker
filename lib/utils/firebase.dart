import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStore {
  // initialize
  final firebase = FirebaseFirestore.instance;

  // Expense
  Future<void> setSaving({required String uid, required int saving}) async {
    var pastExpense = await firebase
        .collection(uid)
        .doc("Savings")
        .get()
        .then((value) => value["saving"])
        .catchError((e) => 0);
    DateTime date = DateTime.now();
    try {
      // expense
      Map<String, dynamic> expenseData = {
        "saving": saving + pastExpense,
      };
      firebase
          .collection(uid)
          .doc("Savings")
          .set(expenseData, SetOptions(merge: false));

      // history
      Map<String, dynamic> history = {
        date.toString(): saving,
      };
      firebase
          .collection(uid)
          .doc("History")
          .set(history, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  Stream<int> getSavings({required String uid}) {
    try {
      var expense = firebase.collection(uid).doc("Savings");
      return expense.snapshots().map(
        (exp) {
          return exp.data()?["saving"];
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  //  history
  Stream<Map?> getHistory({required String uid}) {
    try {
      var expense = firebase.collection(uid).doc("History");
      return expense.snapshots().map(
        (exp) {
          return exp.data();
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // target
  Future<void> setTarget(
      {required String uid, required Map<String, int> target}) async {
    try {
      firebase
          .collection(uid)
          .doc("Targets")
          .set(target, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  Stream<int> getTarget({required String uid, required String targetOf}) {
    try {
      var expense = firebase.collection(uid).doc("Targets");
      return expense.snapshots().map(
        (target) {
          return target.data()?[targetOf] ?? 0;
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
