// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:mytv/firebase.dart';
// import 'package:mytv/models/boardModel.dart';
// import 'package:pretty_json/pretty_json.dart';


// class BoardService {
//   // static const List<String> _filters = [
//   //   constants.CHALLENGES_STATUS_ACTIVE,
//   //   constants.CHALLENGES_STATUS_PAUSE
//   // ];

//   /// [getUserChallenges] return list of challenges user has in the bucket.

// Future<Map<String, BoardModel>> getpraiseBoardData() async {
//   //   BoardModel data ;
//   //       List<QueryDocumentSnapshot> dataList = [];
//   //   Future<QuerySnapshot> querySnapShot =
//   //     FirebaseService.getDocumentsAsFuture(
    
//   //       print(querySnapShot);
//   //   await querySnapShot.then((pariseboardData) {
//   //     print(data);
//   //     dataList=pariseboardData.docs;
    
//   //   });
//   //  // data=dataList;
//   //     dataList.asMap().forEach((key, value) {
//   //       print(value);
//   //       data=value;
//   //       // data.data.add(
//   //       //   BoardModel.fromJson(value.data().["data"]),
//   //       // );
//   //     });
//   //   return data;

// Map<String,BoardModel> offsetActivityList ;
//     Future<QuerySnapshot> querySnapShot = FirebaseService.getDocumentsAsFuture(
//         collectionName: 'praiseboard',
//         docId : '1234');
//     await querySnapShot.then((offsetActivitiesData) {
// offsetActivityList=offsetActivitiesData.docs;
//     }

//   //             print(prettyJson(offsetActivitiesData, indent: 2));
//   // printPrettyJson(offsetActivitiesData);
  
//       offsetActivitiesData.docs.forEach((offsetActivities) {


// //  print(prettyJson(offsetActivitiesData.docs, indent: 2));
// //   printPrettyJson(offsetActivitiesData.docs);

//         offsetActivityList.add(
//           BoardModel.fromJson(
//             offsetActivities.data(),
//           ),
//         );
//       });
//     });
//  print(prettyJson(offsetActivityList, indent: 2));
//   printPrettyJson(offsetActivityList);
//       print(offsetActivityList);
// return offsetActivityList;
//   }
// }