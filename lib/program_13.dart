// 13. Read text from a stored file and display it on screen.
import 'package:flutter/material.dart';
import 'file_store.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  String content='';

  @override
  void initState(){
    super.initState();
    read();
  }

  Future<void> read()async{
    final value=await FileStore.readText('note.txt');
    setState(()=>content=value);
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.green,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Read Stored File'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(26),
          child:SizedBox(
            width:560,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children:[
                Container(
                  padding:const EdgeInsets.all(18),
                  decoration:BoxDecoration(
                    color:Colors.green.shade50,
                    borderRadius:BorderRadius.circular(18),
                  ),
                  child:const Row(children:[
                    Icon(Icons.folder_open,size:42,color:Colors.green),
                    SizedBox(width:12),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children:[
                        Text('note.txt',style:TextStyle(fontSize:21,fontWeight:FontWeight.bold)),
                        Text('Loaded from stored file'),
                      ],
                    ),
                  ]),
                ),
                const SizedBox(height:18),
                Card(
                  child:Padding(
                    padding:const EdgeInsets.all(20),
                    child:Text(
                      content.isEmpty?'No saved text found. Run Question 12 and save a note first.':content,
                      style:const TextStyle(fontSize:18,height:1.5),
                    ),
                  ),
                ),
                const SizedBox(height:12),
                OutlinedButton.icon(
                  onPressed:read,
                  icon:const Icon(Icons.refresh),
                  label:const Text('Read Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
