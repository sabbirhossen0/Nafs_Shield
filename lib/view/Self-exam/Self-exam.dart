import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nafsshield/view/Self-exam/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfExamPage extends StatefulWidget {
  const SelfExamPage({super.key});

  @override
  State<SelfExamPage> createState() => _SelfExamPageState();
}
//develop by sabbir
class _SelfExamPageState extends State<SelfExamPage> {
  bool fajr = false, fajrJamaat = false, zuhr = false, zuhrJamaat = false;
  bool asr = false, asrJamaat = false, maghrib = false, maghribJamaat = false;
  bool isha = false, ishaJamaat = false;
  bool readHadith = false, readQuran = false, smoked = false, didGoodWork = false;
  TextEditingController notesController = TextEditingController();

  Widget buildNamazRow(String label, bool value, bool jamaatValue,
      Function(bool?) onChanged, Function(bool?) onJamaatChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                title: const Text("Offered"),
                value: value,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: const Text("In Jamaat"),
                value: jamaatValue,
                onChanged: onJamaatChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> handleSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = DateTime.now().toIso8601String().substring(0, 10);
    final report = {
      'fajr': fajr,
      'fajrJamaat': fajrJamaat,
      'zuhr': zuhr,
      'zuhrJamaat': zuhrJamaat,
      'asr': asr,
      'asrJamaat': asrJamaat,
      'maghrib': maghrib,
      'maghribJamaat': maghribJamaat,
      'isha': isha,
      'ishaJamaat': ishaJamaat,
      'readHadith': readHadith,
      'readQuran': readQuran,
      'smoked': smoked,
      'didGoodWork': didGoodWork,
      'notes': notesController.text,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await prefs.setString(dateKey, jsonEncode(report));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Report submitted!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🧭 Daily Self-Exam"),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),



            onPressed: (){

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DashboardPage()));

            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildNamazRow("Fajr", fajr, fajrJamaat,
                      (val) => setState(() => fajr = val!),
                      (val) => setState(() => fajrJamaat = val!)),
              buildNamazRow("Zuhr", zuhr, zuhrJamaat,
                      (val) => setState(() => zuhr = val!),
                      (val) => setState(() => zuhrJamaat = val!)),
              buildNamazRow("Asr", asr, asrJamaat,
                      (val) => setState(() => asr = val!),
                      (val) => setState(() => asrJamaat = val!)),
              buildNamazRow("Maghrib", maghrib, maghribJamaat,
                      (val) => setState(() => maghrib = val!),
                      (val) => setState(() => maghribJamaat = val!)),
              buildNamazRow("Isha", isha, ishaJamaat,
                      (val) => setState(() => isha = val!),
                      (val) => setState(() => ishaJamaat = val!)),
              CheckboxListTile(
                title: const Text("📖 Read Hadith"),
                value: readHadith,
                onChanged: (val) => setState(() => readHadith = val!),
              ),
              CheckboxListTile(
                title: const Text("📗 Read Quran"),
                value: readQuran,
                onChanged: (val) => setState(() => readQuran = val!),
              ),
              CheckboxListTile(
                title: const Text("🚬 Smoked Today"),
                value: smoked,
                onChanged: (val) => setState(() => smoked = val!),
              ),
              CheckboxListTile(
                title: const Text("🌟 Did a Good Deed"),
                value: didGoodWork,
                onChanged: (val) => setState(() => didGoodWork = val!),
              ),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: "📝 Notes",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: handleSubmit,
                icon: const Icon(Icons.send),
                label: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
