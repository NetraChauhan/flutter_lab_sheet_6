// 14. Save a Student object as JSON in SharedPreferences and display it after retrieving.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class Student{
  final String name,roll,course;
  Student(this.name,this.roll,this.course);
  Map<String,dynamic> toMap()=>{'name':name,'roll':roll,'course':course};
  factory Student.fromMap(Map<String,dynamic> m)=>
      Student(m['name'],m['roll'],m['course']);
}

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final name=TextEditingController();
  final roll=TextEditingController();
  final course=TextEditingController();
  Student? saved;

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> save()async{
    final s=Student(name.text.trim(),roll.text.trim(),course.text.trim());
    if(s.name.isEmpty||s.roll.isEmpty||s.course.isEmpty)return;
    final p=await SharedPreferences.getInstance();
    await p.setString('q14_student',jsonEncode(s.toMap()));
    name.clear();roll.clear();course.clear();
    await load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    final raw=p.getString('q14_student');
    if(raw==null)return;
    setState(()=>saved=Student.fromMap(jsonDecode(raw)));
  }

  Widget field(TextEditingController c,String label)=>Padding(
    padding:const EdgeInsets.only(bottom:10),
    child:TextField(
      controller:c,
      decoration:InputDecoration(labelText:label,border:const OutlineInputBorder()),
    ),
  );

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.deepPurple,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Student JSON Storage'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(24),
          child:SizedBox(
            width:540,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children:[
                field(name,'Student Name'),
                field(roll,'Roll Number'),
                field(course,'Course'),
                FilledButton.icon(
                  onPressed:save,
                  icon:const Icon(Icons.save),
                  label:const Text('Save Student as JSON'),
                ),
                const SizedBox(height:18),
                if(saved!=null)Card(
                  color:Colors.deepPurple.shade50,
                  child:Padding(
                    padding:const EdgeInsets.all(18),
                    child:Column(children:[
                      const CircleAvatar(radius:30,child:Icon(Icons.person)),
                      const SizedBox(height:8),
                      Text(saved!.name,style:const TextStyle(fontSize:23,fontWeight:FontWeight.bold)),
                      Text('Roll: ${saved!.roll}'),
                      Text('Course: ${saved!.course}'),
                      const SizedBox(height:8),
                      const Text('Retrieved from SharedPreferences'),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
