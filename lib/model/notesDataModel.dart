import 'dart:convert';

class Notes {
  int? columnId;
  String? note;
  String? date;
  Notes({
    this.columnId,
    this.note,
    this.date,
  });

  Notes copyWith({
    int? columnId,
    String? note,
    String? date,
  }) {
    return Notes(
      columnId: columnId ?? this.columnId,
      note: note ?? this.note,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'columnId': columnId,
      'note': note,
      'date': date,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      columnId: map['columnId']?.toInt(),
      note: map['note'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source));

  @override
  String toString() => 'Notes(columnId: $columnId, note: $note, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Notes &&
      other.columnId == columnId &&
      other.note == note &&
      other.date == date;
  }

  @override
  int get hashCode => columnId.hashCode ^ note.hashCode ^ date.hashCode;
}
