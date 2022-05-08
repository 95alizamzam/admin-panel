import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketing_admin_panel/models/story_model.dart';

class StoriesRepository {
  Future<List<StoryModel>> getStories({String lastFetchedStoryId = ''}) async {
    try {
      final firestore = FirebaseFirestore.instance;
      List<StoryModel> stories = [];
      QuerySnapshot querySnapshot;

      if(lastFetchedStoryId.isEmpty){
        querySnapshot = await firestore.collection('stories').orderBy('createdAt', descending: true).limit(50).get();
      }else{
        DocumentSnapshot documentSnapshot = await firestore.collection('stories').doc(lastFetchedStoryId).get();
        querySnapshot = await firestore.collection('stories').orderBy('createdAt', descending: true).startAfterDocument(documentSnapshot).limit(50).get();
      }

      for(var doc in querySnapshot.docs){
        final data = doc.data() as Map<String, dynamic>;
        StoryModel storyModel = StoryModel.fromJson(data);
        stories.add(storyModel);
      }

      return stories;
    } catch(e) {
      throw e;
    }
  }

  Future<void> deleteStory(String storyId) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore.collection('stories').doc(storyId).delete();

    } catch (e) {
     throw e;
    }
  }

  Future<List<StoryModel>> getFilteredStories(double minAge, double maxAge, String gender, List<String> countries) async {
    try {

      List<StoryModel> stories = [];
      QuerySnapshot querySnapshot;

      if (gender.isEmpty || gender.toLowerCase() == 'gender') {
        if (countries.isEmpty)
          querySnapshot = await FirebaseFirestore.instance
              .collection('stories')
              .where('age', isGreaterThanOrEqualTo: minAge, isLessThanOrEqualTo: maxAge)
              .get();
        else
          querySnapshot = await FirebaseFirestore.instance
              .collection('stories')
              .where('age', isGreaterThanOrEqualTo: minAge, isLessThanOrEqualTo: maxAge)
              .where('ownerCountry', whereIn: countries)
              .get();
      } else {
        if (countries.isEmpty)
          querySnapshot = await FirebaseFirestore.instance
              .collection('stories')
              .where('age', isGreaterThanOrEqualTo: minAge, isLessThanOrEqualTo: maxAge)
              .where('gender', isEqualTo: gender)
              .get();
        else
          querySnapshot = await FirebaseFirestore.instance
              .collection('stories')
              .where('age', isGreaterThanOrEqualTo: minAge, isLessThanOrEqualTo: maxAge)
              .where('gender', isEqualTo: gender)
              .where('ownerCountry', whereIn: countries)
              .get();
      }

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        StoryModel storyModel = StoryModel.fromJson(data);

        stories.add(storyModel);
      }

      stories.sort((a, b) {
        return b.createdAt!.compareTo(a.createdAt!);
      });

      return stories;
    } catch (e) {
      throw e;
    }
  }

}