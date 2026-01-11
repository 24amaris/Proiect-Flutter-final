import 'package:flutter/material.dart';
import '../models/destination.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Destination destination;

  const DestinationDetailScreen({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F3),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imaginea mare cu buton back
                Stack(
                  children: [
                    Image.network(
                      destination.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 50,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF223843),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Conținutul
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titlu
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223843),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFFD77A61),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            destination.country,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF223843),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Descriere
                      const Text(
                        'Despre',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223843),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        destination.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF223843),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Perioada recomandată
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8B4A0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF223843),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Perioada recomandată',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF223843),
                                    ),
                                  ),
                                  Text(
                                    destination.bestPeriod,
                                    style: const TextStyle(
                                      color: Color(0xFF223843),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Atracții
                      const Text(
                        'Atracții Turistice',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223843),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...destination.attractions.map(
                        (attraction) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFFD77A61),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                attraction,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF223843),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}