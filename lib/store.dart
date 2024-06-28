import 'package:flutter/material.dart';
import 'book_store.dart';
import 'detail_book.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _selectedCategory = 'All';

  final Map<String, List<BookStore>> _categoryItems = {
    'Trending Now': [
      BookStore(
        title: 'Displacement',
        author: 'Kiku Hughes',
        description: 'Deskripsi buku Displacement.',
        price: 16.55,
        rating: 4.5,
      ),
      BookStore(
        title: 'I\'m a Wild Seed',
        author: 'Sharon Lee de la Cruz',
        description: 'Deskripsi buku I\'m a Wild Seed.',
        price: 11.95,
        rating: 4.0,
      ),
      BookStore(
        title: 'Bionic',
        author: 'Koren Shadmi',
        description: 'Deskripsi buku Bionic.',
        price: 18.38,
        rating: 4.0,
      ),
    ],
    'Free': [
      BookStore(
        title: 'Young Mungo',
        author: 'Douglas Stuart',
        description: 'Deskripsi buku Young Mungo.',
        price: 0.0,
        rating: 4.5,
      ),
    ],
    'Jurnal': [
      BookStore(
        title: 'Displacement',
        author: 'Kiku Hughes',
        description: 'Deskripsi buku Displacement.',
        price: 16.55,
        rating: 4.5,
      ),
      BookStore(
        title: 'I\'m a Wild Seed',
        author: 'Sharon Lee de la Cruz',
        description: 'Deskripsi buku I\'m a Wild Seed.',
        price: 11.95,
        rating: 4.0,
      ),
    ],
    'Makalah': [
      BookStore(
        title: 'Displacement',
        author: 'Kiku Hughes',
        description: 'Deskripsi buku Displacement.',
        price: 16.55,
        rating: 4.5,
      ),
    ],
    'Proposal': [
      BookStore(
        title: 'I\'m a Wild Seed',
        author: 'Sharon Lee de la Cruz',
        description: 'Deskripsi buku I\'m a Wild Seed.',
        price: 11.95,
        rating: 4.0,
      ),
      BookStore(
        title: 'Bionic',
        author: 'Koren Shadmi',
        description: 'Deskripsi buku Bionic.',
        price: 18.38,
        rating: 4.0,
      ),
    ],
    'Novel': [
      BookStore(
        title: 'Displacement',
        author: 'Kiku Hughes',
        description: 'Deskripsi buku Displacement.',
        price: 16.55,
        rating: 4.5,
      ),
      BookStore(
        title: 'Bionic',
        author: 'Koren Shadmi',
        description: 'Deskripsi buku Bionic.',
        price: 18.38,
        rating: 4.0,
      ),
    ],
  };

  List<BookStore> _allItems = [];

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
        title: Text('Store'),
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

  void _onBookTap(BookStore book) {
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
  final List<BookStore> items;
  final ValueChanged<BookStore> onBookTap;

  CategorySection({required this.title, required this.items, required this.onBookTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text('See all'),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final book = items[index];
              return GestureDetector(
                onTap: () => onBookTap(book),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        'https://via.placeholder.com/150',
                        height: 100,
                        width: 100,
                      ),
                      Text(book.title),
                      Text(book.author),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
