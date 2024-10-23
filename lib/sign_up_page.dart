import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'login_user_page.dart';
import 'package:path_provider/path_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String userType = 'عادي'; // قيمة افتراضية

  Future<void> saveUserData(String email, String username, String password, String userType) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/users.json');

    List<Map<String, dynamic>> users = [];

    // إذا كان الملف موجودًا، قم بقراءة البيانات
    if (await file.exists()) {
      String jsonString = await file.readAsString();
      users = List<Map<String, dynamic>>.from(json.decode(jsonString));
    }

    // التحقق من عدم تكرار اسم المستخدم
    if (users.any((user) => user['username'] == username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('اسم المستخدم موجود بالفعل!')),
      );
      return; // الخروج من الدالة إذا كان اسم المستخدم موجودًا
    }

    // إضافة مستخدم جديد
    users.add({
      'email': email,
      'username': username,
      'password': password,
      'userType': userType,
      'tests': 0, // عدد الاختبارات
      'results': [] // نتائج الاختبارات
    });

    // حفظ البيانات في الملف
    await file.writeAsString(json.encode(users));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Opacity(
                  opacity: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 50),
                        Image.asset(
                          'assets/logo.png',
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 50,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'البريد الإلكتروني / الهاتف',
                              hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 50,
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: 'اسم المستخدم',
                              hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 50,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'الرقم السري',
                              hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 50,
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'تأكيد الرقم السري',
                              hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('مستخدم عادي'),
                            Radio<String>(
                              value: 'عادي',
                              groupValue: userType,
                              onChanged: (value) {
                                setState(() {
                                  userType = value!;
                                });
                              },
                            ),
                            Text('مساعد'),
                            Radio<String>(
                              value: 'مساعد',
                              groupValue: userType,
                              onChanged: (value) {
                                setState(() {
                                  userType = value!;
                                });
                              },
                            ),
                          ],
                        ),

                        ElevatedButton(
                          onPressed: () {
                            if (passwordController.text == confirmPasswordController.text) {
                              saveUserData(
                                emailController.text,
                                usernameController.text,
                                passwordController.text,
                                userType,
                              ).then((_) {
                                if (usernameController.text != '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('تم إنشاء الحساب بنجاح'),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginUserPage()),
                                  );
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تأكد من تطابق الرقم السري'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'انشاء الحساب',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginUserPage()),
                            );
                          },
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                      ],
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
