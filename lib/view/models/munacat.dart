class Munacat {
  int? id;
  String? munacat_adi;
  String? arapca;
  String? turkce;

  Munacat(this.id, this.munacat_adi, this.arapca, this.turkce);

  Munacat.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.munacat_adi = map['munacat_adi'];
    this.arapca = map['arapca'];
    this.turkce = map['turkce'];
  }
}
