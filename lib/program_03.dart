// 3. Convert Map to JSON string and JSON string back to Map using dart:convert.
import 'dart:convert';
import 'package:flutter/material.dart';
void main()=>runApp(const App());

class App extends StatelessWidget{
  const App({super.key});
  Widget build(c){
    final data={'name':'Kabir Rowan','course':'B.Tech','semester':5};
    final jsonText=jsonEncode(data);
    final decoded=jsonDecode(jsonText) as Map<String,dynamic>;

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData(colorSchemeSeed:Colors.deepOrange,useMaterial3:true),
      home:Scaffold(
        appBar:AppBar(title:const Text('JSON Conversion'),centerTitle:true),
        body:Align(
          alignment:Alignment.topCenter,
          child:Padding(
            padding:const EdgeInsets.all(24),
            child:SizedBox(
              width:620,
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.stretch,
                children:[
                  const Text('Map → JSON → Map',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
                  const SizedBox(height:18),
                  _Panel('Original Map',data.toString(),Icons.table_rows),
                  const SizedBox(height:12),
                  _Panel('JSON String',jsonText,Icons.code),
                  const SizedBox(height:12),
                  _Panel('Decoded Map',decoded.toString(),Icons.restart_alt),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget{
  final String title,text; final IconData icon;
  const _Panel(this.title,this.text,this.icon);
  Widget build(c)=>Container(
    padding:const EdgeInsets.all(18),
    decoration:BoxDecoration(
      color:Colors.deepOrange.shade50,
      borderRadius:BorderRadius.circular(16),
      border:Border.all(color:Colors.deepOrange.shade100),
    ),
    child:Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Icon(icon,color:Colors.deepOrange,size:30),
        const SizedBox(width:14),
        Expanded(child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            Text(title,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:18)),
            const SizedBox(height:5),
            SelectableText(text),
          ],
        )),
      ],
    ),
  );
}
