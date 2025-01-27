class Sure {
  int? sure_id;
  String? sure_adi;
  String? sure_arapca;
  String? sure_nazil_yeri;
  int? sure_ayet_sayisi;

  Sure.withID(this.sure_id, this.sure_adi, this.sure_arapca, this.sure_nazil_yeri,
      this.sure_ayet_sayisi); // DB'den okurken kullanılır.

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['sure_id'] = sure_id;
    map['sure_adi'] = sure_adi;
    map['sure_arapca'] = sure_arapca;
    map['sure_nazil_yeri'] = sure_nazil_yeri;
    map['sure_ayet_sayisi'] = sure_ayet_sayisi;

    return map;
  }

  Sure.fromMap(Map<String, dynamic> map) {
    this.sure_id = map['sure_id'];
    this.sure_adi = map['sure_adi'];
    this.sure_arapca = map['sure_arapca'];
    this.sure_nazil_yeri = map['sure_nazil_yeri'];
    this.sure_ayet_sayisi = map['sure_ayet_sayisi'];
  }

  @override
  String toString() {
    return 'Sure{sure_id: $sure_id, sure_adi: $sure_adi, sure_arapca: $sure_arapca,'
        ' sure_nazil_yeri: $sure_nazil_yeri, sure_ayet_sayisi: $sure_ayet_sayisi}';
  }
}
