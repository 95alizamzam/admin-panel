import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

import '../../helper.dart';

class UserRepo {
  Future<List<OneUserModel>> getAllUsers(String userType, {String lastFetchedDocument = ''}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<OneUserModel> fetchedUsers = [];
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;

      if(lastFetchedDocument.isEmpty){
        if(userType == UserType.Company.toString())
          querySnapshot = await firestore.collection('users').orderBy('createdAt', descending: true).where('userType', isEqualTo: userType).limit(50).get();
        else
          querySnapshot = await firestore.collection('users').orderBy('createdAt', descending: true).where('userType', whereIn: [UserType.User.toString(),UserType.Guest.toString()]).limit(50).get();
      }else{
        DocumentSnapshot documentSnapshot = await firestore.collection('users').doc(lastFetchedDocument).get();
       if(userType == UserType.Company.toString())
          querySnapshot = await firestore.collection('users').orderBy('createdAt', descending: true).startAfterDocument(documentSnapshot).where('userType', isEqualTo: userType).limit(50).get();
       else
         querySnapshot = await firestore.collection('users').orderBy('createdAt', descending: true).startAfterDocument(documentSnapshot).where('userType', whereIn: [UserType.User.toString(),UserType.Guest.toString()]).limit(50).get();
      }


      for(var doc in querySnapshot.docs){
        if(doc.data()['userType'] == UserType.Company.toString())
          fetchedUsers.add(OneCompanyModel.fromMap(doc.data(), doc.id));
      else
          fetchedUsers.add(OnePersonModel.fromMap(doc.data(), doc.id));
      }

      return fetchedUsers;
    } catch (e) {
      throw e;
    }
  }

  Future<OneUserModel?> getMostInteractingUser(String userType) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      OneUserModel? mostInteractingUser;

      QuerySnapshot querySnapshot = await firestore.collection('users').where('userType', isEqualTo: userType).get();

      for(var doc in querySnapshot.docs){
        final data = doc.data() as Map<String, dynamic>;
        final oneUserModel;
        if(data['userType'] == UserType.Company.toString())
          oneUserModel = OneCompanyModel.fromMap(data, doc.id);
        else
          oneUserModel = OneUserModel.fromMap(data, doc.id);

        int interacting = (oneUserModel.comments?.length ?? 0) + (oneUserModel.offersLiked?.length ?? 0);
        int mostInteracting = (mostInteractingUser?.comments?.length ?? 0) + (mostInteractingUser?.offersLiked?.length ?? 0);

        if(interacting > mostInteracting)
          mostInteractingUser = oneUserModel;
      }

      print('most inter is ${mostInteractingUser?.userName ?? ''}');
      return mostInteractingUser;
    } catch (e) {
      throw e;
    }
  }

  Future<OneUserModel> getMostPointsUser(String userType) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore.collection('users').where('userType', isEqualTo: userType).orderBy('points', descending: true).get();

    final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
    OneUserModel mostPointsUser;
    if(data['userType'] == UserType.Company.toString())
      mostPointsUser = OneCompanyModel.fromMap(data, querySnapshot.docs.first.id);
    else
      mostPointsUser = OneUserModel.fromMap(data, querySnapshot.docs.first.id);

    return mostPointsUser;
  }

  Future<OneUserModel?> getMostAddOffersUser(String userType) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    OneUserModel? mostOffersAddedUser;

    QuerySnapshot querySnapshot = await firestore.collection('users').where('userType', isEqualTo: userType).get();

    for(var doc in querySnapshot.docs){
      final data = doc.data() as Map<String, dynamic>;

      OneUserModel oneUserModel;
      if(data['userType'] == UserType.Company.toString())
        oneUserModel = OneCompanyModel.fromMap(data, querySnapshot.docs.first.id);
      else
        oneUserModel = OneUserModel.fromMap(data, querySnapshot.docs.first.id);

      if(oneUserModel.offersAdded == null || oneUserModel.offersAdded!.isEmpty)
        continue;

      int offerAddedCount = oneUserModel.offersAdded?.length ?? 0;
      int mostOfferAdded = mostOffersAddedUser?.offersAdded?.length ?? 0;

      if(offerAddedCount > mostOfferAdded)
        mostOffersAddedUser = oneUserModel;
    }

    print('most added is ${mostOffersAddedUser?.userName ?? ''}');

    return mostOffersAddedUser;
  }

  Future<String> getUserPackageName(String userId) async {
    try{
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final documentSnapshot = await firestore.collection('subscriptions').doc(userId).get();

      final data = documentSnapshot.data() as Map<String, dynamic>;

      return data['packageName'];
    }catch(e){
      throw e;
    }
  }

  Future<List<OneUserModel>> searchForUsers(SearchType searchType, String searchText, String userType) async {
    try{
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<OneUserModel> searchUsers = [];
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;

      switch(searchType){

        case SearchType.Username:
          querySnapshot = await firestore.collection('users').where('userType', isEqualTo: userType).where('searchStrings', arrayContains: searchText.toLowerCase()).get();
          break;
        case SearchType.UserCode:
          querySnapshot = await firestore.collection('users').where('userType', isEqualTo: userType).where('userCode', isEqualTo: searchText.toLowerCase()).get();
          break;
        case SearchType.Email:
          querySnapshot = await firestore.collection('users').where('userType', isEqualTo: userType).where('email', isEqualTo: searchText.toLowerCase()).get();
          break;
      }

      for(var doc in querySnapshot.docs){
        OneUserModel oneUserModel = OneUserModel.fromMap(doc.data(), doc.id);
        searchUsers.add(oneUserModel);
      }

      return searchUsers;
    }catch(e){
      throw e;
    }
  }


  Future<OneUserModel> getUserById(String userId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('users').doc(userId).get();
      final data = snapshot.data();
      final uId = snapshot.id;
      final user;
      if(data!['userType'] == 'UserType.Company')
        user = OneCompanyModel.fromMap(data, uId);
      else
        user = OnePersonModel.fromMap(data, uId);

      return user;
    } catch (e) {
     throw e;
    }
  }

  Future<List<OneUserModel>> filterUsers(double minAge, double maxAge, String gender, List<String> countries, UserType userType) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<OneUserModel> users = [];
      QuerySnapshot querySnapshot;

      if (gender.isEmpty || gender == 'Gender') {
        if (countries.isEmpty)
          querySnapshot = await firestore.collection('users')
              .where('userType', isEqualTo: userType.toString())
              .get();
        else
          querySnapshot = await firestore.collection('users')
              .where('userType', isEqualTo: userType.toString())
              .where('country', whereIn: countries)
              .get();

      } else {
        if (countries.isEmpty)
          querySnapshot = await firestore.collection('users')
              .where('userType', isEqualTo: userType.toString())
              .where('gender', isEqualTo: gender)
              .get();
        else
          querySnapshot = await firestore.collection('users')
              .where('userType', isEqualTo: userType.toString())
              .where('country', whereIn: countries)
              .where('gender', isEqualTo: gender)
              .get();
      }

      for(var doc in querySnapshot.docs){
        final data = doc.data() as Map<String, dynamic>;

        String dateBirth = data['dateBirth'] ?? '';
        int age = Helper().getAgeFromBirthDate(dateBirth);
        print(data['userName'] + age.toString());
        if((age > minAge && age < maxAge) || (minAge == 0 && maxAge == 100)){
          OneUserModel chatUserModel = OneUserModel.fromMap(data, doc.id);
          users.add(chatUserModel);
        }
      }


      return users;
    } catch (e) {
      throw e;
    }
  }


  Future<void> sendPointsToUser(String userId, int amount) async {
    try{
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('users').doc(userId).update({
        'points': FieldValue.increment(amount)
      });

    }catch(e){
      throw e;
    }
  }
}
