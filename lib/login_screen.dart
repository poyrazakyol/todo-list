import 'package:flutter/material.dart';
import 'package:todo_list/home.dart';

class LoginScreen extends StatelessWidget {
  final String validEmail = 'poyrazakyol';
  final String validPassword = '123456';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    if (enteredEmail == validEmail && enteredPassword == validPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Hata'),
          content: Text('Geçersiz E-Posta veya Şifre'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYukseligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: Colors.orange[400],
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text('ToDo List')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: ekranYukseligi / 20),
                child: SizedBox(
                    width: ekranGenisligi / 4,
                    height: ekranYukseligi / 6,
                    child: Image.asset("images/todologo.png")),
              ),
              Padding(
                padding: EdgeInsets.all(ekranYukseligi / 30),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'E-Posta',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(ekranYukseligi / 30),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Şifre',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(ekranYukseligi / 30),
                child: SizedBox(
                  width: ekranGenisligi / 1.2,
                  height: ekranYukseligi / 12,
                  child: ElevatedButton(
                    onPressed: () => _login(context),
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(fontSize: ekranGenisligi / 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
