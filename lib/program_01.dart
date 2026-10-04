// 1. Store student details in a Map and display all key-value pairs.
import 'package:flutter/material.dart';
void main()=>runApp(const App());

class App extends StatelessWidget{
  const App({super.key});
  Widget build(c){
    final student={
      'Name':'Aarav Vale',
      'Roll Number':'S101',
      'Course':'BCA',
    };
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData(colorSchemeSeed:Colors.indigo,useMaterial3:true),
      home:Scaffold(
        appBar:AppBar(title:const Text('Student Map'),centerTitle:true),
        body:Align(
          alignment:Alignment.topCenter,
          child:Padding(
            padding:const EdgeInsets.all(24),
            child:SizedBox(
              width:500,
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.stretch,
                children:[
                  Container(
                    padding:const EdgeInsets.all(18),
                    decoration:BoxDecoration(
                      color:Colors.indigo.shade50,
                      borderRadius:BorderRadius.circular(18),
                    ),
                    child:const Row(children:[
                      CircleAvatar(radius:28,child:Icon(Icons.person)),
                      SizedBox(width:14),
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children:[
                          Text('Student Details',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
                          Text('Stored inside a Dart Map'),
                        ],
                      ),
                    ]),
                  ),
                  const SizedBox(height:16),
                  ...student.entries.map((e)=>Card(
                    child:ListTile(
                      leading:const Icon(Icons.key),
                      title:Text(e.key),
                      trailing:Text(e.value,style:const TextStyle(fontWeight:FontWeight.bold)),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
