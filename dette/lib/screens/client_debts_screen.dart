import 'package:flutter/material.dart';
import '../models/client.dart';
import '../models/dette.dart';
import 'add_debt_screen.dart';

class ClientDebtsScreen extends StatelessWidget {
  final Client client;

  const ClientDebtsScreen({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Dette> dettes = client.dettes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dettes de ${client.nomComplet}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddDebtScreen(clientId: client.id),
                ),
              );

              if (result == true) {
                Navigator.pop(context); // Refresh en revenant
              }
            },
          ),
        ],
      ),
      body: dettes.isEmpty
          ? const Center(child: Text("Aucune dette trouvée."))
          : ListView.builder(
              itemCount: dettes.length,
              itemBuilder: (context, index) {
                final dette = dettes[index];
                return ListTile(
                  title: Text('${dette.montant.toStringAsFixed(2)} xof'),
                  subtitle: Text('Date: ${dette.date}'),
                );
              },
            ),
    );
  }
}
