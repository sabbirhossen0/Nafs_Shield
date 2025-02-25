import 'package:flutter/material.dart';

class QuizTabScreen extends StatefulWidget {
  @override
  _QuizTabScreenState createState() => _QuizTabScreenState();
}

class _QuizTabScreenState extends State<QuizTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with TabBar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // App Title
                const Text(
                  "Quiz App",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // Custom TabBar
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(icon: Icon(Icons.quiz), text: "Quiz"),
                    Tab(icon: Icon(Icons.leaderboard), text: "Leaderboard"),
                    Tab(icon: Icon(Icons.settings), text: "Settings"),
                  ],
                ),
              ],
            ),
          ),

          // TabBar Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text("Quiz Page", style: TextStyle(fontSize: 18))),
                Center(child: Text("Leaderboard Page", style: TextStyle(fontSize: 18))),
                Center(child: Text("Settings Page", style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
