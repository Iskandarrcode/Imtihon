class DaromadModels {
  final int id;
  final double summa;
  final String category;
  final String sana;
  final String izoh;

  DaromadModels({
    required this.id,
    required this.summa,
    required this.category,
    required this.sana,
    required this.izoh,
  });

  factory DaromadModels.fromMap(Map<String, dynamic> json) {
    return DaromadModels(
      id: json["id"],
      summa: json["summa"],
      category: json["category"],
      sana: json["sana"],
      izoh: json["izoh"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "summa": summa,
      "category": category,
      "sana": sana,
      "izoh": izoh,
    };
  }
}
