import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic> reports = {};

  Future<void> loadReports() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final now = DateTime.now();

    for (var key in keys) {
      final data = jsonDecode(prefs.getString(key)!);
      final date = DateTime.parse(data['timestamp']);
      if (now.difference(date).inDays <= 30) {
        reports[key] = data;
      } else {
        await prefs.remove(key); // Clear older than 30 days
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📊 Dashboard")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: reports.entries.map((entry) {
          final date = entry.key;
          final data = entry.value;
          return Card(
            child: ListTile(
              title: Text("📅 $date"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.entries
                    .where((e) => e.key != 'timestamp' && e.value == true)
                    .map<Widget>((e) => Text("✅ ${e.key}"))
                    .toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
