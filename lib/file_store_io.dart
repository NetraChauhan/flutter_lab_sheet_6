import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStore{
  static Future<File> _file(String name)async{
    final dir=await getApplicationDocumentsDirectory();
    return File('${dir.path}/$name');
  }

  static Future<void> writeText(String name,String text)async{
    final file=await _file(name);
    await file.writeAsString(text);
  }

  static Future<String> readText(String name)async{
    final file=await _file(name);
    if(!await file.exists())return '';
    return file.readAsString();
  }
}
