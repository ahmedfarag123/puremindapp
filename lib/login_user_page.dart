import 'package:flutter/material.dart';
import 'UserHomePage.dart';
import 'sign_up_page.dart';

class LoginUserPage extends StatelessWidget {
  const LoginUserPage({super.key});

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
                          Container(
                            child: const Text(
                              'تسجيل الدخول كمستخدم عادي',
                              style: TextStyle(color: Colors.black, fontSize: 15), // لون النص الخاص بالزر
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 300,
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'البريد الإلكتروني / الهاتف',
                                hintStyle: TextStyle(
                                  color: Colors.black45 , // لون النص
                                  fontSize: 16, // حجم الخط
                                  fontStyle: FontStyle.italic, // نمط الخط (اختياري)
                                  fontWeight: FontWeight.normal, // وزن الخط (اختياري)
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // التباعد العمودي والأفقي
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.green  , // لون الحدود عندما يكون TextField مفعلاً
                                    width: 2.0,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white, // لون الخلفية الأساسي
                              ),
                              style: TextStyle(color: Colors.black ), // لون النص المدخل
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 300,
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'الرقم السري',
                                hintStyle: TextStyle(
                                  color: Colors.black45 , // لون النص
                                  fontSize: 16, // حجم الخط
                                  fontStyle: FontStyle.italic, // نمط الخط (اختياري)
                                  fontWeight: FontWeight.normal, // وزن الخط (اختياري)
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // التباعد العمودي والأفقي
                                filled: true,
                                fillColor: Colors.white , // لون الخلفية الأساسي
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.green , // لون الحدود عندما يكون TextField مفعلاً
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              style: TextStyle(color: Colors.black), // لون النص المدخل
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserHomePage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // لون الخلفية للزر
                              // padding: const EdgeInsets.symmetric(horizontal: 122, vertical: 15),
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(color: Colors.white), // لون النص الخاص بالزر
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
                              // 'Create account now!',
                              'إنشاء حساب جديد',
                              style: TextStyle(
                                color: Colors.blue,
                                // decoration: TextDecoration.underline,
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
                          const SizedBox(height: 20), // لتجنب المساحة البيضاء في الأسفل
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
