import 'package:flutter/material.dart';
import 'detailpage.dart';
import 'likedpage.dart';
import 'savedpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Map<String, String>> kopiMenu = [
    {
      'name': 'Espresso',
      'description': 'Kopi pekat dengan aroma khas.',
      'image': 'assets/Espresso.jpg',
      'rating': '5'
    },
    {
      'name': 'Cappuccino',
      'description': 'Perpaduan kopi dengan susu dan busa.',
      'image': 'assets/Kopi_busa.jpg',
      'rating': '4'
    },
    {
      'name': 'Latte',
      'description': 'Kopi susu dengan rasa lembut.',
      'image': 'assets/busa_lembut.jpg',
      'rating': '4'
    },
    {
      'name': 'Americano',
      'description': 'Espresso dicampur air panas.',
      'image': 'assets/Kopi_susu.jpg',
      'rating': '3'
    },
     {
      'name': 'kopihitam',
      'description': 'kopi hitam air panas.',
      'image': 'assets/kopi_hitam.jpg',
      'rating': '3'
    },
     {
      'name': 'Kopi coklat',
      'description': 'Espresso dicampur air panas.',
      'image': 'assets/Kopi_coklat.jpg',
      'rating': '3'
    },
     {
      'name': 'Espresso susu',
      'description': 'Espresso dicampur air panas.',
      'image': 'assets/Espresso_susu.jpg',
      'rating': '3'
    },
     {
      'name': 'Espresso',
      'description': 'Espresso  air panas.',
      'image': 'assets/Espresso.jpg',
      'rating': '3'
    },
  ];

  List<Map<String, String>> likedKopiMenu = [];
  List<Map<String, String>> savedKopiMenu = [];
  String searchQuery = '';

  void _toggleLike(int index) {
    setState(() {
      if (likedKopiMenu.contains(kopiMenu[index])) {
        likedKopiMenu.remove(kopiMenu[index]);
      } else {
        likedKopiMenu.add(kopiMenu[index]);
      }
    });
  }

  void _saveMenu(int index) {
    setState(() {
      if (savedKopiMenu.contains(kopiMenu[index])) {
        savedKopiMenu.remove(kopiMenu[index]);
      } else {
        savedKopiMenu.add(kopiMenu[index]);
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomePage(),
      LikedPage(likedKopiMenu: likedKopiMenu),
      SavedPage(savedKopiMenu: savedKopiMenu),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Resep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Suka',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Simpan',
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    final filteredKopiMenu = searchQuery.isEmpty
        ? kopiMenu
        : kopiMenu
            .where((kopi) => kopi['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Kopi'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  kopiMenu: kopiMenu,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.8,
          ),
          itemCount: filteredKopiMenu.length,
          itemBuilder: (context, index) {
            final kopi = filteredKopiMenu[index];
            final rating = int.tryParse(kopi['rating'] ?? '0') ?? 0;
            bool isLiked = likedKopiMenu.contains(kopi);
            bool isSaved = savedKopiMenu.contains(kopi);

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.asset(
                        kopi['image']!,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width > 600 ? 120 : 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kopi['name']!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            kopi['description']!,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (i) {
                              return Icon(
                                i < rating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.black,
                            size: 20,
                          ),
                          onPressed: () => _toggleLike(index),
                        ),
                        IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? Colors.blue : Colors.black,
                            size: 20,
                          ),
                          onPressed: () => _saveMenu(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> kopiMenu;

  CustomSearchDelegate({required this.kopiMenu});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = kopiMenu
        .where((kopi) => kopi['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isNotEmpty) {
      final kopi = results.first;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        close(context, null);
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
      });
    }
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = kopiMenu
        .where((kopi) => kopi['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final kopi = suggestions[index];
        return ListTile(
          leading: Image.asset(kopi['image']!, width: 50, height: 50),
          title: Text(kopi['name']!),
          onTap: () {
            query = kopi['name']!;
            showResults(context);
          },
        );
      },
    );
  }
}
