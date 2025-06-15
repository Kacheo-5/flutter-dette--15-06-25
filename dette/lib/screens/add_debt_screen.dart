import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/dette.dart';
import '../services/api_service.dart';

class AddDebtScreen extends StatefulWidget {
  final int clientId;

  const AddDebtScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  State<AddDebtScreen> createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends State<AddDebtScreen> {
  final TextEditingController _montantController = TextEditingController();
  final ApiService apiService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    _montantController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final double montant = double.parse(_montantController.text);
    final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final newDette = Dette(
      dette_id: DateTime.now().millisecondsSinceEpoch, // id unique
      montant: montant,
      date: currentDate,
    );

    setState(() => isLoading = true);
    await apiService.addDebt(widget.clientId, newDette);
    setState(() => isLoading = false);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une dette')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _montantController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Montant',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez un montant';
                  }
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Montant invalide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
