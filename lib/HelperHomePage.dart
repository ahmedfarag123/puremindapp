import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'ContactUserPage.dart';
import 'login_user_page.dart';

class HelperHomePage extends StatefulWidget {
  final String email;
  final String password;

  HelperHomePage({required this.email, required this.password});

  @override
  _HelperHomePageState createState() => _HelperHomePageState();
}

class _HelperHomePageState extends State<HelperHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> users = [];
  String? _selectedUser;
  List<String> _regularUsers = [];
  String username = 'إسراء'; // يمكنك تغيير هذا القيمة إلى اسم المساعد الذي قام بتسجيل الدخول
  int tests = 0; // عدد الاختبارات
  String results = 'لم يتم الاختبار بعد'; // نتيجة آخر اختبار

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadUserData();
    _loadRegularUsers();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // تحميل بيانات المستخدمين من ملف JSON
  Future<void> loadUserData() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/users.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      setState(() {
        users = json.decode(jsonString);
      });
    } else {
      print('Users file not found');
    }
  }

  // عملية تسجيل الخروج
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginUserPage()), // الانتقال إلى صفحة تسجيل الدخول
          (Route<dynamic> route) => false,
    );
  }

  // تحميل المستخدمين العاديين
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحباً د.$username'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'تسجيل الخروج',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'تتبع التقدم'),
            Tab(text: 'التواصل مع المستخدم'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTrackProgressTab(),
          ContactUserPage(),
        ],
      ),
    );
  }

  Widget _buildTrackProgressTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown لعرض المستخدمين
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
                  if (_selectedUser != null) {
                    var user = users.firstWhere((u) => u['username'] == _selectedUser);
                    tests = user['tests'] ?? 0; // عدد الاختبارات
                    results = user['results.pop'] ?? 'لم يتم الاختبار بعد'; // نتيجة آخر اختبار
                  }
                });
              },
              items: _regularUsers
                  .map((user) => DropdownMenuItem(
                value: user,
                child: Text(user),
              ))
                  .toList(),
            ),

            SizedBox(height: 20),
            // Card لعرض تفاصيل المستخدم
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedUser != null ? _selectedUser! : 'اختر مستخدمًا',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Text('عدد الإختبارات: $tests', style: TextStyle(fontSize: 16)),
                                Divider(thickness: 2),
                                Text('نتيجة آخر إختبار: $results', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'التحليلات',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: _buildPieChartSections(),
                    centerSpaceRadius: 70,
                    sectionsSpace: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pie Chart لعرض التحليلات
  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: 17,
        title: 'Good',
        radius: 70,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 6,
        title: 'Not good',
        radius: 70,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 14,
        title: 'Relaxation',
        radius: 70,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ];
  }
}
