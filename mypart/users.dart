import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'test.dart';

void main() {
  runApp(new MaterialApp(
    home: new ScreenFour(),
  ));
}


class User {
  String name;
  String birthday;
  String gender;

  User(int gen, String name, DateTime date) {
    if (gen == 1) {
      this.gender = "Male";
    }
    else {
      this.gender = "Female";
    }
    this.birthday = date.toString();
    this.name = name;
  }
  String returnName(){
    return this.name;

  }



}
class ScreenFour extends StatefulWidget {
  @override
  _ScreenFour createState() => _ScreenFour();
}


class _ScreenFour extends State<ScreenFour> {
  User user;

  int group = 1;
  User pressed() {

    var name = _finalNameController.text;
    user = new User(group,name,_date);
    return user;
  }
  String gender(){
    if (group==1){
      return "Male";
    }
    else {
      return "Female";
    }
  }
  final _finalNameController = TextEditingController();


  TextEditingController _controller;


  void initState() {
    super.initState();

  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime _date = new DateTime.now();
  String formattedDate = 'Enter Birth Date';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1900, 8),
      lastDate: DateTime(2028),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        print('date selected: ${_date.toString()}');
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Profile Setup'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1),
                width: double.infinity,
                alignment: Alignment.topRight,
                child: FlatButton(
                  textColor: Colors.blueAccent,
                  onPressed: pressed,
                  child: Text(
                    'SKIP',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Center(
                heightFactor: 1.5,
                child: IconButton(
                  icon: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white10,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2014/04/03/10/32/user-310807__340.png'),
                  ),
                  iconSize: 100,
                  onPressed: pressed,
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                width: 290,
                child: Text(
                  'Full Name',

                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: "Some stupid hint...",
                  ),
                  controller: _finalNameController,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: 350,
                child: Row(
                  children: <Widget>[
                    Radio(
                        value: 1,
                        groupValue: group,
                        onChanged: (T) {
                          print(T);
                          setState(() {
                            group = T;
                          });
                        }),
                    Text(
                      'Male',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Radio(
                        value: 2,
                        groupValue: group,
                        onChanged: (T) {
                          print(T);
                          setState(() {
                            group = T;
                          });
                        }),
                    Text(
                      'Female',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                width: 290,
                child: Text(
                  'Birth Date',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Container(
                width: 175,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        size: 20,
                      ),
                      onPressed: () {
                        _selectDate(context);
                        var date = DateTime.parse(_date.toString());
                        formattedDate =
                            "${date.day}-${date.month}-${date.year}";
                      },
                    ),
                    Text(
                      '   ' + formattedDate,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  textColor: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context)=>ScreenFive(title: ("Dana 1"),clientName: _finalNameController.text,dateTime:_date.toIso8601String(),gender: gender()),
                      //settings: RouteSettings(
                        //arguments: pressed(),
                      //),
                    ),);

                  },
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
