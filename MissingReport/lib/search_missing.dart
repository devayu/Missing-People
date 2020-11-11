import 'package:MissingReport/missing_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class SearchMissing extends StatefulWidget {
  static const routeName = '/search';
  @override
  _SearchMissingState createState() => _SearchMissingState();
}

class _SearchMissingState extends State<SearchMissing> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
  }

  List allresults = [];
  List resultsList = [];
  List victimName = [];
  onSearchChanged() {
    searchResultList();
    print(searchController.text);
  }

  // getFirebaseData() async {
  //   var data =
  //       await FirebaseFirestore.instance.collection('Form Details').get();

  //   setState(() {
  //     allresults = data.docs;
  //   });

  //   searchResultList();
  // }
  String docTitle;
  searchResultList() {
    var showResults = [];

    if (searchController.text != '') {
      var index = allresults.length;

      if (victimName[1].contains(searchController.text.toLowerCase())) {
        showResults.add(allresults);
      }
    } else {
      showResults = List.from(allresults);
    }
    setState(() {
      resultsList = showResults;
    });
  }

  getList(List vicList) {
    if (vicList.contains(searchController.text)) {
      setState(() {
        resultsList = allresults;
      });
    }
  }

  bool progress = false;
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

  TextEditingController caseIdController = new TextEditingController();
  TextEditingController victimNameController = new TextEditingController();

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(1), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: const AssetImage('assets/images/bg.png'),
              ),
            ),
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Find Missing',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 35),
                  ),
                  centerTitle: true,
                ),
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.grey[300],
                            child: TextFormField(
                              controller: caseIdController,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  hintText: 'Enter Case ID',
                                  counterText: '',
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 20)),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (caseIdController.text.isEmpty) {
                              Toast.show(
                                  'Case ID or Victim name cannot be empty',
                                  context,
                                  duration: Toast.LENGTH_LONG);
                            } else {
                              setState(() {
                                progress = true;
                                docTitle = caseIdController.text;
                              });
                            }
                          },
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        progress == true
                            ? SingleChildScrollView(
                                child: MissingCard(docTitle))
                            : Container(),
                      ],
                    ),
                  ],
                ))));
  }
}
