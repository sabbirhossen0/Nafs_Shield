import 'package:flutter/material.dart';


class selfexam extends StatefulWidget {
  const selfexam({super.key});

  @override
  State<selfexam> createState() => _selfexamState();
}

class _selfexamState extends State<selfexam> {

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




  Widget buildNamazRow(String label, bool value, bool jamaatValue, Function(bool?) onChanged, Function(bool?) onJamaatChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CheckboxListTile(
          title: Text(label),
          value: value,
          onChanged: onChanged,
        ),
        CheckboxListTile(
          title: Text("Jamaat"),
          value: jamaatValue,
          onChanged: onJamaatChanged,
        ),
      ],
    );
  }








  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/2,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🕌 Namaz", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              buildNamazRow("Fajr", fajr, fajrJamaat, (val) => setState(() => fajr = val!), (val) => setState(() => fajrJamaat = val!)),
              buildNamazRow("Zuhr", zuhr, zuhrJamaat, (val) => setState(() => zuhr = val!), (val) => setState(() => zuhrJamaat = val!)),
              buildNamazRow("Asr", asr, asrJamaat, (val) => setState(() => asr = val!), (val) => setState(() => asrJamaat = val!)),
              buildNamazRow("Maghrib", maghrib, maghribJamaat, (val) => setState(() => maghrib = val!), (val) => setState(() => maghribJamaat = val!)),
              buildNamazRow("Isha", isha, ishaJamaat, (val) => setState(() => isha = val!), (val) => setState(() => ishaJamaat = val!)),
              Divider(),
              CheckboxListTile(
                title: Text("📖 Read Hadith"),
                value: readHadith,
                onChanged: (val) => setState(() => readHadith = val!),
              ),
              CheckboxListTile(
                title: Text("📗 Read Quran"),
                value: readQuran,
                onChanged: (val) => setState(() => readQuran = val!),
              ),
              CheckboxListTile(
                title: Text("🚬 Smoked Today"),
                value: smoked,
                onChanged: (val) => setState(() => smoked = val!),
              ),
              CheckboxListTile(
                title: Text("🌟 Did a Good Deed"),
                value: didGoodWork,
                onChanged: (val) => setState(() => didGoodWork = val!),
              ),
              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: InputDecoration(labelText: "📝 Notes / Reflections", border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  print("submitted");
                },
                child: Text("Submit Report"),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
