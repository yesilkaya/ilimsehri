class Dua {
  int? dua_id;
  int? sira_id;
  String? arapca;
  String? turkce;
  String? meal;

  Dua(this.dua_id, this.sira_id, this.arapca, this.turkce, this.meal);

  Dua.fromMap(Map<String, dynamic> map) {
    this.dua_id = map['dua_id'];
    this.sira_id = map['sira_id'];
    this.arapca = map['arapca'];
    this.turkce = map['turkce'];
    this.meal = map['meal'];
  }
}
