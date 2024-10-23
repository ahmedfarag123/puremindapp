import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'SuggestionsPage.dart';

class ResultTestPage extends StatelessWidget {
  final Map<int, int?> selectedAnswers;
  final List<dynamic> questions;
  final String username; // تمرير اسم المستخدم

  ResultTestPage({required this.selectedAnswers, required this.questions, required this.username});

  double calculateScore() {
    int totalQuestions = questions.length;
    int positiveAnswers = selectedAnswers.values
        .where((value) => value == 2) // Consider "لا أوافق" or positive answers as index 2
        .length;
    return (positiveAnswers / totalQuestions) * 100;
  }

  Future<void> saveResultToFile(double score, String username) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> users = json.decode(jsonString);

      // البحث عن المستخدم بناءً على الاسم
      final user = users.firstWhere((user) => user['username'] == username, orElse: () => null);

      if (user != null) {
        // تحديث البيانات الخاصة بعدد الاختبارات والنتائج
        user['tests'] = (user['tests'] ?? 0) + 1;
        user['results'] = (user['results'] ?? [])..add({
          'score': score,
          'date': DateTime.now().toIso8601String(),
        });

        // كتابة البيانات المعدلة إلى الملف
        await file.writeAsString(json.encode(users));

        // طباعة البيانات المعدلة في الـ console
        print('تم تحديث البيانات للمستخدم: $username');
        print('عدد الاختبارات: ${user['tests']}');
        print('النتائج: ${user['results']}');
      } else {
        // إذا لم يتم العثور على المستخدم، يمكننا إضافة مستخدم جديد
        users.add({
          'username': username,
          'email': '', // يمكنك إضافة البريد الإلكتروني إذا كان موجودًا
          'password': '', // يمكنك إضافة كلمة المرور إذا كانت موجودة
          'tests': 1,
          'results': [
            {
              'score': score,
              'date': DateTime.now().toIso8601String(),
            }
          ]
        });
        await file.writeAsString(json.encode(users));

        // طباعة البيانات الجديدة في الـ console
        print('تم إضافة مستخدم جديد: $username');
        print('عدد الاختبارات: 1');
        print('النتائج: ${users.last['results']}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    double score = calculateScore();
    saveResultToFile(score, username); // يجب أن يكون هنا، لكن نحتاج لانتظار الدالة

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                score >= 50
                    ? 'حالتك المزاجية الأن جيدة'
                    : 'حالتك المزاجية ليست جيدة',
                style: TextStyle(
                  fontSize: 32,
                  color: score >= 50 ? Colors.blue : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Slider(
                value: score / 100,
                onChanged: null, // Slider is disabled
                min: 0,
                max: 1,
                activeColor: score >= 50 ? Colors.blue : Colors.red,
                inactiveColor: Colors.grey[300],
              ),
              Text(
                '${score.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  score >= 50
                      ? 'إليك بعض الاقتراحات لتعزيز سعادتك. حسّن مزاجك وستشعر بتحسن أكبر!'
                      : 'يجب أن تفكر في الاهتمام أكثر بصحتك النفسية. لا تتردد في طلب المساعدة إذا لزم الأمر.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SuggestionsPage(score: score), // تمرير النتيجة
                    ),
                  );
                },
                child: Text(
                  'أبدأ',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//......................