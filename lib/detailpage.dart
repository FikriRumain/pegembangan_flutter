import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  DetailPage({required this.name, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Gambar besar resep kopi
            Image.asset(image, fit: BoxFit.cover),
            SizedBox(height: 16),
            // Nama Resep Kopi
            Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            // Deskripsi Resep Kopi
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            // Bagian Bahan
            Text('Bahan:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _getIngredients(name),
            SizedBox(height: 16),
            // Bagian Instruksi
            Text('Instruksi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _getInstructions(name),
          ],
        ),
      ),
    );
  }

  // Mengambil bahan sesuai dengan nama resep kopi
  Widget _getIngredients(String name) {
    List<String> ingredients;
    switch (name) {
      case 'Espresso':
        ingredients = ['Kopi bubuk espresso', 'Air panas'];
        break;
      case 'Cappuccino':
        ingredients = ['Kopi espresso', 'Susu panas', 'Busa susu'];
        break;
      case 'Latte':
        ingredients = ['Kopi espresso', 'Susu panas'];
        break;
      case 'Americano':
        ingredients = ['Kopi espresso', 'Air panas'];
        break;
      case 'Mocha':
        ingredients = ['Kopi espresso', 'Coklat', 'Susu panas'];
        break;
      case 'Flat White':
        ingredients = ['Kopi espresso', 'Susu panas sedikit busa'];
        break;
      case 'Macchiato':
        ingredients = ['Kopi espresso', 'Sedikit susu'];
        break;
      case 'Affogato':
        ingredients = ['Kopi espresso', 'Es krim vanila'];
        break;
      default:
        ingredients = [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients.map((ingredient) => Text(ingredient)).toList(),
    );
  }

  // Mengambil instruksi sesuai dengan nama resep kopi
  Widget _getInstructions(String name) {
    String instructions;
    switch (name) {
      case 'Espresso':
        instructions = '1. Siapkan kopi espresso.\n2. Seduh dengan air panas.\n3. Nikmati!';
        break;
      case 'Cappuccino':
        instructions = '1. Seduh espresso.\n2. Panaskan susu dan buat busa.\n3. Campurkan susu panas dan busa ke espresso.';
        break;
      case 'Latte':
        instructions = '1. Seduh espresso.\n2. Panaskan susu hingga lembut.\n3. Campurkan susu ke espresso.';
        break;
      case 'Americano':
        instructions = '1. Seduh espresso.\n2. Tambahkan air panas ke espresso.';
        break;
      case 'Mocha':
        instructions = '1. Seduh espresso.\n2. Tambahkan coklat dan susu panas ke espresso.';
        break;
      case 'Flat White':
        instructions = '1. Seduh espresso.\n2. Panaskan sedikit susu hingga lembut.\n3. Campurkan susu ke espresso.';
        break;
      case 'Macchiato':
        instructions = '1. Seduh espresso.\n2. Tambahkan sedikit susu ke espresso.';
        break;
      case 'Affogato':
        instructions = '1. Seduh espresso.\n2. Sajikan di atas es krim vanila.';
        break;
      default:
        instructions = 'Instruksi tidak tersedia.';
    }

    return Text(instructions, style: TextStyle(fontSize: 16));
  }
}
