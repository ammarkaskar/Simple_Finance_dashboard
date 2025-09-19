import 'package:flutter/material.dart';

void main() => runApp(FinanceDashboardApp());

class FinanceDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Dashboard (Learning Project)',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> expenses = [
    {"category": "Food", "amount": 1200.0, "color": Colors.red},
    {"category": "Travel", "amount": 800.0, "color": Colors.blue},
    {"category": "Shopping", "amount": 500.0, "color": Colors.green},
    {"category": "Bills", "amount": 1500.0, "color": Colors.orange},
  ];

  final List<Map<String, dynamic>> savings = [
    {"month": "Jan", "amount": 2000.0},
    {"month": "Feb", "amount": 2500.0},
    {"month": "Mar", "amount": 1800.0},
    {"month": "Apr", "amount": 3000.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finance Dashboard (Learning Project)"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Expenses Overview", style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 12),
            Column(
              children: expenses.map((exp) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: exp["color"], radius: 12),
                    title: Text(exp["category"]),
                    trailing: Text("₹${exp["amount"].toStringAsFixed(2)}"),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            Text("Monthly Savings", style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 12),
            Column(
              children: savings.map((s) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(s["month"]),
                    trailing: Text("₹${s["amount"].toStringAsFixed(2)}"),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
