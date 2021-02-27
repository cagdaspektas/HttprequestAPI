import 'package:deneme123/request/model/reqmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VeriCekme extends StatefulWidget {
  @override
  _VeriCekmeState createState() => _VeriCekmeState();
}

class _VeriCekmeState extends State<VeriCekme> {
  List<Notes> _notes = List<Notes>();
  bool isClicked= false;
  @override
  Widget build(BuildContext context) {
     getData().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    }); 
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("request api"),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                isClicked=true;
              });
              getData();
            },
            child: Center(
              child: Container(
                height: 50,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.red),
                child: Center(child: Text('get data')),
              ),
            ),
          ),
        ],
      ),
      body:isClicked==true ? ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _notes[index].title??'default value',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    _notes[index].text??'default value',
                    style: TextStyle(color: Colors.teal, fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        },
      ):Container(),
    );
  }

  Future<List<Notes>> getData() async {
    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(url);
    var values = List<Notes>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      print(notesJson);
      for (var noteJson in notesJson) {
        values.add(Notes.fromjson(noteJson));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return values;
  }
}
