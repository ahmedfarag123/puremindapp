import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HelperHomePage extends StatefulWidget {
  @override
  _HelperHomePageState createState() => _HelperHomePageState();
}

class _HelperHomePageState extends State<HelperHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Dr. Esraa!'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Track progress'),
            Tab(text: 'Contact user'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTrackProgressTab(),
          _buildContactUserTab(),
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
                                  'Mohamed Ahmed',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text('26 years', style: TextStyle(fontSize: 16)),
                                SizedBox(height: 10),
                                Text('Number of tests: 85', style: TextStyle(fontSize: 16)),
                                Text('Current mood: Good', style: TextStyle(fontSize: 16)),
                                Text('The result of the last test: 18/20', style: TextStyle(fontSize: 16)),
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
              'Analytics',
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

  Widget _buildContactUserTab() {
    return Center(
      child: Text('Contact user page content goes here'),
    );
  }
}
