import 'package:aplikasi_pertamaku/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E88E5),
        elevation: 0,
        title: Text(
          'My Portfolio',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Builder(builder: (context) {
            return IconButton(
              color: Colors.white,
              icon: const Icon(Icons.menu), // Ikon menu di kanan
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Membuka drawer dari kanan
              },
            );
          }),
        ],
      ),
      endDrawer: const AppNavbar(), // Menyambungkan Drawer dengan AppNavbar (di kanan)
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            const SizedBox(height: 30),
            _buildAnimatedText(),
            const SizedBox(height: 30),
            _buildSkillsSection(),
            const SizedBox(height: 30),
            _buildSocialMediaLinks(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF1E88E5),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profil.jpeg'),
            ),
            const SizedBox(height: 10),
            Text(
              'Fikri Rumain',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Mobile Application Engineer',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            'About Me',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E88E5),
            ),
          ),
          const SizedBox(height: 10),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'I am a Flutter Developer passionate about building beautiful and functional mobile apps.',
                textStyle: GoogleFonts.poppins(fontSize: 16),
                speed: const Duration(milliseconds: 50),
              ),
              TyperAnimatedText(
                'I love learning new things and keeping up with the latest technologies.',
                textStyle: GoogleFonts.poppins(fontSize: 16),
                speed: const Duration(milliseconds: 50),
              ),
            ],
            isRepeatingAnimation: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E88E5),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills[index];
              return _buildSkillCard(skill);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            skill['icon'],
            size: 40,
            color: skill['iconColor'],
          ),
          const SizedBox(height: 10),
          Text(
            skill['name'],
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaLinks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connect with Me',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E88E5),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialButton(
                FontAwesomeIcons.whatsapp,
                'WhatsApp',
                'https://wa.me/6281248096278?text=Hello',
                Colors.green,
              ),
              _buildSocialButton(
                FontAwesomeIcons.instagram,
                'Instagram',
                'https://www.instagram.com/chairilali_13',
                Colors.pink,
              ),
              _buildSocialButton(
                FontAwesomeIcons.github,
                'GitHub',
                'https://github.com/FikriRumain',
                Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, String url, Color color) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

const List<Map<String, dynamic>> skills = [
  {
    'name': 'Flutter',
    'icon': FontAwesomeIcons.flutter,
    'iconColor': Colors.blue,
  },
  {
    'name': 'PHP',
    'icon': FontAwesomeIcons.php,
    'iconColor': Colors.deepOrange,
  },
  {
    'name': 'JavaScript',
    'icon': FontAwesomeIcons.js,
    'iconColor': Colors.yellow,
  },
];
