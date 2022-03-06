import 'dart:convert';

class Student {
  final int id;
  final String name;
  final String photo;
  final double gpa;
  final bool isActivist;
  
  Student({
    required this.id,
    required this.name,
    required this.photo,
    required this.gpa,
    required this.isActivist,
  });

  Student copyWith({
    int? id,
    String? name,
    String? photo,
    double? gpa,
    bool? isActivist,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      gpa: gpa ?? this.gpa,
      isActivist: isActivist ?? this.isActivist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'gpa': gpa,
      'isActivist': isActivist,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      photo: map['photo'] ?? '',
      gpa: map['gpa']?.toDouble() ?? 0.0,
      isActivist: map['isActivist'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, name: $name, photo: $photo, gpa: $gpa, isActivist: $isActivist)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Student &&
      other.id == id &&
      other.name == name &&
      other.photo == photo &&
      other.gpa == gpa &&
      other.isActivist == isActivist;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      photo.hashCode ^
      gpa.hashCode ^
      isActivist.hashCode;
  }
}
