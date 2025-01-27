class Ayet {
  int? id;
  int? sure_id;
  int? ayet_no;
  String? ayet_arapca;
  String? meal;

  Ayet(this.id, this.sure_id, this.ayet_no, this.ayet_arapca, this.meal);

  Ayet.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sure_id = map['sure_id'];
    this.ayet_no = map['ayet_no'];
    this.ayet_arapca = map['ayet_arapca'];
    this.meal = map['meal'];
  }

  @override
  String toString() {
    return 'Ayet{id: $id, sure_id: $sure_id, ayet_no: $ayet_no,'
        ' ayet_arapca: $ayet_arapca, meal: $meal}';
  }
}
