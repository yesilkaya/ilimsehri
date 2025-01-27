class Ramazan {
  int? ramazan_id;
  int? sira_id;
  String? arapca;
  String? turkce;
  String? meal;

  Ramazan({
    required this.ramazan_id,
    this.sira_id,
    required this.arapca,
    required this.turkce,
    this.meal,
  });

  Ramazan.fromMap(Map<String, dynamic> map)
      : this(
          ramazan_id: map['ramazan_id'],
          sira_id: map['sira_id'],
          arapca: map['arapca'],
          turkce: map['turkce'],
          meal: map['meal'],
        );
}
