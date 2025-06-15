import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/api_service.dart';
import 'client_debts_screen.dart';
import 'add_client_screen.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Client>> futureClients;

  @override
  void initState() {
    super.initState();
    futureClients = apiService.fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddClientScreen()),
          );

          if (result == true) {
            setState(() {
              futureClients = apiService.fetchClients(); // Refresh
            });
          }
        },
        child: const Icon(Icons.person_add),
      ),

      appBar: AppBar(title: const Text('Liste des Clients')),
      body: FutureBuilder<List<Client>>(
        future: futureClients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun client trouvé.'));
          }

          final clients = snapshot.data!;

          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              return ListTile(
                title: Text(client.nomComplet),
                subtitle: Text(client.telephone),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ClientDebtsScreen(client: client),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
