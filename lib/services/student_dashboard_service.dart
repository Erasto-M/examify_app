import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/addUnit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentDashboardService {
  //firebase instances
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  //method to fetch units from firebase
  Stream<List<AddUnitModel>> fetchUnits() {
    try {
      print("Fetching units as stream");
      return db.collection("units").snapshots().map((querySnapshot) {
        print("Number of units fetched: ${querySnapshot.docs.length}");
        return querySnapshot.docs.map((doc) {
          return AddUnitModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return Stream.value([]); // Return an empty stream in case of error
    }
  }

  // my registered units
  Future<void> myRegisteredUnits(List<AddUnitModel> selectedUnits) async {
    try {
      List<Map<String, dynamic>> unitsMap =
          selectedUnits.map((unit) => unit.toMap()).toList();
      await db
          .collection("my_units")
          .doc(auth.currentUser!.uid)
          .set({'units': unitsMap});
      Fluttertoast.showToast(msg: "Units registered successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // fetch all my units

  Stream<List<AddUnitModel>> fetchAllMyUnits() async* {
    try {
      // Fetch the document snapshot from Firestore
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("my_units")
          .doc(auth.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        // Retrieve the 'units' array from the document snapshot
        final List<dynamic> unitsMap =
            (documentSnapshot.data() as Map<String, dynamic>)['units'];

        // Convert each map in the 'units' array to an AddUnitModel object
        final List<AddUnitModel> units = unitsMap
            .map((unit) => AddUnitModel.fromMap(unit as Map<String, dynamic>))
            .toList();

        // Yield the units list to the stream
        yield units;
      } else {
        // If the document doesn't exist, yield an empty list to the stream
        yield [];
      }
    } catch (e) {
      print('Error fetching all units: $e');
      // Handle errors more gracefully, perhaps by showing an error message
      // Yield an empty list to the stream
      yield [];
    }
  }
}
