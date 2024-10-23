import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Used to load assets
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'result_test_page.dart';

class TestPage extends StatefulWidget {
  final String email;
  final String password;

  TestPage({required this.email, required this.password});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<dynamic>? allQuestions;
  List<dynamic>? selectedQuestions;
  Map<int, int?> selectedAnswers = {};
  String username = 'Loading...'; // قيمة افتراضية حتى يتم تحميل البيانات
  int testCount = 0; // عدد مرات إجراء الاختبار

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    loadUserData(); // تحميل بيانات المستخدم عند بدء الصفحة
  }

  Future<void> _loadQuestions() async {
    // Load JSON from the assets
    String data = await rootBundle.loadString('assets/questions.json');
    setState(() {
      allQuestions = json.decode(data);
      _selectRandomQuestions(); // اختيار الأسئلة العشوائية
    });
  }

  void _selectRandomQuestions() {
    if (allQuestions != null && allQuestions!.length > 10) {
      final random = Random();
      selectedQuestions = [];
      Set<int> usedIndexes = Set<int>();

      while (selectedQuestions!.length < 10) {
        int randomIndex = random.nextInt(allQuestions!.length);
        if (!usedIndexes.contains(randomIndex)) {
          selectedQuestions!.add(allQuestions![randomIndex]);
          usedIndexes.add(randomIndex);
        }
      }
    } else {
      // في حالة كانت الأسئلة أقل من 10، قم بعرض كل الأسئلة المتاحة
      selectedQuestions = allQuestions;
    }
  }

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
          testCount = matchedUser['testCount'] ?? 0; // تحميل عدد مرات الاختبار
        });
      } else {
        setState(() {
          username = '1'; // في حال لم يتم العثور على المستخدم
        });
      }
    }
  }

  Future<void> saveTestResult(int score) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/users.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> users = json.decode(jsonString);

      var matchedUserIndex = users.indexWhere(
              (user) => user['email'] == widget.email && user['password'] == widget.password);

      if (matchedUserIndex != -1) {
        users[matchedUserIndex]['testCount'] = (testCount + 1); // زيادة عدد مرات الاختبار
        users[matchedUserIndex]['testResults'] = [
          ...(users[matchedUserIndex]['testResults'] ?? []),
          {
            'score': score,
            'date': DateTime.now().toIso8601String(),
          }
        ];

        await file.writeAsString(json.encode(users));
      }
    }
  }

  bool _allQuestionsAnswered() {
    return selectedAnswers.length == selectedQuestions!.length &&
        selectedAnswers.values.every((answer) => answer != null);
  }

  int _calculateScore() {
    int score = 0;
    for (var i = 0; i < selectedQuestions!.length; i++) {
      if (selectedAnswers[i] == selectedQuestions![i]['correctAnswer']) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('مرحباً $username'),
      ),
      body: selectedQuestions == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...selectedQuestions!.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> question = entry.value;

                return Column(
                  children: [
                    _buildQuestionContainer(
                      questionText: question['question'],
                      answers: question['answers'],
                      selectedAnswer: selectedAnswers[index],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswers[index] = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _allQuestionsAnswered()
                        ? Colors.green
                        : Colors.grey,
                    padding: EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: _allQuestionsAnswered()
                      ? () async {
                    int score = _calculateScore();
                    await saveTestResult(score); // حفظ نتيجة الاختبار

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultTestPage(
                          selectedAnswers: selectedAnswers,
                          questions: selectedQuestions!,
                          username: username,
                        ),
                      ),
                    );
                  }
                      : null,
                  child: Text('عرض النتيجة'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContainer({
    required String questionText,
    required List<dynamic> answers,
    int? selectedAnswer,
    required ValueChanged<int?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...answers.asMap().entries.map((entry) {
            int index = entry.key;
            String answer = entry.value;
            return RadioListTile<int?>(
              title: Text(answer),
              value: index,
              groupValue: selectedAnswer,
              onChanged: onChanged,
            );
          }).toList(),
        ],
      ),
    );
  }
}
