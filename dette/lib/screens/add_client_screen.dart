import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/api_service.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({Key? key}) : super(key: key);

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final ApiService apiService = ApiService();
  bool isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final newClient = Client(
      id: DateTime.now().millisecondsSinceEpoch,
      nomComplet: _nomController.text.trim(),
      telephone: _telController.text.trim(),
      dettes: [],
    );

    await apiService.addClient(newClient);

    setState(() => isLoading = false);
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un Client")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: "Nom Complet",
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? "Nom requis" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telController,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? "Téléphone requis" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Ajouter le Client"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
