// book_detail.dart
import 'package:flutter/material.dart';
import 'book_store.dart';

class BookDetail extends StatelessWidget {
  final BookStore book;

  BookDetail({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'by ${book.author}',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              '\$${book.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
