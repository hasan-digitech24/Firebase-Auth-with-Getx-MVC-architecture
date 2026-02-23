import 'package:firebase_auth_getx_mvc/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});



  // Inject controller
  final TodoController controller = Get.put(TodoController());

  // TextField controller
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Todo App"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // 🔹 ADD TODO SECTION
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: "Enter your todo",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.add, size: 30),
                  onPressed: () {
                    controller.addTodo(titleController.text);
                    titleController.clear();
                  },
                ),
              ],
            ),
          ),

          // 🔹 TODO LIST
          Expanded(
            child: Obx(() {
              if (controller.todos.isEmpty) {
                return const Center(
                  child: Text(
                    "No Todos Yet",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          controller.toggleTodo(todo);
                        },
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.deleteTodo(todo.id);
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}