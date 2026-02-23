import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_getx_mvc/model/model.dart';
import 'package:firebase_auth_getx_mvc/views/Login_screen.dart';
import 'package:firebase_auth_getx_mvc/views/home_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  // function to register user
  Future<void> registerUser(String userEmail, String userPassword) async {
    try {
      isLoading.value = true;
      await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      Get.snackbar('Register Successfull', 'You have successfully registered');
      // get.off push replacement wala kaam krta hai, jese hi user register ho jata hai wo login screen pe chala jata hai aur back press karne pe wo wapis register screen pe nhi aayega
      Get.off(LoginScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  // function to login user
  Future<void> loginUser(String userEmail, String userPassword) async {
    try {
      isLoading.value = true;
      await auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      Get.snackbar('Login Successfull', 'You have successfully logged in');
                                Get.to(() => HomeScreen());

    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }
}


// theme controller
class ThemeController extends GetxController {
    RxBool isLightMode = true.obs;

  
}


// todo controller
class TodoController extends GetxController {
  RxList<TodoModel> todos = <TodoModel>[].obs;

  @override
  onInit() {
    super.onInit();
    fetchTodos();
  }
  
  
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> addTodo(String title) async {
  if (title.trim().isEmpty) return;

 await fireStore.collection('todos').add( 
    {
      'title': title,
      'isDone': false,
    },
  );
}

void fetchTodos() {
  fireStore.collection('todos').snapshots().listen((snapshot) {
    todos.value = snapshot.docs.map((doc) {
      return TodoModel.fromMap(doc.id, doc.data());
    }).toList();
  });
}

Future<void> toggleTodo(TodoModel todo) async {
  await fireStore
      .collection('todos')
      .doc(todo.id)
      .update({'isDone': !todo.isDone});
}

Future<void> deleteTodo(String id) async {
  await fireStore.collection('todos').doc(id).delete();
}

}
