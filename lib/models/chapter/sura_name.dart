import 'dart:convert';

// CREATE TABLE "surah_name" (
// 	"_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
// 	"surah_no"	INTEGER,
// 	"name_arabic"	TEXT,
// 	"ayah_number"	INTEGER,
// 	"type"	TEXT
// )

class SuraName {
  //

  num? id;
  num surah_no;
  String name_arabic;
  num ayah_number;
  String type;

  SuraName({
    required this.id,
    required this.surah_no,
    required this.name_arabic,
    required this.ayah_number,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'surah_no': surah_no});
    result.addAll({'name_arabic': name_arabic});
    result.addAll({'ayah_number': ayah_number});
    result.addAll({'type': type});

    return result;
  }

  factory SuraName.fromMap(Map<String, dynamic> map) {
    return SuraName(
      id: map['id'],
      surah_no: map['surah_no'] ?? 0,
      name_arabic: map['name_arabic'] ?? '',
      ayah_number: map['ayah_number'] ?? 0,
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuraName.fromJson(String source) =>
      SuraName.fromMap(json.decode(source));
}
