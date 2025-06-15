import 'package:dette/models/dette.dart' show Dette;

class Client {
  final int id;
  final String nomComplet;
  final String telephone;
  final List<Dette> dettes;

  Client({
    required this.id,
    required this.nomComplet,
    required this.telephone,
    required this.dettes,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      nomComplet: json['nomComplet'],
      telephone: json['telephone'],
      dettes: (json['dettes'] as List<dynamic>)
          .map((d) => Dette.fromJson(d))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomComplet': nomComplet,
      'telephone': telephone,
      'dettes': dettes.map((d) => d.toJson()).toList(),
    };
  }
}
