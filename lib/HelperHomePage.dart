import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'ContactUserPage.dart'; // استدعاء صفحة الاتصال الجديدة

class HelperHomePage extends StatefulWidget {
  final String email;  // إضافة البريد الإلكتروني
  final String password;  // إضافة كلمة المرور

  HelperHomePage({required this.email, required this.password}); // تمرير البريد الإلكتروني وكلمة المرور

  @override
  _HelperHomePageState createState() => _HelperHomePageState();
}

class _HelperHomePageState extends State<HelperHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String username = 'د.إسراء'; // القيمة الافتراضية التي سيتم استبدالها لاحقًا

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadUserData(); // استدعاء الدالة لتحميل بيانات المستخدم
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // دالة لتحميل بيانات المستخدم من ملف JSON بناءً على البريد الإلكتروني وكلمة المرور
  Future<void> loadUserData() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/users.json');

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> users = json.decode(jsonString);

      // البحث عن المستخدم الذي يتطابق مع البريد الإلكتروني وكلمة المرور
      final user = users.firstWhere(
            (user) => user['email'] == widget.email && user['password'] == widget.password,
        orElse: () => null,
      );

      if (user != null) {
        setState(() {
          username = user['username']; // تعيين اسم المستخدم
        });
      } else {
        // التعامل مع حالة عدم العثور على المستخدم
        print('User not found');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحباً د.$username'), // عرض اسم المستخدم هنا
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
          ContactUserPage(), // استدعاء صفحة الاتصال الجديدة هنا
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
            // تعديل قسم البيانات الشخصية
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
                          Expanded( // استخدام Expanded لحل مشكلة تجاوز العرض
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'محمد عبدالوهاب', // عرض اسم المستخدم هنا أيضًا
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Text('العمر: 26', style: TextStyle(fontSize: 16)),
                                Divider(thickness: 2),
                                Text('عدد الإختبارات: 85', style: TextStyle(fontSize: 16)),
                                Divider(thickness: 2),
                                Text('الحالة المزاجية الحالية: جيد', style: TextStyle(fontSize: 13)),
                                Divider(thickness: 2),
                                Text('نتيجة آخر إختبار: 18/20', style: TextStyle(fontSize: 14)),
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
            // قسم التحليلات
            Text(
              'التحليلات',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                height: 300, // زيادة حجم الدائرة
                child: PieChart(
                  PieChartData(
                    sections: _buildPieChartSections(),
                    centerSpaceRadius: 70, // زيادة المسافة في المركز
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

  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: 17,
        title: 'Good',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 6,
        title: 'Not good',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 14,
        title: 'Relaxation',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: 3,
        title: 'Irritation',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 9,
        title: 'Excitement',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: 8,
        title: 'Fear',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
      PieChartSectionData(
        color: Colors.pink,
        value: 13,
        title: 'Optimism',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
      PieChartSectionData(
        color: Colors.lightGreen,
        value: 15,
        title: 'Happy',
        radius: 70, // زيادة حجم الدائرة
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // تصغير حجم النص
      ),
    ];
  }
}
