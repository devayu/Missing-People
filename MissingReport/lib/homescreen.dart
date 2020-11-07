import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homescreen';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    String userName = args;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg.png'),
            )),
            child: Column(
              children: [
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
                      userName,
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
                  height: 80,
                  width: 280,
                  alignment: Alignment.centerLeft,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      color: Theme.of(context).accentColor,
                      child: InkWell(
                        onTap: () {},
                        splashColor: Theme.of(context).primaryColor,
                        child: ListTile(
                          leading: Icon(
                            Icons.report,
                            color: Colors.black,
                          ),
                          title: Text('Report Missing Person',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 100,
                  width: 280,
                  alignment: Alignment.centerLeft,
                  child: Card(
                      elevation: 5,
                      color: Theme.of(context).accentColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        title: Text('Find Missing Person',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
