import 'package:flutter/material.dart';

void main() => runApp(FinanceDashboardApp());

class FinanceDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: FinanceDashboard(),
    );
  }
}

class FinanceDashboard extends StatefulWidget {
  @override
  _FinanceDashboardState createState() => _FinanceDashboardState();
}

class _FinanceDashboardState extends State<FinanceDashboard> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    OverviewPage(),
    SpendingPage(),
    SavingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("💰 Finance Dashboard"), centerTitle: true),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Overview"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Spending"),
          BottomNavigationBarItem(icon: Icon(Icons.savings), label: "Savings"),
        ],
      ),
    );
  }
}

// ---------------- Overview ----------------
class OverviewPage extends StatelessWidget {
  final List<Map<String, String>> transactions = [
    {"title": "Coffee", "amount": "- ₹150"},
    {"title": "Salary", "amount": "+ ₹50,000"},
    {"title": "Groceries", "amount": "- ₹2,000"},
    {"title": "Netflix", "amount": "- ₹499"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: ListTile(
            title: Text("Current Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("₹47,351",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            trailing: Icon(Icons.account_balance_wallet, size: 40, color: Colors.indigo),
          ),
        ),
        SizedBox(height: 20),
        Text("Recent Transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...transactions.map((tx) => Card(
              child: ListTile(
                leading: Icon(Icons.monetization_on, color: Colors.indigo),
                title: Text(tx["title"]!),
                trailing: Text(
                  tx["amount"]!,
                  style: TextStyle(
                    color: tx["amount"]!.contains("-") ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

// ---------------- Spending ----------------
class SpendingPage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {"category": "Food", "percent": 35, "color": Colors.orange},
    {"category": "Transport", "percent": 15, "color": Colors.blue},
    {"category": "Shopping", "percent": 25, "color": Colors.purple},
    {"category": "Bills", "percent": 25, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text("Monthly Spending Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          // Fake Pie chart using stacked containers
          Container(
            width: 200,
            height: 200,
            child: CustomPaint(
              painter: PieChartPainter(data),
            ),
          ),
          SizedBox(height: 20),
          ...data.map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 15, height: 15, color: e["color"]),
                  SizedBox(width: 8),
                  Text("${e["category"]}: ${e["percent"]}%"),
                ],
              )),
        ],
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    double startRadian = -90 * (3.14 / 180); // start at top
    final radius = size.width / 2;

    for (var e in data) {
      final sweepRadian = (e["percent"] / 100) * 2 * 3.14;
      paint.color = e["color"];
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startRadian,
        sweepRadian,
        true,
        paint,
      );
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// ---------------- Savings ----------------
class SavingsPage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {"month": "Jan", "amount": 5000},
    {"month": "Feb", "amount": 8000},
    {"month": "Mar", "amount": 6500},
    {"month": "Apr", "amount": 9000},
    {"month": "May", "amount": 11000},
  ];

  @override
  Widget build(BuildContext context) {
    final maxAmount = data.map((e) => e["amount"] as int).reduce((a, b) => a > b ? a : b);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Savings Growth", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data.map((e) {
                  final barHeight = (e["amount"] / maxAmount) * 200;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: barHeight,
                        color: Colors.indigo,
                      ),
                      SizedBox(height: 8),
                      Text(e["month"]),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Ammar Kaskar's Project
