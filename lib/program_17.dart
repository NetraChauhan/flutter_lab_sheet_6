// 17. Student Profile app using SharedPreferences with save, edit and clear.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final name=TextEditingController();
  final roll=TextEditingController();
  final course=TextEditingController();
  final semester=TextEditingController();

  bool editing=true;
  String savedName='',savedRoll='',savedCourse='',savedSemester='';

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    setState((){
      savedName=p.getString('q17_name')??'';
      savedRoll=p.getString('q17_roll')??'';
      savedCourse=p.getString('q17_course')??'';
      savedSemester=p.getString('q17_semester')??'';
      editing=savedName.isEmpty;
    });
  }

  Future<void> save()async{
    if(name.text.trim().isEmpty||
       roll.text.trim().isEmpty||
       course.text.trim().isEmpty||
       semester.text.trim().isEmpty)return;

    final p=await SharedPreferences.getInstance();
    await p.setString('q17_name',name.text.trim());
    await p.setString('q17_roll',roll.text.trim());
    await p.setString('q17_course',course.text.trim());
    await p.setString('q17_semester',semester.text.trim());
    name.clear();roll.clear();course.clear();semester.clear();
    await load();
  }

  void edit(){
    name.text=savedName;
    roll.text=savedRoll;
    course.text=savedCourse;
    semester.text=savedSemester;
    setState(()=>editing=true);
  }

  Future<void> clear()async{
    final p=await SharedPreferences.getInstance();
    for(final k in ['q17_name','q17_roll','q17_course','q17_semester']){
      await p.remove(k);
    }
    setState((){
      savedName='';savedRoll='';savedCourse='';savedSemester='';
      editing=true;
    });
  }

  Widget field(TextEditingController c,String label,IconData icon)=>Padding(
    padding:const EdgeInsets.only(bottom:10),
    child:TextField(
      controller:c,
      decoration:InputDecoration(
        labelText:label,
        prefixIcon:Icon(icon),
        border:const OutlineInputBorder(),
      ),
    ),
  );

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.green,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Student Profile'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:SingleChildScrollView(
          padding:const EdgeInsets.all(24),
          child:SizedBox(
            width:560,
            child:editing
              ?Column(
                crossAxisAlignment:CrossAxisAlignment.stretch,
                children:[
                  const Text('Profile Details',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
                  const SizedBox(height:14),
                  field(name,'Name',Icons.person),
                  field(roll,'Roll Number',Icons.badge),
                  field(course,'Course',Icons.school),
                  field(semester,'Semester',Icons.calendar_month),
                  FilledButton.icon(
                    onPressed:save,
                    icon:const Icon(Icons.save),
                    label:Text(savedName.isEmpty?'Save Profile':'Update Profile'),
                  ),
                ],
              )
              :Column(
                children:[
                  Container(
                    width:double.infinity,
                    padding:const EdgeInsets.all(22),
                    decoration:BoxDecoration(
                      color:Colors.green.shade50,
                      borderRadius:BorderRadius.circular(20),
                    ),
                    child:Column(children:[
                      CircleAvatar(
                        radius:40,
                        backgroundColor:Colors.green.shade100,
                        child:Text(
                          savedName.isEmpty?'S':savedName[0],
                          style:const TextStyle(fontSize:28,fontWeight:FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height:10),
                      Text(savedName,style:const TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
                      Text('$savedCourse • Semester $savedSemester'),
                      const SizedBox(height:14),
                      ListTile(
                        leading:const Icon(Icons.badge),
                        title:const Text('Roll Number'),
                        subtitle:Text(savedRoll),
                      ),
                    ]),
                  ),
                  const SizedBox(height:14),
                  Row(children:[
                    Expanded(
                      child:FilledButton.icon(
                        onPressed:edit,
                        icon:const Icon(Icons.edit),
                        label:const Text('Edit Profile'),
                      ),
                    ),
                    const SizedBox(width:10),
                    Expanded(
                      child:OutlinedButton.icon(
                        onPressed:clear,
                        icon:const Icon(Icons.delete_outline),
                        label:const Text('Clear Profile'),
                      ),
                    ),
                  ]),
                  const SizedBox(height:10),
                  const Text('Profile is restored automatically when the app is reopened.'),
                ],
              ),
          ),
        ),
      ),
    ),
  );
}
