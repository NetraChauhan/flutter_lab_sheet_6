// 5. Store and retrieve an integer counter using SharedPreferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  int count=0;

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    setState(()=>count=p.getInt('q5_counter')??0);
  }

  Future<void> add()async{
    final p=await SharedPreferences.getInstance();
    setState(()=>count++);
    await p.setInt('q5_counter',count);
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.orange,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Persistent Counter'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(28),
          child:Container(
            width:380,
            padding:const EdgeInsets.all(26),
            decoration:BoxDecoration(
              color:Colors.orange.shade50,
              borderRadius:BorderRadius.circular(24),
            ),
            child:Column(
              mainAxisSize:MainAxisSize.min,
              children:[
                const Icon(Icons.save_alt,size:50,color:Colors.orange),
                const Text('Saved Counter',style:TextStyle(fontSize:20)),
                Text('$count',style:const TextStyle(fontSize:60,fontWeight:FontWeight.bold)),
                const Text('This value stays after reopening the app'),
                const SizedBox(height:18),
                FilledButton.icon(
                  onPressed:add,
                  icon:const Icon(Icons.add),
                  label:const Text('Increase & Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
