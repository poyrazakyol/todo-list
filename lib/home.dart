import 'package:flutter/material.dart';
import 'package:todo_list/model/dao.dart';
import 'package:todo_list/note_view.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final todosList = ToDo.todoList();
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            Center(child: Text("poyrazakyol")),
            GestureDetector(
              onTap: _showPhoto,
              child: Container(
                height: 40,
                width: 40,
                child: Image.asset('images/bne.png'),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 45),
              child:
                  NotesView(), /*Column(
                children: [
                  Expanded(
                    child:
                         ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: Text(
                            'Yapılacaklar',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (ToDo todoo in todosList)
                          todoItem(
                            todo: todoo,
                            toDoChanged: toDoChange,
                            deleteItem: deleteItem,
                          ),
                      ],
                    ),
                  ),
                ],
              ),*/
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: "Yeni Yapılacak Ekle",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    addItem(todoController.text);
                    todoController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Future<void> addItem(String toDo) async {
    await ToDoDao().addNote("1", toDo, 0);
    setState(() {});
  }

  Future<void> _showPhoto() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: OvalBorder(),
            backgroundColor: Colors.orange[300],
            content: Image.asset("images/bne.png"),
          );
        });
  }
}
