class ClientModel{
  String name;
  String? number;
  String? position;

  ClientModel({required this.name, this.number, this.position});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
      return ClientModel(
        name: json["name"],
        number: json["number"] ?? '',
        position: json["position"] ?? '',
      );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "number": number,
      "position": position,
    };
  }

  @override
  String toString() {
    return 'Client{\nname: $name, \nnumber: $number, \nposition: $position\n}';
  }
}