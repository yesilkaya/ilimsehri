class SahifeiSeccadiye {
  int? dua_no;
  int? cumle_no;
  String? turkce;
  String? arapca;

  SahifeiSeccadiye(this.dua_no, this.cumle_no, this.turkce, this.arapca);

  SahifeiSeccadiye.fromMap(Map<String, dynamic> map) {
    this.dua_no = map['dua_no'];
    this.cumle_no = map['cumle_no'];
    this.turkce = map['turkce'];
    this.arapca = map['arapca'];
  }

  @override
  String toString() {
    return 'SahifeiSeccadiye{dua_no: $dua_no, cumle_no: $cumle_no, turkce: $turkce, arapca: $arapca}';
  }
}
