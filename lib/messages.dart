import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MessagesPage extends StatefulWidget {
  final String username; // استقبال اسم المستخدم كمعامل

  MessagesPage({required this.username});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<String> _userMessages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/messages.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      Map<String, dynamic> messagesData = json.decode(jsonString);

      setState(() {
        _userMessages = List<String>.from(messagesData[widget.username] ?? []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الرسائل'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _userMessages.isEmpty
            ? Center(child: Text('لا توجد رسائل لهذا المستخدم'))
            : ListView.builder(
          itemCount: _userMessages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_userMessages[index]),
              leading: Icon(Icons.message),
            );
          },
        ),
      ),
    );
  }
}
