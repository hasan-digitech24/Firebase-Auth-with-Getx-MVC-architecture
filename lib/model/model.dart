// class UserAuth{
// String? email; 
// String? password;

// UserAuth({this.email, this.password});
// }

/* ismy model use nhi horha kiuky sara data firebase manage krrha hai hm reuest bhj rhy hain,
 firebase ko aur firebase hme response de rha hai to hmara model use nhi horha is case me 
but agar hm apne app me aur bhi data manage krna chahte hain to hm apna model create krke
 usme data store kr skte hain aur us data ko firebase ke sath sync krwa skte hain.*/
// jb hm apna data use krty hai tou model ky use hota hai

class TodoModel {
  final String id;
  final String title;
  final bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.isDone,
  });

  factory TodoModel.fromMap(String id, Map<String, dynamic> data) {
    return TodoModel(
      id: id,
      title: data['title'],
      isDone: data['isDone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}