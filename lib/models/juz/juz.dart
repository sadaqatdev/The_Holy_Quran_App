import 'dart:convert';

class Juz {
  final int? number;
  final String? name;
  Juz({
    this.number,
    this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (number != null) {
      result.addAll({'juz_number': number});
    }
    if (name != null) {
      result.addAll({'juz_name': name});
    }

    return result;
  }

  factory Juz.fromMap(Map<String, dynamic> map) {
    return Juz(
      number: int.parse(map['juz_no']),
      name: map['juz_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Juz.fromJson(String source) => Juz.fromMap(json.decode(source));
}
