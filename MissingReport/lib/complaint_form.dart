import 'package:MissingReport/after_form_screen.dart';
import 'package:MissingReport/comlaint_form_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import 'comlaint_form_firebase.dart';

class ComplaintForm extends StatefulWidget {
  static const routeName = '/complaintform';
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  PickedFile image;
  var imageFile;
  Future getImage() async {
    PickedFile userImage;
    {
      userImage = (await ImagePicker().getImage(source: ImageSource.gallery));
      setState(() {
        image = userImage;
        imageFile = File(userImage.path);
      });
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Are you sure ?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: new Text(
            'Changes cannot be made after you confirm.',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "NO",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                "YES",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                obj.victim(
                  vicFname: vicFname.text,
                  vicLname: vicLname.text,
                  vicAge: vicAge.text,
                  vicStrAdd: vicStrAdd.text,
                  vicCity: vicCity.text,
                  vicState: vicState.text,
                  vicPinCode: vicPinCode.text,
                  nature: nature.text,
                  incidentDes: incidentDes.text,
                  vicMainNum: vicMainNum.text,
                  vicAltNum: vicAltNum.text,
                  pickedDate: selectedDate,
                  vicGender: vicGender.text,
                  compFname: compFname.text,
                  compLname: compLname.text,
                  compAge: compAge.text,
                  compStrAdd: compStrAdd.text,
                  compCity: compCity.text,
                  compState: compState.text,
                  compPinCode: compPinCode.text,
                  compRelation: compRelation.text,
                  compGender: compGender.text,
                  compMainNum: compMainNum.text,
                  compAltNum: compAltNum.text,
                  imageFile: imageFile,
                );

                Navigator.of(context).pop();

                Navigator.pushNamed(context, AfterForm.routeName,
                    arguments: compMainNum.text);
              },
            )
          ],
        );
      },
    );
  }

  DateTime selectedDate;
  DateTime currentTime = DateTime.now();
  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
        currentTime = DateTime.now();
      });
    });
  }

  ComplaintFirestore obj = new ComplaintFirestore();

  final _formKey = GlobalKey<FormState>();

  bool checkedValue = false;

  TextEditingController vicFname = new TextEditingController();
  TextEditingController vicLname = new TextEditingController();
  TextEditingController vicMainNum = new TextEditingController();
  TextEditingController vicAltNum = new TextEditingController();
  TextEditingController vicStrAdd = new TextEditingController();
  TextEditingController vicCity = new TextEditingController();
  TextEditingController vicState = new TextEditingController();
  TextEditingController vicPinCode = new TextEditingController();
  TextEditingController nature = new TextEditingController();
  TextEditingController incidentDes = new TextEditingController();
  TextEditingController vicAge = new TextEditingController();
  TextEditingController vicGender = new TextEditingController();

  TextEditingController compFname = new TextEditingController();
  TextEditingController compLname = new TextEditingController();
  TextEditingController compMainNum = new TextEditingController();
  TextEditingController compAltNum = new TextEditingController();
  TextEditingController compStrAdd = new TextEditingController();
  TextEditingController compCity = new TextEditingController();
  TextEditingController compState = new TextEditingController();
  TextEditingController compPinCode = new TextEditingController();
  TextEditingController compRelation = new TextEditingController();
  TextEditingController compGender = new TextEditingController();
  TextEditingController compAge = new TextEditingController();

  Widget titleBuilder(String name) {
    return RichText(
      text: TextSpan(
          text: name,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.black),
          children: [
            TextSpan(
              text: ' * ',
              style: TextStyle(color: Colors.red, fontSize: 16.0),
            ),
            TextSpan(
              text: ' : ',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ]),
    );
  }

  @override
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
                'Report Missing',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 35),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        "Missing Person's Detail",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 30),
                                child: titleBuilder('Age')),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicAge,
                                    validator: (value) {
                                      if (value.isEmpty) return '@required';
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'Age',
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2)),
                                      errorStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5)),
                              width: 100,
                              height: 100,
                              //color: Colors.red,
                              child: image == null
                                  ? IconButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 40,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        child: Stack(
                                          fit: StackFit.expand,
                                          alignment: Alignment.center,
                                          children: [
                                            Image.file(
                                              imageFile,
                                              fit: BoxFit.cover,
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.refresh,
                                                  color: Colors.white70,
                                                ),
                                                onPressed: () {
                                                  getImage();
                                                }),
                                          ],
                                        ),
                                      ),
                                    )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Full Name')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '@required';
                                      }
                                    },
                                    controller: vicFname,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'First Name',
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2)),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicLname,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Gender')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: vicGender,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.text,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Phone Number')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicMainNum,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'Main Number',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicAltNum,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Alternate Number',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Address')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: vicStrAdd,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  labelText: 'Street Address',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicCity,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'City',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: vicState,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * .5,
                          height: 60,
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: vicPinCode,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Pin Code',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Date and Time of Missing')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .5,
                                padding: EdgeInsets.only(left: 20),
                                child: Card(
                                    color: Colors.grey[300],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: selectedDate == null
                                              ? Text(
                                                  'Choose Date',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  DateFormat.MMMd()
                                                      .format(selectedDate)
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Montserrat',
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            presentDatePicker();
                                          },
                                          icon: Icon(
                                            Icons.calendar_today,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .5,
                                padding: EdgeInsets.only(right: 20),
                                child: Card(
                                    color: Colors.grey[300],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 40,
                                          child: TextField(
                                            maxLength: 2,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(1.5),
                                              hintText: 'HH',
                                              counterText: '',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 40,
                                          child: TextField(
                                            maxLength: 2,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(1.5),
                                              hintText: 'MM',
                                              counterText: '',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Incident Description')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: incidentDes,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Tell us about the incident...',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),

                    //*
                    //* ANCHOR Complainant's Block Start
                    //*

                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        "Complainant's Detail",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 30),
                                child: titleBuilder('Age')),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: compAge,
                                    validator: (value) {
                                      if (value.isEmpty) return '@required';
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'Age',
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2)),
                                      errorStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Full Name')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '@required';
                                      }
                                    },
                                    controller: compFname,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'First Name',
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2)),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: compLname,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Gender')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: compGender,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.text,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Phone Number')),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: compMainNum,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'Main Number',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: compAltNum,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Alternate Number',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child: titleBuilder('Address')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: compStrAdd,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  labelText: 'Street Address',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: compCity,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixStyle: TextStyle(color: Colors.red),
                                      labelText: 'City',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width * .5,
                              height: 60,
                              child: Card(
                                color: Colors.grey[300],
                                child: TextFormField(
                                    controller: compState,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Theme.of(context).primaryColor,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * .5,
                          height: 60,
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: compPinCode,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Pin Code',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            child:
                                titleBuilder('Relationship with the missing')),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            color: Colors.grey[300],
                            child: TextFormField(
                                controller: compRelation,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.multiline,
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      checkColor: Colors.red,

                      subtitle: Text(
                        '*fields are required',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                      title: Text(
                        "*I certify that the above information is true and correct. I am totally aware that any legal action can be taken against me if the above provided information found out to be incorrect.",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                      value: checkedValue,
                      onChanged: (bool newValue) {
                        setState(() {
                          checkedValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 150,
                          height: 50,
                          child: InkWell(
                              onTap: () {
                                if (checkedValue == false) {
                                  Toast.show(
                                    'Checkbox Unchecked',
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM,
                                  );
                                } else if (image == null) {
                                  Toast.show('No Image selected', context);
                                } else {
                                  _showDialog();
                                }
                              },
                              child: Card(
                                color: Theme.of(context).primaryColor,
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ), //!form column
              ),
            ),
          )),
    );
  }
}
