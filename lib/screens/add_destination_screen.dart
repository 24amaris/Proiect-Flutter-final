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
// Salvarea noii destinații
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
// Crearea unei noi destinații
    final newDestination = Destination(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      country: _countryController.text,
      imageUrl: _imageUrlController.text.isNotEmpty
          ? _imageUrlController.text
          : 'https://unsplash.com/photos/globe-map-scroll-lot-a6mfMjCFkII',
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
// ecran pentru adăugarea unei destinații noi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Adaugă Destinație',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF223843),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1a2930), Color(0xFF223843)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFD77A61).withValues(alpha: 0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: _visited
                              ? const LinearGradient(
                                  colors: [Color(0xFFD77A61), Color(0xFFc96a51)],
                                )
                              : null,
                          color: _visited ? null : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Checkbox(
                          value: _visited,
                          onChanged: (value) {
                            setState(() {
                              _visited = value ?? false;
                            });
                          },
                          activeColor: Colors.transparent,
                          checkColor: Colors.white,
                          side: BorderSide.none,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Am vizitat deja această destinație',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF223843),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD77A61), Color(0xFFc96a51)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD77A61).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _saveDestination,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Salvează Destinația',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
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
// Eticheta pentru câmpurile de text
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF223843),
        ),
      ),
    );
  }
// ca un câmp de text reutilizabil - helper
  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF223843),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFD77A61),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}