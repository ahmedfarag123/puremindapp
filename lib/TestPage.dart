import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Used to load assets
import 'result_test_page.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<dynamic>? questions;
  Map<int, int?> selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    // Load JSON from the assets
    String data = await rootBundle.loadString('assets/questions.json');
    setState(() {
      questions = json.decode(data);
    });
  }

  bool _allQuestionsAnswered() {
    // تحقق إذا كانت جميع الأسئلة تمت الإجابة عليها
    return selectedAnswers.length == questions!.length && selectedAnswers.values.every((answer) => answer != null);
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
        title: Text('أجب على الأسئلة الآتية:', style: TextStyle(fontSize: 18)),
      ),
      body: questions == null
          ? Center(child: CircularProgressIndicator()) // Show loading indicator until data is loaded
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...questions!.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> question = entry.value;

                // Return each question and a SizedBox for spacing
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
                    SizedBox(height: 16), // Add spacing between questions
                  ],
                );
              }).toList(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _allQuestionsAnswered() ? Colors.green : Colors.grey, // Change color based on state
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: _allQuestionsAnswered()
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultTestPage()),
                    );
                  }
                      : null, // Disable button if not all questions are answered
                  child: Text('حالتك الزاجية الأن:'),
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
    required int? selectedAnswer,
    required ValueChanged<int?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
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
            return RadioListTile<int>(
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
