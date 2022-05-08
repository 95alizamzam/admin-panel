
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketing_admin_panel/models/package.dart';

class PackagesRepository {
  CollectionReference ref = FirebaseFirestore.instance.collection('packages');

  Future<List<Package>> getAllPackages() async {
    try{
      List<Package> packages = [];
      QuerySnapshot querySnapshot = await ref.get();

      for(var doc in querySnapshot.docs){
        final data = doc.data() as Map<String, dynamic>;
        Package package = Package.fromMap(data, doc.id);
        packages.add(package);
      }
      return packages;
    }catch(e){
      throw e;
    }
  }

  Future<Package> addNewPackage(Map<String, dynamic> package) async {
    try{
      String id = ref.id;
      await ref.doc(id).set(package);

      return Package.fromMap(package, id);
    }catch(e){
      throw e;
    }
  }

  Future<void> deletePackage(String packageId) async {
    try{
      await ref.doc(packageId).delete();
    }catch(e){
      throw e;
    }
  }

  Future<void> updatePackage(Package package) async {
    try{
      await ref.doc(package.id).update(package.toMap());
    }catch(e){
      throw e;
    }
  }
}