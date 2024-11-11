import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'educational_content_page.dart';
import 'consultant_content_page.dart';
import 'track_mood_status_page.dart';
import 'login_user_page.dart';
import 'messages.dart';

class UserHomePage extends StatefulWidget {
  final String email; // إضافة البريد الإلكتروني
  final String password; // إضافة كلمة المرور

  const UserHomePage({super.key, required this.email, required this.password});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String username = 'Loading...'; // قيمة افتراضية حتى يتم تحميل البيانات
  String selectedSubject = 'Select subject';

  @override
  void initState() {
    super.initState();
    loadUserData(); // استدعاء الدالة لتحميل بيانات المستخدم عند بدء الصفحة
  }

  // دالة لتحميل بيانات المستخدم من ملف JSON
  Future<void> loadUserData() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/users.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> users = json.decode(jsonString);

      // البحث عن المستخدم الذي يتطابق مع البريد الإلكتروني وكلمة المرور
      var matchedUser = users.firstWhere(
            (user) =>
        user['email'] == widget.email && user['password'] == widget.password,
        orElse: () => null,
      );

      if (matchedUser != null) {
        setState(() {
          username = matchedUser['username']; // تعيين اسم المستخدم
        });
      } else {
        setState(() {
          username = 'User not found'; // في حال لم يتم العثور على المستخدم
        });
      }
    }
  }

  // عملية تسجيل الخروج
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginUserPage()), // الانتقال إلى صفحة تسجيل الدخول
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحباً $username'),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagesPage(username: username)),
              );
            },
            tooltip: 'الرسائل',
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // عند النقر على زر تسجيل الخروج
            tooltip: 'تسجيل الخروج',
          ),
        ],
      ),
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
                    'assets/bg2.png',
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
                          const SizedBox(height: 10),
                          const SizedBox(height: 20),
                          DropdownButton<String>(
                            value: selectedSubject,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null && newValue != 'Select subject') {
                                selectedSubject = newValue;
                                _navigateToPage(context, newValue, username); // تمرير اسم المستخدم
                              }
                            },
                            items: <String>[
                              'Select subject',
                              'Educational content',
                              'Consultant content',
                              'Track mood status'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
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

  void _navigateToPage(BuildContext context, String subject, String username) {
    if (subject == 'Educational content') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EducationalContentPage(),
        ),
      );
    } else if (subject == 'Consultant content') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConsultantContentPage(),
        ),
      );
    } else if (subject == 'Track mood status') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackMoodStatusPage(username: username),
        ),
      );
    }
  }
}
