import 'package:flutter/material.dart';
import 'package:todo_list/login_screen.dart';
import 'package:todo_list/model/Taskdao.dart';
import 'package:todo_list/model/User.dart';
import 'package:todo_list/model/Userdao.dart';
import 'package:todo_list/task_view.dart';

class Admin extends StatefulWidget {
  Admin({Key? key}) : super(key: key);
  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int isAdminCheckbox = 0;
  /*late int userId;
  @override
  void initState() {
    super.initState();
    userId = Provider.of<UserIdProvider>(context, listen: false).user_id!;
  }*/

  final todoController = TextEditingController();
  LoginScreen ls = LoginScreen();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                        child: Text("Hayır"),
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
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: IconButton(
                  icon: Icon(Icons.supervised_user_circle, size: 40),
                  alignment: Alignment.bottomLeft,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            title: Text("Kullancı Bilgilerini Giriniz"),
                            content: Column(
                              children: [
                                TextField(
                                  controller: loginController,
                                  decoration: InputDecoration(
                                    labelText: "Kullanıcı Adı",
                                  ),
                                ),
                                TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: "Şifre",
                                  ),
                                  obscureText: true,
                                ),
                                Row(
                                  children: [
                                    Text("Admin"),
                                    Checkbox(
                                      value: isAdminCheckbox == 1,
                                      onChanged: (value) {
                                        setState(() {
                                          isAdminCheckbox = value! ? 1 : 0;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text("Tamam"),
                                onPressed: () async {
                                  User user = await UserDao().addUser(
                                      loginController.text,
                                      passwordController.text,
                                      isAdminCheckbox);
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Admin(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                      },
                    );
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
