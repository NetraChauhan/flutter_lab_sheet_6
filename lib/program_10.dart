// 10. Remove stored SharedPreferences data using a Clear button.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  String status='No demo data saved';

  Future<void> saveDemo()async{
    final p=await SharedPreferences.getInstance();
    await p.setString('q10_name','Tara Quinn');
    await p.setInt('q10_level',6);
    setState(()=>status='Demo data saved');
  }

  Future<void> clearData()async{
    final p=await SharedPreferences.getInstance();
    await p.remove('q10_name');
    await p.remove('q10_level');
    setState(()=>status='Stored data cleared');
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.red,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Clear Stored Data'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(28),
          child:SizedBox(
            width:460,
            child:Column(children:[
              Container(
                width:double.infinity,
                padding:const EdgeInsets.all(20),
                decoration:BoxDecoration(
                  color:Colors.red.shade50,
                  borderRadius:BorderRadius.circular(18),
                ),
                child:Column(children:[
                  const Icon(Icons.storage,size:55,color:Colors.red),
                  const SizedBox(height:8),
                  const Text('SharedPreferences Storage',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
                  const SizedBox(height:8),
                  Text(status),
                ]),
              ),
              const SizedBox(height:18),
              Row(children:[
                Expanded(
                  child:FilledButton.icon(
                    onPressed:saveDemo,
                    icon:const Icon(Icons.save),
                    label:const Text('Save Demo Data'),
                  ),
                ),
                const SizedBox(width:10),
                Expanded(
                  child:OutlinedButton.icon(
                    onPressed:clearData,
                    icon:const Icon(Icons.delete_outline),
                    label:const Text('Clear Data'),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    ),
  );
}
