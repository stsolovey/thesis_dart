import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String category_id;
  final String category_name;
  final int weight;

  const Category(
      {required this.category_id,
      required this.category_name,
      required this.weight}
      );

  factory Category.fromSnapshot(DocumentSnapshot docSnapshot) {
    return Category(
      category_id: docSnapshot.id,
      category_name: docSnapshot.get('category_name'),
      weight: docSnapshot.get('weight'),
    );
  }
}
