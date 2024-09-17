import 'package:flutter/material.dart';

class ContactUserPage extends StatefulWidget {
  @override
  _ContactUserPageState createState() => _ContactUserPageState();
}

class _ContactUserPageState extends State<ContactUserPage> {
  String? _selectedUser;
  final TextEditingController _messageController = TextEditingController();

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
                'إلي',
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
                items: ['أريام', 'شهد', 'حنين', '...']
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),

              SizedBox(height: 16),

              // Send button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Action for sending the message
                  },
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
