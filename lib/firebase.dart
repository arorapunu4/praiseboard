import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';



/// [FirebaseService] includes all the Firebase database interaction utilities.
/// This includes creating, deleting, updating data.
/// Call the appropriate methods on need
/// Use [FirebaseService] like this:
/// ```dart
///   FirebaseService().createData(collectionName: 'users', docId: '15jqbsnqmq', data: {'name': 'user'});
/// ```
///

class FirebaseService {
  static FirebaseService _instance;

  static FirebaseApp app;
  static FirebaseFirestore firestore;

  factory FirebaseService() {
    return _instance;
  }


  /// Configures the app with an instance for global use
  static Future<void> configure() async {
    app = await Firebase.initializeApp();
    FirebaseService.firestore = FirebaseFirestore.instanceFor(app: app);

  }

  static FirebaseFirestore get firestorInstance => firestore;

  /// [getDocumentReference] function will return document reference of the
  /// collection/subcollection
  static DocumentReference getDocumentReference({
    @required String collectionName,
    @required String docId,
    String subCollectionName = '',
    String subCollectionDocId,
  }) {
    return subCollectionName == ''
        ? firestore.collection(collectionName).doc(docId)
        : firestore
            .collection(collectionName)
            .doc(docId)
            .collection(subCollectionName)
            .doc(subCollectionDocId);
  }

  /// current logged in userId.Don't pass the user id to the service
  // /// Use currentUser
  // static User userId() {
  //   FirebaseAuth.instance.currentUser.reload();
  //   return FirebaseAuth.instance.currentUser;
  // }

  /// Create document in the firestore
  /// Pass collectionName, document id, data
  static Future<void> createDocument({
    @required String collectionName,
    @required String docId,
    @required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    try {
      SetOptions options = SetOptions(merge: true);
      await firestore.collection(collectionName).doc(docId).set(data, options);
    } catch (e) {
      // logger.e('Error creating document in Firestore', e);
      // throw ServiceException(message: 'Error in firebase - createDocument');
    }
  }

  /// Create document in the subcollection of firestore
  /// Pass collectionName, document id,subcollection name, subdocument id, data and maskId.
  static Future<void> createSubCollectionDocument({
    var maskId,
    @required String collectionName,
    @required String docId,
    @required String subCollection,
    @required String subDoc,
    @required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    try {
      SetOptions options = SetOptions(merge: merge);
      await firestore
          .collection(collectionName)
          .doc(docId)
          .collection(subCollection)
          .doc(subDoc)
          .set(maskId != null ? {maskId: data} : data, options);
    } catch (e) {
      // logger.e('Error creating subcollection document in Firestore', e);
      // CrashAnalytics.log(
      //     'Error creating subcollection document in Firestore $e');
      // throw ServiceException(
      //     message: 'Error in firebase - createSubCollectionDocument');
    }
  }

  /// Replace document in the firestore
  /// Pass collectionName, document id, data
  /// Pass subCollectionName and subDocId if its required
  static Future<void> replaceDocument({
    @required String collectionName,
    @required String docId,
    @required Map<String, dynamic> data,
    String subCollectionName = '',
    String subDocId = '',
  }) async {
    try {
      subCollectionName == ''
          ? await firestore.collection(collectionName).doc(docId).set(data)
          : await firestore
              .collection(collectionName)
              .doc(docId)
              .collection(subCollectionName)
              .doc(subDocId)
              .set(data);
    } catch (e) {
      // logger.e('Error replacing document in Firestore', e);
      // CrashAnalytics.log('Error replacing document in Firestore $e');
      // throw ServiceException(message: 'Error in firebase - replaceDocument');
    }
  }

  /// Update document in the firestore
  /// Pass collectionName, document id, data
  static Future<void> updateDocument({
    @required String collectionName,
    @required String docId,
    @required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(collectionName).doc(docId).update(data);
    } catch (e) {
      // logger.e('Error updating document in Firestore', e);
      // throw ServiceException(message: 'Error in firebase - updateDocument');
    }
  }

  /// Delete document in the firestore
  /// Pass collectionName, document id
  static Future<void> deleteDocument({
    @required String collectionName,
    @required String docId,
  }) async {
    try {
      await firestore.collection(collectionName).doc(docId).delete();
    } catch (e) {
      // logger.e('Error deleting document in Firestore', e);
      // throw ServiceException(message: 'Error in firebase - deleteDocument');
    }
  }

  /// Get documents from the firestore as future
  static Future<QuerySnapshot> getDocumentsAsFuture({
    @required String collectionName,
    String docId = '',
    String subCollectionName = '',
  }) async {
    return (subCollectionName.isEmpty && docId.isEmpty)
        ? await firestore.collection(collectionName).get()
        : await firestore
            .collection(collectionName)
            .doc(docId)
            .collection(subCollectionName)
            .get();
  }

  /// Get documents from the firestore as future on basis of filtered data
  static Future<QuerySnapshot> getFilterDocumentsAsFuture({
    @required String collectionName,
    String docId = '',
    String subCollectionName = '',
    List filters,
  }) async {
    return (subCollectionName.isEmpty && docId.isEmpty)
        ? await firestore.collection(collectionName).get()
        : await firestore
            .collection(collectionName)
            .doc(docId)
            .collection(subCollectionName)
            .where('status', whereIn: filters)
            .get();
  }

  ///[getDocumentsWithStatusAsFuture] is used to get the subCollection document
  static Future<DocumentSnapshot> getIndividualDocumentAsFuture({
    @required String collectionName,
    String docId = '',
    String subCollectionName = '',
    String subCollectionDocId,
  }) async {
    return subCollectionName == ''
        ? await firestore.collection(collectionName).doc(docId).get()
        : await firestore
            .collection(collectionName)
            .doc(docId)
            .collection(subCollectionName)
            .doc(subCollectionDocId)
            .get();
  }

  /// Get document from the firestore
  /// Pass collectionName, document id
  /// Pass subCollectionName and subDocId if its required
  static Future<DocumentSnapshot> getDocumentAsFuture({
    @required String collectionName,
    @required String docId,
    String subCollectionName = '',
    String subDocId = '',
  }) async {
    if (subCollectionName == '') {
      return await firestore.collection(collectionName).doc(docId).get();
    } else {
      return await firestore
          .collection(collectionName)
          .doc(docId)
          .collection(subCollectionName)
          .doc(subDocId)
          .get();
    }
  }

  /// Get documents from the firestore as stream
  static Stream<QuerySnapshot> getDocumentsAsStream({
    @required String collectionName,
    String docId = '',
    String subCollectionName = '',
    metaDataChanges = false,
  }) {
    return (subCollectionName.isEmpty && docId.isEmpty)
        ? firestore
            .collection(collectionName)
            .snapshots(includeMetadataChanges: metaDataChanges)
        : firestore
            .collection(collectionName)
            .doc(docId)
            .collection(subCollectionName)
            .snapshots();
  }

  /// Get document from the firestore as stream
  static Stream<DocumentSnapshot> getDocumentAsStream({
    @required String collectionName,
    @required String docId,
    metaDataChanges = false,
  }) {
    return firestore
        .collection(collectionName)
        .doc(docId)
        .snapshots(includeMetadataChanges: metaDataChanges);
  }

}

  // /// To get ref of image storage that is stored in [FirebaseStorage]

  // static Reference getImageRef({
  //   @required docId,
  //   folderName = 'user_image',
  // }) {
  //   Reference ref;
  //   ref = FirebaseStorage.instance
  //       .ref()

  //       /// Folder name in [FirebaseStorage]
  //       .child(folderName)

  //       /// File name inside the folder
  //       .child('$docId.png');

  //   return ref;
  // }

  // /// [arrayUnion] can be used to update an array
  // static FieldValue arrayUnion({@required Map<String, dynamic> data}) {
  //   return FieldValue.arrayUnion([data]);
  // }

  // /// [arrayRemove] can be used to remove a particular value from an array
  // static FieldValue arrayRemove({@required Map<String, dynamic> data}) {
  //   return FieldValue.arrayRemove([data]);
  // }

//   ///[getDocumentsAsFutureWithFilters]is used to Get documents from the firestore as future with filters
//   static Future<QuerySnapshot> getDocumentsAsFutureWithFilters({
//     @required String collectionName,
//     String docId = '',
//     String subCollectionName = '',
//     String whereField = '',
//     dynamic filters,
//     FirestoreFilters queryOperator,
//   }) async {
//     switch (queryOperator) {
//       case FirestoreFilters.isNotEqual:
//         return (subCollectionName.isEmpty && docId.isEmpty)
//             ? await firestore
//                 .collection(collectionName)
//                 .where(whereField, isNotEqualTo: filters)
//                 .get()
//             : await firestore
//                 .collection(collectionName)
//                 .doc(docId)
//                 .collection(subCollectionName)
//                 .where(whereField, isNotEqualTo: filters)
//                 .get();
//       case FirestoreFilters.isEqual:
//         return (subCollectionName.isEmpty && docId.isEmpty)
//             ? await firestore
//                 .collection(collectionName)
//                 .where(whereField, isEqualTo: filters)
//                 .get()
//             : await firestore
//                 .collection(collectionName)
//                 .doc(docId)
//                 .collection(subCollectionName)
//                 .where(whereField, isEqualTo: filters)
//                 .get();
//       case FirestoreFilters.whereIn:
//         return (subCollectionName.isEmpty && docId.isEmpty)
//             ? await firestore
//                 .collection(collectionName)
//                 .where(whereField, whereIn: filters)
//                 .get()
//             : await firestore
//                 .collection(collectionName)
//                 .doc(docId)
//                 .collection(subCollectionName)
//                 .where(whereField, whereIn: filters)
//                 .get();
//       case FirestoreFilters.arrayContains:
//         return (subCollectionName.isEmpty && docId.isEmpty)
//             ? firestore
//                 .collection(collectionName)
//                 .where(whereField, arrayContains: filters)
//                 .get()
//             : firestore
//                 .collection(collectionName)
//                 .doc(docId)
//                 .collection(subCollectionName)
//                 .where(whereField, arrayContains: filters)
//                 .get();
//       default:
//         return getDocumentsAsFuture(
//           collectionName: collectionName,
//           docId: docId,
//           subCollectionName: subCollectionName,
//         );
//     }
//   }

//   ///[getDocumentsAsStreamWithFilters]is used to Get documents from the firestore as Stream with filters
//   static Stream<QuerySnapshot> getDocumentsAsStreamWithFilters({
//     @required String collectionName,
//     String docId = '',
//     String subCollectionName = '',
//     String whereField = '',
//     dynamic filters,
//     FirestoreFilters queryOperator,
//   }) {
//     switch (queryOperator) {
//       case FirestoreFilters.isNotEqual:
//         return (subCollectionName.isEmpty && docId.isEmpty)
//             ? firestore
//                 .collection(collectionName)
//                 .where(whereField, isNotEqualTo: filters)
//                 .snapshots()
//             : firestore
//                 .collection(collectionName)
//                 .doc(docId)
//                 .collection(subCollectionName)
//                 .where(whereField, isNotEqualTo: filters)
//                 .snapshots();
//       case FirestoreFilters.isEqual:
//         return (subCollectionName.isEmpty && docId.isEmpty)
//             ? firestore
//                 .collection(collectionName)
//                 .where(whereField, isEqualTo: filters)
//                 .snapshots()
//             : firestore
//                 .collection(collectionName)
//                 .doc(docId)
//                 .collection(subCollectionName)
//                 .where(whereField, isEqualTo: filters)
//                 .snapshots();
//       case FirestoreFilters.greaterThanOrEqual:
//         return (subCollectionName.isEmpty && docId.isEmpty)
//             ? firestore
//                 .collection(collectionName)
//                 .where(whereField, isGreaterThanOrEqualTo: filters)
//                 .snapshots()
//             : firestore
//                 .collection(collectionName)
//                 .doc(docId)
//                 .collection(subCollectionName)
//                 .where(whereField, isGreaterThanOrEqualTo: filters)
//                 .snapshots();
//       default:
//         return getDocumentsAsStream(
//           collectionName: collectionName,
//           docId: docId,
//           subCollectionName: subCollectionName,
//         );
//     }
//   }

//   ///[getCompletedAsStream] is used to get the documents for the status complete
//   /// having endDate greater than or equal to present date
//   // TODO(Balaji): Need to find a way for multiple where conditions
//   static Stream<QuerySnapshot> getCompletedAsStream({
//     @required String collectionName,
//     String docId = '',
//     String subCollectionName = '',
//     TimeZone timeZone,
//   }) {
//     DateTime now = Helpers.getCurrentTime(timeZone).subtract(Duration(days: 3));
//     // gets the completed challenge with descending order of end date as we have to
//     // hide the today's completed challenges from new challenges
//     return firestore
//         .collection(collectionName)
//         .doc(docId)
//         .collection(subCollectionName)
//         .where('status', isEqualTo: 'complete')
//         .where('endDate', isGreaterThanOrEqualTo: now)
//         .orderBy('endDate', descending: true)
//         .snapshots();
//   }

//   ///[getExtendedAsStream]is used to get the documents for the new and active challenges having ChallengeNature Extended
//   static Stream<QuerySnapshot> getExtendedAsStream({
//     @required String collectionName,
//     String docId = '',
//     String subCollectionName = '',
//   }) {
//     return firestore
//         .collection(collectionName)
//         .doc(docId)
//         .collection(subCollectionName)
//         .where('status', whereIn: ['new', 'active'])
//         .where('challengeNature', isEqualTo: 'extended')
//         .snapshots();
//   }
// }

// enum FirestoreFilters {
//   isEqual,
//   isNotEqual,
//   arrayContains,
//   whereIn,
//   greaterThanOrEqual,
// }
