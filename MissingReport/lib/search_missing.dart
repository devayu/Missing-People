import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

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

  getFirebaseData() async {
    var data =
        await FirebaseFirestore.instance.collection('Form Details').get();

    setState(() {
      allresults = data.docs;
    });

    searchResultList();
  }

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
                  // Container(
                  //   padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  //   child: Card(
                  //     color: Colors.grey[300],
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: TextField(
                  //       controller: searchController,
                  //       decoration: InputDecoration(
                  //           prefixIcon: Icon(
                  //             Icons.search,
                  //           ),
                  //           border: InputBorder.none),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Form Details')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('Loading Data ');
                        }
                        getFirebaseData();

                        return ListView.builder(
                          itemCount: resultsList.length,
                          //snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            victimName
                                .add(snapshot.data.documents[index]['VName']);
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              height: 150,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      missingPersonCardBuilder(
                                          'CaseID: ',
                                          snapshot.data.documents[index]
                                              ['Case ID']),
                                      missingPersonCardBuilder(
                                          'Victim Name:',
                                          snapshot.data.documents[index]
                                              ['VName']),
                                      missingPersonCardBuilder(
                                          'Date of missing',
                                          snapshot.data.documents[index]['Date']
                                              .toString()),
                                      missingPersonCardBuilder(
                                          'Complainant Name:',
                                          snapshot.data.documents[index]
                                              ['CName']),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
