import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ComplaintFirestore {
  String time = DateTime.now().day.toString() +
      DateTime.now().month.toString() +
      DateTime.now().hour.toString() +
      DateTime.now().minute.toString();

  String docTitle;

  Future<void> addData(data) async {
    FirebaseFirestore.instance
        .collection('Form Details')
        .doc('witness')
        .update(data)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> victim({
    String vicFname,
    String vicLname,
    DateTime pickedDate,
    String vicMainNum,
    String vicAltNum,
    String vicStrAdd,
    String vicCity,
    String vicState,
    String vicPinCode,
    String vicAge,
    String nature,
    String incidentDes,
    String vicGender,
    String compFname,
    String compLname,
    String compGender,
    String compMainNum,
    String compAltNum,
    String compStrAdd,
    String compCity,
    String compState,
    String compPinCode,
    String compAge,
    String compRelation,
    var imageFile,
  }) async {
    String date = pickedDate.day.toString() +
        "-" +
        pickedDate.month.toString() +
        "-" +
        pickedDate.year.toString();
    String docTitle = compMainNum;
    CollectionReference users =
        FirebaseFirestore.instance.collection('Form Details');
    print(docTitle);

    users.doc(docTitle).collection("Victim's Details").doc().set({
      'First Name': vicFname,
      'Last Name': vicLname,
      'Age': vicAge,
      'Main Number': vicMainNum,
      'Alternate Number': vicAltNum,
      'Street Address': vicStrAdd,
      'City': vicCity,
      'State': vicState,
      'Pin-Code': vicPinCode,
      'Nature of Incident': nature,
      'Incident Description': incidentDes,
      'Gender': vicGender,
    });

    users.doc(docTitle).collection("Complainant's Details").doc().set({
      'First Name': compFname,
      'Last Name': compLname,
      'Age': compAge,
      'Main Number': compMainNum,
      'Alternate Number': compAltNum,
      'Street Address': compStrAdd,
      'City': compCity,
      'State': compState,
      'Pin-Code': compPinCode,
      'Relationship with victim': compRelation,
      'Gender': compGender,
    });
    users.doc(docTitle).set({
      'VName': vicFname + " " + vicLname,
      'Case ID': docTitle,
      'Date': date,
      'CName': compFname + " " + compLname,
    });
    Reference storageReference =
        FirebaseStorage.instance.ref().child('CaseID: ' + docTitle);
    UploadTask uploadTask = storageReference.putFile(imageFile);
  }
}
