import 'package:flutter/material.dart';
import 'TestPage.dart';

class TrackMoodStatusPage extends StatelessWidget {
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
                              style: TextStyle(color: Colors.black, fontSize: 20), // لون النص الخاص بالزر
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TestPage()),
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
                              'بدء الاختبار',
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
