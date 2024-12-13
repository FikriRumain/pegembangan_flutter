import 'package:aplikasi_pertamaku/detailpage.dart';
import 'package:flutter/material.dart';

class LikedPage extends StatefulWidget {
  final List<Map<String, String>> likedKopiMenu;

  LikedPage({required this.likedKopiMenu});

  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  late List<Map<String, String>> likedKopiMenu;

  @override
  void initState() {
    super.initState();
    likedKopiMenu = widget.likedKopiMenu;
  }

  void _removeFromLiked(int index) {
    setState(() {
      likedKopiMenu.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Disukai')),
      body: likedKopiMenu.isEmpty
          ? Center(child: Text('Tidak ada resep yang disukai'))
          : ListView.builder(
              itemCount: likedKopiMenu.length,
              itemBuilder: (context, index) {
                final kopi = likedKopiMenu[index];
                return ListTile(
                  leading: Image.asset(kopi['image']!, width: 50, height: 50),
                  title: Text(kopi['name']!),
                  subtitle: Text(kopi['description']!),
                  onTap: () {
                    // Navigasi ke halaman detail jika diinginkan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          name: kopi['name']!,
                          description: kopi['description']!,
                          image: kopi['image']!,
                        ),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ikon "like" yang sudah ada
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red, // Warna merah ketika disukai
                        ),
                        onPressed: () {
                          // Logika jika ikon disukai ditekan
                        },
                      ),
                      // Ikon "hapus" untuk menghapus item dari daftar
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.black),
                        onPressed: () {
                          _removeFromLiked(index); // Menghapus item dari daftar liked
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
