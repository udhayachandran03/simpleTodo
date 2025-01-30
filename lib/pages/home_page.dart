

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the box 

  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // local storage with the app 

    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }
  
  // text controller
  final _controller = TextEditingController();



// check box tapped
  void checkBoxChanged(bool? value , int index){    //without the value also working fine
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();

  }


  void saveNewTask(){
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

// create a new task
 void createNewTask(){
  showDialog(context: context, builder: (context) {
    return DialogBox(
      controller:_controller ,
      onSave: saveNewTask,
      onCancel: () {Navigator.of(context).pop();},
    );
  });
 }

//  deelte Task

void deleteTask(int index){
  setState(() {
    db.todoList.removeAt(index);
  });
  db.updateDataBase();
}




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:createNewTask,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        
        ),
        
        body: db.todoList.isEmpty ? 
        const Center(child: Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: Text("Create a New Task" ,style: TextStyle(fontSize: 20, color: Colors.black)),
        ),
        )
        : ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder:(context, index) {
          return TodoTile(
            taskName: db.todoList[index][0], 
            taskCompleted: db.todoList[index][1], 
            onChanged:(value) => checkBoxChanged(value , index), //without the value also working fine 
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
