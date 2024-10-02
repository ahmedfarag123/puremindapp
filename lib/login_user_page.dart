import 'package:flutter/material.dart';
import 'UserHomePage.dart';
import 'HelperHomePage.dart'; // تأكد من استيراد الصفحة الصحيحة
import 'sign_up_page.dart';
import 'dart:convert'; // لإدارة ملفات JSON
import 'package:path_provider/path_provider.dart'; // للوصول إلى مسار تخزين الملفات
import 'dart:io'; // للتعامل مع الملفات

class LoginUserPage extends StatelessWidget {
  const LoginUserPage({super.key});

  // دالة لتحميل بيانات المستخدمين من ملف JSON
  Future<List<dynamic>> loadUserData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.json');

    // تحقق مما إذا كان الملف موجودًا
    if (await file.exists()) {
      String jsonString = await file.readAsString();
      return json.decode(jsonString); // تحويل JSON إلى قائمة
    }
    return []; // إذا لم يوجد بيانات
  }

  // دالة للتحقق من بيانات تسجيل الدخول
  Future<Map<String, dynamic>?> checkLogin(String email, String password) async {
    List<dynamic> users = await loadUserData();
    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        return user; // إرجاع بيانات المستخدم
      }
    }
    return null; // بيانات غير صحيحة
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                  child: Image.asset(
                    'assets/bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 60),
                          Image.asset(
                            'assets/logo.png',
                            width: 300,
                            height: 250,
                          ),

                          const SizedBox(height: 20),
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
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: 'الرقم السري',
                                hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                filled: true,
                                fillColor: Colors.white,
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
                              ),
                              style: TextStyle(color: Colors.black),
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();

                              // تحقق من بيانات تسجيل الدخول
                              Map<String, dynamic>? user = await checkLogin(email, password);

                              if (user != null) {
                                // تحقق من نوع المستخدم
                                if (user['userType'] == 'مساعد') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HelperHomePage(email: email, password: password), // تمرير القيم
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserHomePage(email: email, password: password), // تمرير القيم
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('البريد الإلكتروني أو الرقم السري غير صحيح'),
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
                              'تسجيل الدخول',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text(
                              'إنشاء حساب جديد',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.g_mobiledata, size: 50),
                                onPressed: () {
                                  // Action for Google login
                                },
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                icon: const Icon(Icons.facebook, size: 50),
                                onPressed: () {
                                  // Action for Facebook login
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
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
