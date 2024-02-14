import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_new/ViewModel/todos_viewmodel.dart';
import 'package:todo_new/utilities/custom_textfield.dart';
import 'package:todo_new/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({super.key, this.textController});

  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    final todoProvider = Provider.of<ToDosViewModel>(context, listen: false);
    return Dialog(
      backgroundColor: Colors.deepPurple[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: sh * 0.5,
        width: sw * 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "New Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "What has to be done?",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Add New Task',
                onChanged: (value) {
                  todoProvider.setTodoName(value);
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Due Date",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Enter Date",
                controller: todoProvider.todoDateCont,
                readOnly: true,
                icon: Icons.calendar_month,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2017),
                      lastDate: DateTime(2030));
                  todoProvider.setTodoDate(date);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    text: "Save",
                    onPressed: () {
                      todoProvider.addTodo();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MyButton(
                    text: "Cancel",
                    onPressed: () {
                      todoProvider.todoDateCont.clear();
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
