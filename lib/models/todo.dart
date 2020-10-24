class Todo {
  final int id;
  final int taskId;
  final String title;
  final int isDone;
  final int prix;
  Todo({this.id, this.taskId ,this.title, this.isDone,this.prix});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'taskId':taskId,
      'title': title,
      'isDone': isDone,
      'prix': prix,
    };
  }


}