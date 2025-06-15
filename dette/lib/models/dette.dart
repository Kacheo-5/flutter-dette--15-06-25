class Dette {
  final int dette_id;
  final double montant;
  final String date;

  Dette({required this.dette_id, required this.montant, required this.date});

  factory Dette.fromJson(Map<String, dynamic> json) {
    return Dette(
      dette_id: json['dette_id'],
      montant: (json['montant']).toDouble(),
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'dette_id': dette_id, 'montant': montant, 'date': date};
  }
}
