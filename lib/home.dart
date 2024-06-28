import 'package:flutter/material.dart';
import 'book.dart';
import 'book_detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  final Map<String, List<Book>> _categoryItems = {
    'Jurnal': [
      Book(title: 'Displacement', author: 'Kiku Hughes', description: 'Deskripsi buku Displacement.'),
      Book(title: 'I\'m a Wild Seed', author: 'Sharon Lee de la Cruz', description: 'Deskripsi buku I\'m a Wild Seed.')
    ],
    'Makalah': [
      Book(title: 'Displacement', author: 'Kiku Hughes', description: 'Deskripsi buku Displacement.')
    ],
    'Proposal': [
      Book(title: 'I\'m a Wild Seed', author: 'Sharon Lee de la Cruz', description: 'Deskripsi buku I\'m a Wild Seed.'),
      Book(title: 'Bionic', author: 'Koren Shadmi', description: 'Deskripsi buku Bionic.')
    ],
    'Novel': [
      Book(title: 'Displacement', author: 'Kiku Hughes', description: 'Deskripsi buku Displacement.'),
      Book(title: 'Bionic', author: 'Koren Shadmi', description: 'Deskripsi buku Bionic.')
    ],
  };

  List<Book> _allItems = [];

  @override
  void initState() {
    super.initState();
    _generateAllItems();
  }

  void _generateAllItems() {
    _allItems = _categoryItems.values.expand((items) => items).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CognitioArchive'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          CategoryTabs(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: _selectedCategory == 'All'
                  ? _categoryItems.keys.map((category) {
                      return CategorySection(
                        title: category,
                        items: _categoryItems[category] ?? [],
                        onBookTap: _onBookTap,
                      );
                    }).toList()
                  : [
                      CategorySection(
                        title: _selectedCategory,
                        items: _categoryItems[_selectedCategory] ?? [],
                        onBookTap: _onBookTap,
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  void _onBookTap(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetail(book: book)),
    );
  }
} 

class CategoryTabs extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  CategoryTabs({required this.selectedCategory, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Jurnal', 'Makalah', 'Proposal', 'Novel'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: categories.map((category) {
          return FilterChip(
            label: Text(category),
            selected: selectedCategory == category,
            onSelected: (bool selected) {
              if (selected) {
                onCategorySelected(category);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Book> items;
  final ValueChanged<Book> onBookTap;

  CategorySection({required this.title, required this.items, required this.onBookTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          ...items.map((item) => ListTile(
                title: Text(item.title),
                subtitle: Text(item.author),
                onTap: () => onBookTap(item),
              )),
        ],
      ),
    );
  }
}
