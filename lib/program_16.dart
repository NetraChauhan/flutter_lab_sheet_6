// 16. Notes app that saves notes to a JSON file and loads them on start.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'file_store.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final title=TextEditingController();
  final body=TextEditingController();
  List<Map<String,dynamic>> notes=[];

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final raw=await FileStore.readText('notes.json');
    if(raw.isEmpty)return;
    final data=jsonDecode(raw) as List;
    setState(()=>notes=data.map((e)=>Map<String,dynamic>.from(e)).toList());
  }

  Future<void> persist()async{
    await FileStore.writeText('notes.json',jsonEncode(notes));
  }

  Future<void> add()async{
    if(title.text.trim().isEmpty||body.text.trim().isEmpty)return;
    setState(()=>notes.add({
      'title':title.text.trim(),
      'body':body.text.trim(),
    }));
    title.clear();body.clear();
    await persist();
  }

  Future<void> remove(int i)async{
    setState(()=>notes.removeAt(i));
    await persist();
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.amber,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('JSON Notes'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:SizedBox(
          width:620,
          child:Padding(
            padding:const EdgeInsets.all(22),
            child:Column(children:[
              TextField(
                controller:title,
                decoration:const InputDecoration(
                  labelText:'Note title',
                  prefixIcon:Icon(Icons.title),
                  border:OutlineInputBorder(),
                ),
              ),
              const SizedBox(height:10),
              TextField(
                controller:body,
                minLines:2,
                maxLines:3,
                decoration:const InputDecoration(
                  labelText:'Note',
                  prefixIcon:Icon(Icons.notes),
                  border:OutlineInputBorder(),
                ),
              ),
              const SizedBox(height:10),
              SizedBox(
                width:double.infinity,
                child:FilledButton.icon(
                  onPressed:add,
                  icon:const Icon(Icons.note_add),
                  label:const Text('Save Note'),
                ),
              ),
              const SizedBox(height:14),
              Expanded(
                child:notes.isEmpty
                  ?const Center(child:Text('No notes saved yet'))
                  :ListView.builder(
                    itemCount:notes.length,
                    itemBuilder:(c,i)=>Card(
                      color:Colors.amber.shade50,
                      child:ListTile(
                        leading:const Icon(Icons.sticky_note_2),
                        title:Text(notes[i]['title'],style:const TextStyle(fontWeight:FontWeight.bold)),
                        subtitle:Text(notes[i]['body']),
                        trailing:IconButton(
                          icon:const Icon(Icons.delete_outline),
                          onPressed:()=>remove(i),
                        ),
                      ),
                    ),
                  ),
              ),
            ]),
          ),
        ),
      ),
    ),
  );
}
