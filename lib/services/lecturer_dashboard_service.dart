import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/addUnit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LecturerDashboardService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  //method to fetch units of the lecturer
  Future<List<AddUnitModel>> fetchLecturerUnits() async {
    List<AddUnitModel> units = [];
    try {
      await firestore
          .collection('units')
          .where('unitLecturerName', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          units.add(AddUnitModel.fromMap(element.data()));
        });
      });
    } catch (e) {
      print(e);
    }
    return units;
  }
}
