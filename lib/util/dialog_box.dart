import 'package:flutter/material.dart';
import 'package:todo/util/my_button.dart';

class DialogBox extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({super.key , required this.controller ,required this.onSave , required this.onCancel });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      content:  SizedBox(
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new Task"
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // save button
                  MyButton(text: "Save", onPressed:onSave),

                 const SizedBox(width: 50,),
                  //cancel button
                  MyButton(text: "Cancel", onPressed: () {
                     controller.clear(); // Clear the input when the cancel button is pressed
                     onCancel();
                  }),
                  
                ],
              )
          ],
        ),
          
    
      ),
    );
  }
}