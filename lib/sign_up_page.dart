import 'package:flutter/material.dart';
import 'login_user_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // لإخفاء لوحة المفاتيح عند النقر خارج الـTextField
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Opacity(
                  opacity: 1.0, // قيمة الشفافية بين 0.0 (شفاف تماماً) و 1.0 (غير شفاف)
                  child: Container(

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg.png'),
                        fit: BoxFit.cover, // تمدد الصورة لتغطية الحاوية بالكامل
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
                              hintText: 'اسم المستخدم',
                              hintStyle: TextStyle(
                                color: Colors.black45  , // لون النص
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
                            style: TextStyle(color: Colors.black ),
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
                                color: Colors.black45  , // لون النص
                                fontSize: 16, // حجم الخط
                                fontStyle: FontStyle.italic, // نمط الخط (اختياري)
                                fontWeight: FontWeight.normal, // وزن الخط (اختياري)
                              ),contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // التباعد العمودي والأفقي
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
                              hintText: 'تأكيد الرقم السري',
                              hintStyle: TextStyle(
                                color: Colors.black45  , // لون النص
                                fontSize: 16, // حجم الخط
                                fontStyle: FontStyle.italic, // نمط الخط (اختياري)
                                fontWeight: FontWeight.normal, // وزن الخط (اختياري)
                              ),contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // التباعد العمودي والأفقي
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
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('تم إنشاء الحساب بنجاح'),
                              ),
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const LoginPage()),
                            // );
                            // Handle sign up action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // لون الخلفية للزر
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                              'انشاء الحساب',
                            style: TextStyle(color: Colors.white),), // لون النص الخاص بالزر),
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
                                // Action for Google sign up
                              },
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.facebook, size: 50),
                              onPressed: () {
                                // Action for Facebook sign up
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 63), // تم تغيير هذا السطر
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
