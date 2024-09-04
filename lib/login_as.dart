import 'package:flutter/material.dart';
import 'login_helper_page.dart';
import 'login_user_page.dart';


class LoginAs extends StatelessWidget {
  const LoginAs({super.key});

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
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/logo.png',
                            width: 300,
                            height: 250,
                          ),

                          Container(
                            child: const Text(
                              'حدد نوع المستخدم ؟',
                              style: TextStyle(color: Colors.black, fontSize: 20), // لون النص الخاص بالزر
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginUserPage()),
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
                              'مستخدم عادي',
                              style: TextStyle(color: Colors.white), // لون النص الخاص بالزر
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginHelperPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // لون الخلفية للزر
                              // padding: const EdgeInsets.symmetric(horizontal: 122, vertical: 15),
                              padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'مساعد',
                              style: TextStyle(color: Colors.white), // لون النص الخاص بالزر
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
