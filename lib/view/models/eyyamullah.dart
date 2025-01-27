class Eyyamullah {
  final int id;
  final String description;
  final String hijriDate;
  final String gregorianDate;
  final String category;
  bool isPageReady = false;
  List<Eyyamullah>? events = [];

  Eyyamullah({
    required this.description,
    required this.hijriDate,
    required this.gregorianDate,
    required this.id,
    required this.category,
    required this.isPageReady,
    this.events,
  });

  Eyyamullah copyWith({
    int? id,
    String? description,
    String? hijriDate,
    String? gregorianDate,
    String? category,
    bool? isPageReady,
    List<Eyyamullah>? events,
  }) {
    return Eyyamullah(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      hijriDate: hijriDate ?? this.hijriDate,
      gregorianDate: gregorianDate ?? this.gregorianDate,
      isPageReady: isPageReady ?? this.isPageReady,
      events: events ?? this.events,
    );
  }

  static Eyyamullah defaultEyyamullah = Eyyamullah(
    isPageReady: false,
    description: '',
    hijriDate: '',
    gregorianDate: '',
    id: 0,
    category: '',
  );
}
