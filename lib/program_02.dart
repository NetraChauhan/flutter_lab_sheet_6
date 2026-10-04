// 2. Convert Student object to Map and Map back to Student using toMap() and fromMap().
import 'package:flutter/material.dart';
void main()=>runApp(const App());

class Student{
  final String name,roll,course;
  Student(this.name,this.roll,this.course);
  Map<String,String> toMap()=>{'name':name,'roll':roll,'course':course};
  factory Student.fromMap(Map<String,String> m)=>
      Student(m['name']!,m['roll']!,m['course']!);
}

class App extends StatelessWidget{
  const App({super.key});
  Widget build(c){
    final original=Student('Mira Solis','S102','BBA');
    final map=original.toMap();
    final restored=Student.fromMap(map);

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData(colorSchemeSeed:Colors.teal,useMaterial3:true),
      home:Scaffold(
        appBar:AppBar(title:const Text('Object ↔ Map'),centerTitle:true),
        body:Align(
          alignment:Alignment.topCenter,
          child:Padding(
            padding:const EdgeInsets.all(24),
            child:SizedBox(
              width:560,
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.stretch,
                children:[
                  _Box('1. Student Object','${original.name}\n${original.roll} • ${original.course}',Icons.person),
                  const Padding(
                    padding:EdgeInsets.symmetric(vertical:8),
                    child:Icon(Icons.arrow_downward,color:Colors.teal),
                  ),
                  _Box('2. Converted Map',map.toString(),Icons.data_object),
                  const Padding(
                    padding:EdgeInsets.symmetric(vertical:8),
                    child:Icon(Icons.arrow_downward,color:Colors.teal),
                  ),
                  _Box('3. Restored Student','${restored.name}\n${restored.roll} • ${restored.course}',Icons.check_circle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget{
  final String title,text; final IconData icon;
  const _Box(this.title,this.text,this.icon);
  Widget build(c)=>Card(
    child:Padding(
      padding:const EdgeInsets.all(18),
      child:Row(children:[
        CircleAvatar(child:Icon(icon)),
        const SizedBox(width:14),
        Expanded(child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            Text(title,style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
            const SizedBox(height:4),
            Text(text),
          ],
        )),
      ]),
    ),
  );
}
