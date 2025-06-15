import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/client.dart';
import '../models/dette.dart';

class ApiService {
  static const String baseUrl =
      'http://10.0.2.2:3000'; // Modifier selon ton IP si besoin

  // ajoute un client à la liste
  Future<void> addClient(Client client) async {
    final response = await http.post(
      Uri.parse('$baseUrl/clients'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Erreur lors de l'ajout du client");
    }
  }

  Future<List<Client>> fetchClients() async {
    final response = await http.get(Uri.parse('$baseUrl/clients'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => Client.fromJson(e)).toList();
    } else {
      throw Exception('Erreur lors du chargement des clients');
    }
  }

  // ajoute une dette à un client
  Future<void> addDebt(int clientId, Dette dette) async {
    final clientResponse = await http.get(
      Uri.parse('$baseUrl/clients/$clientId'),
    );
    if (clientResponse.statusCode == 200) {
      final clientData = json.decode(clientResponse.body);
      final List<dynamic> dettes = clientData['dettes'] ?? [];
      dettes.add(dette.toJson());

      clientData['dettes'] = dettes;

      await http.put(
        Uri.parse('$baseUrl/clients/$clientId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(clientData),
      );
    } else {
      throw Exception("Client introuvable");
    }
  }
}
