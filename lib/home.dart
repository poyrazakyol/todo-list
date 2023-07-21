import 'package:flutter/material.dart';
import 'package:todo_list/login_screen.dart';
import 'package:todo_list/model/Taskdao.dart';
import 'package:todo_list/task_view.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoController = TextEditingController();
  LoginScreen ls = LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.person_2_outlined, size: 30),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app_outlined, size: 30),
              color: Colors.black,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Çıkış Yap"),
                    content: Text("Çıkış Yapmak İstediğine Emin Misin?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Hayır"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: Text("Evet"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 45),
              child: TaskView(),
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
    await TaskDao().addTask(toDo);
    setState(() {});
  }
}
