// 8. Save and display name, email and age using SharedPreferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final name=TextEditingController();
  final email=TextEditingController();
  final age=TextEditingController();
  String savedName='',savedEmail='',savedAge='';

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    setState((){
      savedName=p.getString('q8_name')??'';
      savedEmail=p.getString('q8_email')??'';
      savedAge=p.getInt('q8_age')?.toString()??'';
    });
  }

  Future<void> save()async{
    final p=await SharedPreferences.getInstance();
    await p.setString('q8_name',name.text.trim());
    await p.setString('q8_email',email.text.trim());
    await p.setInt('q8_age',int.tryParse(age.text)??0);
    await load();
    name.clear();email.clear();age.clear();
  }

  Widget field(TextEditingController c,String label,IconData icon)=>Padding(
    padding:const EdgeInsets.only(bottom:12),
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
    theme:ThemeData(colorSchemeSeed:Colors.teal,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Saved User Details'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(24),
          child:SizedBox(
            width:520,
            child:Column(children:[
              field(name,'Name',Icons.person),
              field(email,'Email',Icons.email),
              field(age,'Age',Icons.cake),
              SizedBox(
                width:double.infinity,
                child:FilledButton.icon(
                  onPressed:save,
                  icon:const Icon(Icons.save),
                  label:const Text('Save Details'),
                ),
              ),
              const SizedBox(height:18),
              if(savedName.isNotEmpty)Card(
                color:Colors.teal.shade50,
                child:Padding(
                  padding:const EdgeInsets.all(16),
                  child:Column(children:[
                    ListTile(leading:const Icon(Icons.person),title:const Text('Name'),subtitle:Text(savedName)),
                    ListTile(leading:const Icon(Icons.email),title:const Text('Email'),subtitle:Text(savedEmail)),
                    ListTile(leading:const Icon(Icons.cake),title:const Text('Age'),subtitle:Text(savedAge)),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    ),
  );
}
