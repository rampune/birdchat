import 'package:hive/hive.dart';
import 'package:work_manager/config/string.dart';

class MyHiveBox{
  MyHiveBox._private();
 static MyHiveBox instance=MyHiveBox._private();
  factory MyHiveBox()=>instance;
  Box<dynamic> getBox(){
  return  Hive.box(AppStr.hiveBoxName);
  }
}