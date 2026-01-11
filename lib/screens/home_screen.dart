import 'package:flutter/material.dart';
import '../data/destination_data.dart';
import '../widgets/destination_card.dart';
import 'destination_detail_screen.dart';
import 'add_destination_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _refreshList() {
    setState(() {});
  }

  void _toggleVisited(int index) {
    setState(() {
      destinations[index].visited = !destinations[index].visited;
    });
  }

  // Funcția de ștergere 
  void _deleteDestination(int index) {
    setState(() {
      destinations.removeAt(index);
    });
  }
  //home screen cu lista de destinații
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF223843),
      appBar: AppBar(
        title: const Text(
          'WishList ',
          style: TextStyle(
            fontFamily: 'Frijole',  
            color: Colors.white,
            fontSize: 70,
          ),
        ),
        backgroundColor: const Color(0xFF223843),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return DestinationCard(
                destination: destination,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DestinationDetailScreen(
                        destination: destination,
                      ),
                    ),
                  );
                },
                onVisitedChanged: () => _toggleVisited(index),
                onDelete: () => _deleteDestination(index), 
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDestinationScreen(),
            ),
          );
          if (result == true) {
            _refreshList();
          }
        },
        backgroundColor: const Color(0xFFD77A61),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}