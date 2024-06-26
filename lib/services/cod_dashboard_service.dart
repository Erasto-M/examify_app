import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/addUnit.dart';
import '../models/student_registered_units.dart';

class AdminDashboardService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<AddUnitModel?> addUnit({
    required AddUnitModel addUnitModel,
  }) async {
    try {
      CollectionReference collectionReference = db.collection("units");
      final unitWithId =
          addUnitModel.copyWith(unitId: collectionReference.doc().id);
      collectionReference
          .doc(addUnitModel.unitCode)
          .set(unitWithId.toMap())
          .then((value) {
        Fluttertoast.showToast(msg: "Added Unit Successfully");
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  //get units from firestore where semesterStage has text Y4
  Future<List<AddUnitModel>> getUnits(String currentYear) async {
    List<AddUnitModel> units = [];
    try {
      CollectionReference collectionReference = db.collection("units");
      await collectionReference
          .where("year", isEqualTo: currentYear)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          units.add(AddUnitModel.fromMap(element.data() as Map<String, dynamic>)
              .copyWith(unitId: element.id));
        });
      });
    } catch (error) {
      print(error.toString());
      Fluttertoast.showToast(msg: error.toString());
    }
    return units;
  }

  Future<void> editUnit(
      {required String unitCode, required String unitName}) async {
    try {
      await db.collection('units').doc(unitCode).update({
        'unitName': unitName,
      });
    } catch (e) {
      // Handle error
    } finally {}
  }

  Stream<List<StudentsRegisteredUnitsModel>> getStudentUnits(
      String semesterStage, String studentUid) {
    return db
        .collection('student_registered_units')
        .where('semesterStage', isEqualTo: semesterStage)
        .where('studentUid', isEqualTo: studentUid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<StudentsRegisteredUnitsModel> units = [];
      for (var doc in query.docs) {
        units.add(StudentsRegisteredUnitsModel.fromDocument(doc));
      }
      return units;
    });
  }
}
