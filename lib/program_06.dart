// 6. Save Dark Mode ON/OFF using Switch and SharedPreferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  bool dark=false;

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    setState(()=>dark=p.getBool('q6_dark')??false);
  }

  Future<void> change(bool v)async{
    final p=await SharedPreferences.getInstance();
    setState(()=>dark=v);
    await p.setBool('q6_dark',v);
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    themeMode:dark?ThemeMode.dark:ThemeMode.light,
    theme:ThemeData(colorSchemeSeed:Colors.purple,useMaterial3:true,brightness:Brightness.light),
    darkTheme:ThemeData(colorSchemeSeed:Colors.purple,useMaterial3:true,brightness:Brightness.dark),
    home:Scaffold(
      appBar:AppBar(title:const Text('Appearance Settings'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(26),
          child:SizedBox(
            width:500,
            child:Column(children:[
              Icon(dark?Icons.dark_mode:Icons.light_mode,size:70),
              const SizedBox(height:8),
              Text(
                dark?'Dark Mode is ON':'Dark Mode is OFF',
                style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold),
              ),
              const SizedBox(height:18),
              Card(
                child:SwitchListTile(
                  secondary:Icon(dark?Icons.nights_stay:Icons.wb_sunny),
                  title:const Text('Dark Mode'),
                  subtitle:const Text('Preference is saved automatically'),
                  value:dark,
                  onChanged:change,
                ),
              ),
            ]),
          ),
        ),
      ),
    ),
  );
}
