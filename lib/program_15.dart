// 15. Persistent To-Do app using SharedPreferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()=>runApp(const App());

class App extends StatefulWidget{
  const App({super.key});
  State<App> createState()=>_S();
}

class _S extends State<App>{
  final input=TextEditingController();
  List<String> tasks=[];

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load()async{
    final p=await SharedPreferences.getInstance();
    setState(()=>tasks=p.getStringList('q15_tasks')??[
      'Review Flutter notes',
      'Complete lab record',
    ]);
  }

  Future<void> persist()async{
    final p=await SharedPreferences.getInstance();
    await p.setStringList('q15_tasks',tasks);
  }

  Future<void> add()async{
    final t=input.text.trim();
    if(t.isEmpty)return;
    setState(()=>tasks.add(t));
    input.clear();
    await persist();
  }

  Future<void> remove(int i)async{
    setState(()=>tasks.removeAt(i));
    await persist();
  }

  Widget build(c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    theme:ThemeData(colorSchemeSeed:Colors.orange,useMaterial3:true),
    home:Scaffold(
      appBar:AppBar(title:const Text('Persistent To-Do'),centerTitle:true),
      body:Align(
        alignment:Alignment.topCenter,
        child:SizedBox(
          width:560,
          child:Padding(
            padding:const EdgeInsets.all(22),
            child:Column(children:[
              Row(children:[
                Expanded(
                  child:TextField(
                    controller:input,
                    onSubmitted:(_)=>add(),
                    decoration:const InputDecoration(
                      labelText:'New task',
                      prefixIcon:Icon(Icons.edit_note),
                      border:OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width:10),
                FilledButton.icon(
                  onPressed:add,
                  icon:const Icon(Icons.add),
                  label:const Text('Add'),
                ),
              ]),
              const SizedBox(height:16),
              Align(
                alignment:Alignment.centerLeft,
                child:Text(
                  '${tasks.length} saved task${tasks.length==1?'':'s'}',
                  style:const TextStyle(fontWeight:FontWeight.bold),
                ),
              ),
              const SizedBox(height:8),
              Expanded(
                child:tasks.isEmpty
                  ?const Center(child:Text('No tasks yet'))
                  :ListView.builder(
                    itemCount:tasks.length,
                    itemBuilder:(c,i)=>Card(
                      child:ListTile(
                        leading:const CircleAvatar(child:Icon(Icons.check)),
                        title:Text(tasks[i]),
                        subtitle:const Text('Saved automatically'),
                        trailing:IconButton(
                          icon:const Icon(Icons.delete_outline,color:Colors.red),
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
