// 11. Show a welcome screen only on first launch using SharedPreferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  bool? seen;

  @override
  void initState(){
    super.initState();
    check();
  }

  Future<void> check()async{
    final p=await SharedPreferences.getInstance();
    setState(()=>seen=p.getBool('q11_seen')??false);
  }

  Future<void> continueToHome()async{
    final p=await SharedPreferences.getInstance();
    await p.setBool('q11_seen',true);
    setState(()=>seen=true);
  }

  Future<void> resetDemo()async{
    final p=await SharedPreferences.getInstance();
    await p.setBool('q11_seen',false);
    setState(()=>seen=false);
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.cyan,useMaterial3:true),
    home:seen==null
      ?const Scaffold(body:Center(child:CircularProgressIndicator()))
      :seen!
        ?Scaffold(
          appBar:AppBar(title:const Text('Home'),centerTitle:true),
          body:Align(
            alignment:Alignment.topCenter,
            child:Padding(
              padding:const EdgeInsets.all(28),
              child:Column(
                mainAxisSize:MainAxisSize.min,
                children:[
                  const Icon(Icons.home_rounded,size:72,color:Colors.cyan),
                  const Text('Welcome Back',style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
                  const Text('The first-launch welcome screen is now skipped.'),
                  const SizedBox(height:18),
                  OutlinedButton.icon(
                    onPressed:resetDemo,
                    icon:const Icon(Icons.restart_alt),
                    label:const Text('Reset First Launch Demo'),
                  ),
                ],
              ),
            ),
          ),
        )
        :Scaffold(
          body:Container(
            width:double.infinity,
            padding:const EdgeInsets.all(32),
            color:Colors.cyan.shade50,
            child:Align(
              alignment:Alignment.topCenter,
              child:SizedBox(
                width:480,
                child:Column(
                  mainAxisSize:MainAxisSize.min,
                  children:[
                    const SizedBox(height:40),
                    const Icon(Icons.waving_hand,size:78,color:Colors.cyan),
                    const SizedBox(height:14),
                    const Text('Welcome!',style:TextStyle(fontSize:34,fontWeight:FontWeight.bold)),
                    const SizedBox(height:8),
                    const Text(
                      'This screen appears only on the first launch.',
                      textAlign:TextAlign.center,
                      style:TextStyle(fontSize:17),
                    ),
                    const SizedBox(height:22),
                    SizedBox(
                      width:double.infinity,
                      child:FilledButton(
                        onPressed:continueToHome,
                        child:const Text('Get Started'),
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
