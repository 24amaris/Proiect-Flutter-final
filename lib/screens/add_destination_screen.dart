import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../data/destination_data.dart';

class AddDestinationScreen extends StatefulWidget {
  const AddDestinationScreen({super.key});

  @override
  State<AddDestinationScreen> createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _bestPeriodController = TextEditingController();
  final _attractionsController = TextEditingController();
  bool _visited = false;

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _bestPeriodController.dispose();
    _attractionsController.dispose();
    super.dispose();
  }

  void _saveDestination() {
    if (_nameController.text.isEmpty || _countryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Te rog completează numele și țara!'),
          backgroundColor: Color(0xFFD77A61),
        ),
      );
      return;
    }

    final newDestination = Destination(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      country: _countryController.text,
      imageUrl: _imageUrlController.text.isNotEmpty
          ? _imageUrlController.text
          : 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800',
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : 'O destinație minunată de explorat.',
      bestPeriod: _bestPeriodController.text.isNotEmpty
          ? _bestPeriodController.text
          : 'Tot anul',
      attractions: _attractionsController.text.isNotEmpty
          ? _attractionsController.text.split(',').map((e) => e.trim()).toList()
          : ['De explorat'],
      visited: _visited,
    );

    destinations.add(newDestination);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F3),
      appBar: AppBar(
        title: const Text(
          'Adaugă Destinație',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF223843),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Nume *'),
                _buildTextField(_nameController, 'Ex: Santorini'),

                const SizedBox(height: 16),

                _buildLabel('Țara *'),
                _buildTextField(_countryController, 'Ex: Grecia'),

                const SizedBox(height: 16),

                _buildLabel('Descriere'),
                _buildTextField(
                  _descriptionController,
                  'Descrie destinația...',
                  maxLines: 3,
                ),

                const SizedBox(height: 16),

                _buildLabel('URL Imagine'),
                _buildTextField(_imageUrlController, 'https://...'),

                const SizedBox(height: 16),

                _buildLabel('Perioada recomandată'),
                _buildTextField(_bestPeriodController, 'Ex: Aprilie - Octombrie'),

                const SizedBox(height: 16),

                _buildLabel('Atracții (separate prin virgulă)'),
                _buildTextField(
                  _attractionsController,
                  'Ex: Plaja, Muzeu, Parc',
                ),

                const SizedBox(height: 16),

        
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBD3D8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _visited,
                        onChanged: (value) {
                          setState(() {
                            _visited = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFFD77A61),
                      ),
                      const Text(
                        'Am vizitat deja această destinație',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF223843),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
      
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveDestination,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD77A61),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Salvează Destinația',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF223843),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFDBD3D8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}