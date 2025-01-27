class Ehlibeyt {
  int? id;
  String? sahsiyet;
  String? hayati;

  Ehlibeyt(this.id, this.sahsiyet, this.hayati);

  Ehlibeyt.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sahsiyet = map['sahsiyet'];
    this.hayati = map['hayati'];
  }
}
