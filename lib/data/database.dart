import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List todoList = [];
  // reference our box 
  final _myBox = Hive.box("mybox");

  void createInitialData(){
    todoList = [];
  }

  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  void updateDataBase(){
    _myBox.put("TODOLIST", todoList);
  }
}