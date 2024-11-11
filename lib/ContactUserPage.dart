import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ContactUserPage extends StatefulWidget {
  @override
  _ContactUserPageState createState() => _ContactUserPageState();
}

class _ContactUserPageState extends State<ContactUserPage> {
  String? _selectedUser;
  final TextEditingController _messageController = TextEditingController();
  List<String> _regularUsers = [];

  @override
  void initState() {
    super.initState();
    _loadRegularUsers();
  }

  Future<void> _loadRegularUsers() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/users.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> users = json.decode(jsonString);

      setState(() {
        _regularUsers = users
            .where((user) => user['userType'] == 'عادي')
            .map<String>((user) => user['username'] as String)
            .toList();
      });
    }
  }

  Future<void> _sendMessageToUser() async {
    if (_selectedUser != null && _messageController.text.isNotEmpty) {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/messages.json');

      Map<String, dynamic> messagesData = {};

      if (await file.exists()) {
        String jsonString = await file.readAsString();
        messagesData = json.decode(jsonString);
      }

      String selectedUser = _selectedUser!; // التأكيد أن القيمة غير null
      List<String> userMessages = messagesData[selectedUser] != null
          ? List<String>.from(messagesData[selectedUser])
          : [];
      userMessages.add(_messageController.text);

      messagesData[selectedUser] = userMessages;
      await file.writeAsString(json.encode(messagesData));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إرسال الرسالة إلى $selectedUser')),
      );

      _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء اختيار مستخدم وكتابة رسالة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown for user selection
              Text(
                'إلى',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                hint: Text('اختر مستخدم'),
                value: _selectedUser,
                onChanged: (value) {
                  setState(() {
                    _selectedUser = value;
                  });
                },
                items: _regularUsers
                    .map((user) => DropdownMenuItem(
                  value: user,
                  child: Text(user),
                ))
                    .toList(),
              ),
              SizedBox(height: 16),

              // Message input field
              Text(
                'نص الرسالة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'أكتب رسالتك هنا',
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),

              SizedBox(height: 16),

              // Send button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _sendMessageToUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('إرسال', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
