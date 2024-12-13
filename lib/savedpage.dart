import 'package:aplikasi_pertamaku/detailpage.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  final List<Map<String, String>> savedKopiMenu;

  SavedPage({required this.savedKopiMenu});

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late List<Map<String, String>> savedKopiMenu;

  @override
  void initState() {
    super.initState();
    savedKopiMenu = widget.savedKopiMenu;
  }

  void _removeFromSaved(int index) {
    setState(() {
      savedKopiMenu.removeAt(index);
    });
  }

  // Menampilkan dialog konfirmasi sebelum menghapus item
  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Resep'),
          content: Text('Apakah Anda yakin ingin menghapus resep ini dari daftar tersimpan?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                _removeFromSaved(index); // Menghapus item dari daftar saved
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Tersimpan')),
      body: savedKopiMenu.isEmpty
          ? Center(child: Text('Tidak ada resep yang disimpan'))
          : ListView.builder(
              itemCount: savedKopiMenu.length,
              itemBuilder: (context, index) {
                final kopi = savedKopiMenu[index];
                return ListTile(
                  leading: Image.asset(kopi['image']!, width: 50, height: 50),
                  title: Text(kopi['name']!),
                  subtitle: Text(kopi['description']!),
                  onTap: () async {
                    // Navigasi ke halaman detail dan kembali ke SavedPage setelah selesai
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          name: kopi['name']!,
                          description: kopi['description']!,
                          image: kopi['image']!,
                        ),
                      ),
                    );
                    // Perbarui UI jika diperlukan setelah kembali dari detail
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      _showDeleteConfirmation(index); // Menampilkan dialog konfirmasi
                    },
                  ),
                );
              },
            ),
    );
  }
}
