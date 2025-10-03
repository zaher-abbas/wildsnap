class CatFact {
  final String fact;

  CatFact({ required this.fact });

  factory CatFact.fromJson(Map<String, dynamic> json) {

    final List<dynamic> data = json['data'];
    return CatFact(fact: data.first.toString());
  }
}
