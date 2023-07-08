class ToDo {
  String? id;
  String? todoText;
  bool? isDone;
  String? accountid;

  ToDo({
    this.id,
    this.todoText,
    this.accountid,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Kahvaltı', isDone: true),
      ToDo(id: '02', todoText: 'Alışveriş', isDone: true),
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
  }
}
