import 'package:cloud_firestore/cloud_firestore.dart';

class OffersRepo {
	Future<QuerySnapshot<Map<String, dynamic>>> getAllOffers(String type, String ownerType) async {
		FirebaseFirestore firestore = FirebaseFirestore.instance;

		try {
			if(ownerType == 'UserType.Company')
				return await firestore
						.collection('company offers')
						.where('offerType', isEqualTo: type)
						.orderBy('offerCreationDate', descending: true)
						.get();
			else
				return await firestore
		  		.collection('offers')
		  		.where('offerType', isEqualTo: type)
		  		.orderBy('offerCreationDate', descending: true)
		  		.get();
		} catch (e) {
		  throw e;
		}
	}

	Future<void> deleteOffer(String offerId, String offerOwnerType, String uId) async {
		try {
		  FirebaseFirestore firestore = FirebaseFirestore.instance;
		  if(offerOwnerType == 'UserType.Company')
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
}
