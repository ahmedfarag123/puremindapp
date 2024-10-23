import 'package:flutter/material.dart';
import 'TestPage.dart'; // تأكد من استيراد TestPage

class TrackMoodStatusPage extends StatelessWidget {
  final String username; // إضافة اسم المستخدم

  const TrackMoodStatusPage({super.key, required this.username}); // استلام اسم المستخدم

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Mood Status')),
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
                          Container(
                            child: const Text(
                              'أختبر حالتك المزاجية الأن!',
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              // تمرير البريد الإلكتروني وكلمة المرور من الصفحة الرئيسية
                              String userEmail = "test@example.com"; // استخدم البريد الإلكتروني المناسب
                              String userPassword = "password123"; // استخدم كلمة المرور المناسبة

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestPage(
                                    email: userEmail, // تمرير البريد الإلكتروني
                                    password: userPassword, // تمرير كلمة المرور
                                    username: username, // تمرير اسم المستخدم
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'بدء الاختبار',
                              style: TextStyle(color: Colors.white),
                            ),
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
