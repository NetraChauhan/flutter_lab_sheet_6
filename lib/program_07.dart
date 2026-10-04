// 7. Implement Remember Me checkbox on login screen using SharedPreferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final user=TextEditingController();
  final pass=TextEditingController();
  bool remember=false;
  String status='';

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    final r=p.getBool('q7_remember')??false;
    setState((){
      remember=r;
      if(r)user.text=p.getString('q7_user')??'';
    });
  }

  Future<void> login()async{
    final p=await SharedPreferences.getInstance();
    await p.setBool('q7_remember',remember);
    if(remember)await p.setString('q7_user',user.text.trim());
    else await p.remove('q7_user');
    setState(()=>status='Login preference saved');
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.indigo,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Login'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(28),
          child:SizedBox(
            width:420,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children:[
                const Icon(Icons.lock_outline,size:62,color:Colors.indigo),
                const SizedBox(height:16),
                TextField(
                  controller:user,
                  decoration:const InputDecoration(
                    labelText:'Username',
                    prefixIcon:Icon(Icons.person),
                    border:OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height:12),
                TextField(
                  controller:pass,
                  obscureText:true,
                  decoration:const InputDecoration(
                    labelText:'Password',
                    prefixIcon:Icon(Icons.lock),
                    border:OutlineInputBorder(),
                  ),
                ),
                CheckboxListTile(
                  contentPadding:EdgeInsets.zero,
                  value:remember,
                  onChanged:(v)=>setState(()=>remember=v??false),
                  title:const Text('Remember Me'),
                  subtitle:const Text('Keep my username for next time'),
                ),
                FilledButton(onPressed:login,child:const Text('Login')),
                if(status.isNotEmpty)Padding(
                  padding:const EdgeInsets.only(top:14),
                  child:Text(status,textAlign:TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
