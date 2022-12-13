import 'dart:convert';

// CREATE TABLE "quran" (
// 	"_id"	INTEGER NOT NULL,
// 	"surah_id"	INTEGER,
// 	"verse_id"	INTEGER,
// 	"arabic"	TEXT,
// 	"shina"	TEXT,
// 	"balti"	TEXT,
// 	"brushaski"	TEXT,
// 	"juz_name"	TEXT,
// 	PRIMARY KEY("_id")
// )

class Ayah {
  //

  num? id;

  num? surah_id;

  num? verse_id;

  String? arabic;

  String? shina;

  String? juz_name;

  Ayah({
    this.id,
    this.surah_id,
    this.verse_id,
    this.arabic,
    this.shina,
    this.juz_name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'surah_id': surah_id});
    result.addAll({'verse_id': verse_id});
    result.addAll({'arabic': arabic});
    result.addAll({'shina': shina});
    result.addAll({'juz_name': juz_name});

    return result;
  }

  factory Ayah.fromMap(Map<String, dynamic> map) {
    return Ayah(
      id: map['id'],
      surah_id: map['surah_id'] ?? 0,
      verse_id: map['verse_id'] ?? 0,
      arabic: map['arabic'] ?? '',
      shina: map['shina'] ?? '',
      juz_name: map['juz_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ayah.fromJson(String source) => Ayah.fromMap(json.decode(source));
}
