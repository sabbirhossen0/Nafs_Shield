import 'package:flutter/material.dart';

class selfexam extends StatefulWidget {
  const selfexam({super.key});

  @override
  State<selfexam> createState() => _SelfExamState();
}

class _SelfExamState extends State<selfexam> {
  // Namaz checkboxes
  bool fajr = false;
  bool fajrJamaat = false;
  bool zuhr = false;
  bool zuhrJamaat = false;
  bool asr = false;
  bool asrJamaat = false;
  bool maghrib = false;
  bool maghribJamaat = false;
  bool isha = false;
  bool ishaJamaat = false;

  // Other daily activities
  bool readHadith = false;
  bool readQuran = false;
  bool smoked = false;
  bool didGoodWork = false;

  // Notes
  TextEditingController notesController = TextEditingController();

  Widget buildNamazRow(
      String label,
      bool value,
      bool jamaatValue,
      Function(bool?) onChanged,
      Function(bool?) onJamaatChanged,
      ) {
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

  void handleSubmit() {
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
    };

    print("Report: $report");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Report submitted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🧭 Daily Self-Exam")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 600
                  ? 600
                  : double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🕌 Namaz",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
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
                  const Divider(height: 30),
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
                  const SizedBox(height: 16),
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "📝 Notes / Reflections",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: handleSubmit,
                    icon: const Icon(Icons.send),
                    label: const Text("Submit Report"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
