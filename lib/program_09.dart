// 9. Store and display a list of favourite subjects using SharedPreferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final all=['Flutter','DBMS','Networking','Python','UI/UX','Data Structures'];
  List<String> selected=[];

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    setState(()=>selected=p.getStringList('q9_subjects')??[]);
  }

  Future<void> toggle(String s)async{
    setState((){
      selected.contains(s)?selected.remove(s):selected.add(s);
    });
    final p=await SharedPreferences.getInstance();
    await p.setStringList('q9_subjects',selected);
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.pink,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Favourite Subjects'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:Padding(
          padding:const EdgeInsets.all(24),
          child:SizedBox(
            width:560,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                const Text('Choose your favourites',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
                const Text('Selections are saved automatically.'),
                const SizedBox(height:16),
                Wrap(
                  spacing:10,
                  runSpacing:10,
                  children:all.map((s)=>FilterChip(
                    label:Text(s),
                    selected:selected.contains(s),
                    onSelected:(_)=>toggle(s),
                  )).toList(),
                ),
                const SizedBox(height:22),
                Card(
                  color:Colors.pink.shade50,
                  child:Padding(
                    padding:const EdgeInsets.all(16),
                    child:Row(children:[
                      const Icon(Icons.favorite,color:Colors.pink),
                      const SizedBox(width:12),
                      Expanded(
                        child:Text(
                          selected.isEmpty?'No subjects selected':selected.join(' • '),
                          style:const TextStyle(fontSize:16,fontWeight:FontWeight.w600),
                        ),
                      ),
                    ]),
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
