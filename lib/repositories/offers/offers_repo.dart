import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketing_admin_panel/models/comment_model.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

import '../../helper.dart';

class OffersRepo {
  Future<List<OneOfferModel>> getAllOffers(OfferType offerType, UserType ownerType, {String lastFetchedOfferId = ''}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<OneOfferModel> fetchedOffers = [];
    QuerySnapshot querySnapshot;

    try {
      if (lastFetchedOfferId.isEmpty) {
        if (ownerType == UserType.Company)
          querySnapshot = await firestore
              .collection('company offers')
              .where('offerType', isEqualTo: offerType.toString())
              .orderBy('offerCreationDate', descending: true)
              .get();
        else
          querySnapshot = await firestore
              .collection('offers')
              .where('offerType', isEqualTo: offerType.toString())
              .orderBy('offerCreationDate', descending: true)
              .get();
      } else {
        if (ownerType == UserType.Company) {
          DocumentSnapshot documentSnapshot = await firestore.collection('company offers').doc(lastFetchedOfferId).get();
          querySnapshot = await firestore
              .collection('company offers')
              .where('offerType', isEqualTo: offerType.toString())
              .orderBy('offerCreationDate', descending: true)
              .startAfterDocument(documentSnapshot)
              .get();
        } else {
          DocumentSnapshot documentSnapshot = await firestore.collection('offers').doc(lastFetchedOfferId).get();
          querySnapshot = await firestore
              .collection('offers')
              .where('offerType', isEqualTo: offerType.toString())
              .orderBy('offerCreationDate', descending: true)
              .startAfterDocument(documentSnapshot)
              .get();
        }
      }

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['offerType'] == OfferType.Product.toString())
          fetchedOffers.add(OneProductModel.fromMap(data, doc.id));
        else if (data['offerType'] == OfferType.Post.toString())
          fetchedOffers.add(OnePostModel.fromMap(data, doc.id));
        else if (data['offerType'] == OfferType.Image.toString())
          fetchedOffers.add(OneImageModel.fromMap(data, doc.id));
        else if (data['offerType'] == OfferType.Video.toString()) fetchedOffers.add(OneVideoModel.fromMap(data, doc.id));
      }

      return fetchedOffers;
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteOffer(String offerId, String offerOwnerType, String uId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      if (offerOwnerType == UserType.Company.toString())
        await firestore.collection('company offers').doc(offerId).delete();
      else
        await firestore.collection('offers').doc(offerId).delete();

      //delete it from user docs
      firestore.collection('users').doc(uId).update({
        'offersAdded': FieldValue.arrayRemove([offerId]),
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteComment(String offerId, String offerOwnerType, CommentModel comment) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      if (offerOwnerType == UserType.Company.toString())
        await firestore.collection('company offers').doc(offerId).update({
          'comments': FieldValue.arrayRemove([comment.toMap()]),
        });
      else
        await firestore.collection('offers').doc(offerId).update({
          'comments': FieldValue.arrayRemove([comment.toMap()]),
        });

      //delete it from user docs
      firestore.collection('users').doc(comment.ownerId).update({
        'comments': FieldValue.arrayRemove([comment.id]),
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<OneOfferModel>> filterOffers(double minPrice, double maxPrice, List<String> categories, List<String> countries, String status,
      UserType userType, OfferType offerType) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot;
      List<OneOfferModel> filteredOffers = [];

      CollectionReference ref = userType == UserType.User ? firestore.collection('offers') : firestore.collection('company offers');

      print(categories);
      if (offerType == OfferType.Product) {
        if(countries.isEmpty){
          querySnapshot = categories.isEmpty ? await ref.where('offerType', isEqualTo: OfferType.Product.toString()).orderBy('offerCreationDate', descending: true).get()
              : await ref.where('offerType', isEqualTo: OfferType.Product.toString()).where('categories', arrayContainsAny: categories).orderBy('offerCreationDate', descending: true).get();


          print(querySnapshot.docs.length);
          for (var e in querySnapshot.docs) {
            final data = e.data() as Map<String, dynamic>;
            final offerId = e.id;
            OneProductModel offer = OneProductModel.fromMap(data, offerId);
            filteredOffers.add(offer);
          }

        }
        else{
          querySnapshot = await ref.where('offerType', isEqualTo: OfferType.Product.toString()).where('countries', arrayContainsAny: countries).orderBy('offerCreationDate', descending: true).get();

          for (var e in querySnapshot.docs) {
            final data = e.data() as Map<String, dynamic>;
            final offerId = e.id;
            OneProductModel offer = OneProductModel.fromMap(data, offerId);
            filteredOffers.add(offer);
          }


          if(categories.isNotEmpty){
            filteredOffers = Helper().filterCategories(filteredOffers, categories);
          }
        }

        if (status.isNotEmpty) {
          filteredOffers.removeWhere((offer) {
            OneProductModel pOffer = offer as OneProductModel;
            return pOffer.status != status;
          });
        }

        //filter offers by price
        filteredOffers = Helper().filterPrices(filteredOffers, minPrice, maxPrice);
      }
      else {
        querySnapshot = await ref
            .where('offerType', isEqualTo: offerType.toString())
            .where('countries', arrayContainsAny: countries)
            .orderBy('offerCreationDate', descending: true)
            .get();

        for (var e in querySnapshot.docs) {
          final data = e.data() as Map<String, dynamic>;
          final offerId = e.id;

          if(offerType == OfferType.Post){
            OnePostModel offer = OnePostModel.fromMap(data, offerId);
            filteredOffers.add(offer);
          }
          else if(offerType == OfferType.Image){
            OneImageModel offer = OneImageModel.fromMap(data, offerId);
            filteredOffers.add(offer);
          }
          else if(offerType == OfferType.Video){
            OneVideoModel offer = OneVideoModel.fromMap(data, offerId);
            filteredOffers.add(offer);
          }
        }


      }

      return filteredOffers;
    } catch (e) {
      throw e;
    }
  }
}
