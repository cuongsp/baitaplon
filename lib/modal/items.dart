class DataItems {
  String id;
  String name;

  DataItems({
    required this.id,
    required this.name,
  });
  factory DataItems.fromJson(Map<String, dynamic> json) {
    return DataItems(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
