// 12. Write text into a file in the app documents directory using path_provider.
import 'package:flutter/material.dart';
import 'file_store.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final text=TextEditingController();
  String status='Nothing saved yet';

  Future<void> save()async{
    final value=text.text.trim();
    if(value.isEmpty)return;
    await FileStore.writeText('note.txt',value);
    setState(()=>status='Text saved successfully to note.txt');
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.blueGrey,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Write to File'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(24),
          child:SizedBox(
            width:560,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children:[
                const Text('Create a File Note',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold)),
                const SizedBox(height:6),
                const Text('The text is written to note.txt in the app documents storage.'),
                const SizedBox(height:18),
                TextField(
                  controller:text,
                  minLines:5,
                  maxLines:7,
                  decoration:const InputDecoration(
                    hintText:'Type something to save...',
                    alignLabelWithHint:true,
                    labelText:'File Content',
                    border:OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height:12),
                FilledButton.icon(
                  onPressed:save,
                  icon:const Icon(Icons.save),
                  label:const Text('Write File'),
                ),
                const SizedBox(height:18),
                Card(
                  color:Colors.blueGrey.shade50,
                  child:ListTile(
                    leading:const Icon(Icons.description),
                    title:const Text('note.txt'),
                    subtitle:Text(status),
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
