import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int? _selectedAnswerQ1;
  int? _selectedAnswerQ2;

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
        title: Text('Answer the questions:', style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Action when menu button is pressed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question 1
              _buildQuestionContainer(
                questionText: 'Q1 ?',
                selectedAnswer: _selectedAnswerQ1,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswerQ1 = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Question 2
              _buildQuestionContainer(
                questionText: 'Q2 ?',
                selectedAnswer: _selectedAnswerQ2,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswerQ2 = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Question 1 repeated
              _buildQuestionContainer(
                questionText: 'Q1 ?',
                selectedAnswer: _selectedAnswerQ1,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswerQ1 = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Button to show result
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    // Action when "Your mood is" button is pressed
                  },
                  child: Text('Your mood is:'),
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
          RadioListTile<int>(
            title: Text('Answer 1'),
            value: 1,
            groupValue: selectedAnswer,
            onChanged: onChanged,
          ),
          RadioListTile<int>(
            title: Text('Answer 2'),
            value: 2,
            groupValue: selectedAnswer,
            onChanged: onChanged,
          ),
          RadioListTile<int>(
            title: Text('Answer 3'),
            value: 3,
            groupValue: selectedAnswer,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
