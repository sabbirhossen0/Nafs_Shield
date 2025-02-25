class Surah {
  int surahNo;
  String name;
  List<Map<String, dynamic>> ayats;
  Surah({required this.surahNo, required this.name, required this.ayats});
}

class Ayat {
  int ayatNo;
  String ayat;
  String banglaTranslation;
  String englishTranslation;
  Ayat(
      {required this.ayatNo,
      required this.ayat,
      required this.banglaTranslation,
      required this.englishTranslation});
}
