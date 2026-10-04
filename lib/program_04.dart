// 4. Save user's name using SharedPreferences and display it when reopened.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final input=TextEditingController();
  String savedName='';

  @override
  void initState(){
    super.initState();
    loadName();
  }

  Future<void> loadName()async{
    final p=await SharedPreferences.getInstance();
    setState(()=>savedName=p.getString('q4_name')??'');
  }

  Future<void> saveName()async{
    final name=input.text.trim();
    if(name.isEmpty)return;
    final p=await SharedPreferences.getInstance();
    await p.setString('q4_name',name);
    setState(()=>savedName=name);
    input.clear();
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.blue,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Remember My Name'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(24),
          child:SizedBox(
            width:480,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children:[
                const Icon(Icons.person_pin_circle,size:62,color:Colors.blue),
                const SizedBox(height:10),
                TextField(
                  controller:input,
                  decoration:const InputDecoration(
                    labelText:'Enter your name',
                    prefixIcon:Icon(Icons.person),
                    border:OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height:12),
                FilledButton.icon(
                  onPressed:saveName,
                  icon:const Icon(Icons.save),
                  label:const Text('Save Name'),
                ),
                const SizedBox(height:20),
                if(savedName.isNotEmpty)Card(
                  color:Colors.blue.shade50,
                  child:ListTile(
                    leading:const CircleAvatar(child:Icon(Icons.check)),
                    title:const Text('Saved Name'),
                    subtitle:Text(savedName,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
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
