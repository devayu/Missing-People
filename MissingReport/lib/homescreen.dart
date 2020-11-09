import 'package:MissingReport/complaint_form.dart';
import 'package:MissingReport/search_missing.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homescreen';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    String userName = args;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.png'),
          )),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Container(
                  padding: EdgeInsets.only(right: 30, top: 30),
                  alignment: Alignment.topRight,
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                        color: Hexcolor('#0677BD'),
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: EdgeInsets.only(right: 30),
                  alignment: Alignment.topRight,
                  child: Text(
                    userName.toUpperCase(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Montserrat',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 100,
                width: 280,
                alignment: Alignment.centerLeft,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ComplaintForm.routeName);
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.report,
                          color: Colors.white,
                        ),
                        title: Text('Report Missing Person',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                width: 280,
                alignment: Alignment.centerLeft,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SearchMissing.routeName);
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        title: Text('Find Missing Person',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
