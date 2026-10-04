import 'package:shared_preferences/shared_preferences.dart';

class FileStore{
  static Future<void> writeText(String name,String text)async{
    final p=await SharedPreferences.getInstance();
    await p.setString('web_file_$name',text);
  }

  static Future<String> readText(String name)async{
    final p=await SharedPreferences.getInstance();
    return p.getString('web_file_$name')??'';
  }
}
