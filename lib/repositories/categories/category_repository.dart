import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesRepo {
// get all added categories

  Future<QuerySnapshot<Map<String, dynamic>>> getCategories() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final categories = await firestore.collection('categories').get();

    return categories;
  }

  Future<void> remove(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('categories').doc(id).delete();
  }

  Future<void> add(String catTitle, List<String> subCat) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('categories')
        .doc(catTitle)
        .set({'subCategories': subCat});
  }

  Future<void> removeCat(String title, String name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('categories').doc(title).update({
      'subCategories': FieldValue.arrayRemove([name])
    });
  }
}
