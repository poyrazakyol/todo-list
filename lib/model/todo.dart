class ToDo {
  int? id;
  String? todoText;
  int? isDone;
  String? accountid;

  ToDo({
    this.id,
    this.todoText,
    this.accountid,
    this.isDone = 1,
  });

  /*static List<ToDo> todoList() {
    return [
      ToDo(id: 1, todoText: 'Kahvaltı', isDone: true),
      ToDo(id: 1, todoText: 'Alışveriş', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Mail Kontrolü',
      ),
      ToDo(
        id: '04',
        todoText: 'Toplantı',
      ),
      ToDo(
        id: '05',
        todoText: 'Flutter Çalışması',
      ),
    ];
  }*/
}
