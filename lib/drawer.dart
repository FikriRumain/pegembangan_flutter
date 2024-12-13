import 'package:aplikasi_pertamaku/home_resep_kopi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Fikri Rumain',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: const Text(
              'kyzanami26@gmail.com',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/profil.jpeg',
                  fit: BoxFit.cover,
                  width: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 36, 90, 206),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://img.freepik.com/premium-photo/11h-pink-aesthetic-wallpaper-lockscreen_1097265-93242.jpg',
                ),
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Portfolio', () {
            Navigator.pop(context); // Menutup drawer setelah memilih item
          }),
          _buildDrawerItem(Icons.coffee, 'Resep Kopi', () {
            Navigator.pop(context); // Menutup drawer terlebih dahulu
            Navigator.push(
              context,
              PageTransition(
                child: HomePage(),  // Ganti dengan halaman HomeKopi Anda
                type: PageTransitionType.scale,
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 600),
                alignment: Alignment.bottomCenter,
              ),
            );
          }),

          _buildDrawerItem(FontAwesomeIcons.whatsapp, 'WhatsApp', () async {
            final Uri url =
                Uri.parse('https://wa.me/6281248096278?text=Hello');
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              throw 'Could not launch $url';
            }
          }),
          _buildDrawerItem(FontAwesomeIcons.instagram, 'Instagram', () async {
            final Uri url = Uri.parse(
                'https://www.instagram.com/iqqq06/profilecard/?igsh=NXk2eGZhZWw1M3Bx');
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              throw 'Could not launch $url';
            }
          }),
          const Divider(),
          _buildDrawerItem(
            FontAwesomeIcons.personWalkingArrowLoopLeft,
            'Logout',
            () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Apakah anda yakin ingin keluar?'),
                  actions: [
                    TextButton(
                      child: const Text('Batal'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          color: Color.fromARGB(255, 54, 216, 244),
                        ),
                      ),
                      onPressed: () {
                        SystemNavigator.pop(); // Keluar aplikasi
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
