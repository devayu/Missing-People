import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MissingCard extends StatelessWidget {
  String docTitle;
  MissingCard(this.docTitle);

  Widget missingPersonCardBuilder(String title, String docT) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            docT.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ]);
  }

  void onError() {
    print('error occured');
  }

  bool check;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading');
          if (docTitle != snapshot.data.documents[0]['Case ID']) {
            check = false;
          }
          return Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            height: 150,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: check == false
                    ? Text('demo')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          missingPersonCardBuilder('CaseID: ',
                              snapshot.data.documents[0]['Case ID']),
                          missingPersonCardBuilder('Victim Name:',
                              snapshot.data.documents[0]['VName']),
                          missingPersonCardBuilder('Date of missing',
                              snapshot.data.documents[0]['Date'].toString()),
                          missingPersonCardBuilder('Complainant Name:',
                              snapshot.data.documents[0]['CName']),
                        ],
                      ),
              ),
            ),
          );
        },
        stream: FirebaseFirestore.instance
            .collection('Form Details')
            .doc(docTitle)
            .collection('Report')
            .snapshots(),
      ),
    );
  }
}
