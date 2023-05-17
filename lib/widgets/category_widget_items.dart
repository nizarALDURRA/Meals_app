import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../file_operations.dart';
import '../screens/category_meals_screen.dart';
import 'package:path_provider/path_provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  CategoryItem(this.id, this.title, this.imageUrl);

  void _selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routName,
        arguments: {'id': id, 'title': title});
  }

  Image _imageFromDatabase(String imageUrl) {
    return Image.memory(
      getImageBytes(imageUrl),
      height: 120,
      width: 180,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Colors.black,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: imageUrl.contains('assets/images/')
                ? Image.asset(
                    imageUrl,
                    height: 120,
                    width: 180,
                    fit: BoxFit.cover,
                  )
                : _imageFromDatabase(imageUrl),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black45.withOpacity(0.7), Colors.black45],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
