import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStore {
  // initialize
  final firebase = FirebaseFirestore.instance;

  Future<void> setExpense({required String uid, required int expense}) async {
    var pastExpense = await firebase
        .collection(uid)
        .doc("Expenses")
        .get()
        .then((value) => value["expense"])
        .catchError((e) => 0);
    try {
      Map<String, dynamic> expenseData = {
        "expense": expense + pastExpense,
      };
      firebase
          .collection(uid)
          .doc("Expenses")
          .set(expenseData, SetOptions(merge: false));
    } catch (e) {
      rethrow;
    }
  }

  Stream<int> getExpense({required String uid}) {
    try {
      var expense = firebase.collection(uid).doc("Expenses");
      return expense.snapshots().map(
        (exp) {
          return exp.data()?["expense"];
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
