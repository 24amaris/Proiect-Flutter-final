import 'package:flutter/material.dart';
import '../models/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;
  final VoidCallback onVisitedChanged;
  final VoidCallback onDelete;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
    required this.onVisitedChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFDBD3D8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                destination.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223843),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Color(0xFFD77A61),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            destination.country,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF223843),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                 
                  Row(
                    children: [
                     
                      GestureDetector(
                        onTap: onVisitedChanged,
                        child: Column(
                          children: [
                            const Text(
                              'Am vizitat',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF223843),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: destination.visited
                                    ? const Color(0xFFD77A61)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFD77A61),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                destination.visited ? Icons.check : Icons.check,
                                size: 16,
                                color: destination.visited
                                    ? Colors.white
                                    : const Color(0xFFD77A61),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      GestureDetector(
                        onTap: onDelete,
                        child: Column(
                          children: [
                            const Text(
                              'Șterge',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF223843),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF223843),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                size: 16,
                                color: Color(0xFF223843),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}