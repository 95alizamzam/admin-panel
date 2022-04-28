const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();
const auth = admin.auth();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.deleteUser = functions.https.onCall(async(data, context) => {
	const userId = data.userId;
	const userType = data.userType;

    //delete user
	return auth.deleteUser(userId).then(() => {
		console.log("Successfully deleted user");
		//delete user data from firestore
		db.collection('users').doc(userId).delete().catch((error) => {
			console.log("Error deleting user:", error);
			return false;
		});

		//delete user offers
		if(userType == 'UserType.Company'){
			var query = db.collection('company offers').where('offerOwnerId','==',userId);
			query.get().then((querySnapshot) => {
				querySnapshot.forEach((doc) => {
				doc.ref.delete();
			});
		});
		} else {
			var query = db.collection('offers').where('offerOwnerId','==',userId);
			query.get().then((querySnapshot) => {
				querySnapshot.forEach((doc) => {
					doc.ref.delete();
				});
			});
		}

		//delete subCollections if exists
		db.collection("users").doc(userId).collection('bills').get().then((sub)=>{
			if(sub.docs.length > 0){
				sub.forEach((doc)=>{
					doc.ref.delete();
				});
			}
		});

		db.collection("users").doc(userId).collection('notifications').get().then((sub)=>{
			if(sub.docs.length > 0){
				sub.forEach((doc)=>{
					doc.ref.delete();
				});
			}
		});

		db.collection("users").doc(userId).collection('device tokens').get().then((sub)=>{
			if(sub.docs.length > 0){
				sub.forEach((doc)=>{
					doc.ref.delete();
				});
			}
		});

		db.collection("users").doc(userId).collection('unreadMessages').get().then((sub)=>{
        			if(sub.docs.length > 0){
        				sub.forEach((doc)=>{
        					doc.ref.delete();
        				});
        			}
        		});

        db.collection("users").doc(userId).collection('chats').get().then((sub)=>{
                			if(sub.docs.length > 0){
                				sub.forEach((doc)=>{
                					doc.ref.delete();
                				});
                			}
                		});

         db.collection("users").doc(userId).collection('group chats').get().then((sub)=>{
                 			if(sub.docs.length > 0){
                 				sub.forEach((doc)=>{
                 					doc.ref.delete();
                 				});
                 			}
                 		});

		return true;
	}).catch((error) => {
		console.log("Error deleting user:", error);
		return false;
	});

	//console.log(`user id is ${userId}`);
});
