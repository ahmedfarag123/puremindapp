import 'package:flutter/material.dart';
import 'educational_content_page.dart';
import 'consultant_content_page.dart';
import 'track_mood_status_page.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedSubject = 'Select subject';

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
                          Container(
                            child: const Text(
                              'Welcome Ahmed!',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
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
                                _navigateToPage(context, newValue);
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

  void _navigateToPage(BuildContext context, String subject) {
    if (subject == 'Educational content') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EducationalContentPage()),
      );
    } else if (subject == 'Consultant content') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConsultantContentPage()),
      );
    } else if (subject == 'Track mood status') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrackMoodStatusPage()),
      );
    }
  }
}
