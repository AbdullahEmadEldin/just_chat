import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/dependency_injection.dart';

class FirestoreServices {
  FirestoreServices._();
  static final instance = FirestoreServices._();

  Future<void> setData({
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    final reference = getIt<FirebaseFirestore>().doc(documentPath);
    debugPrint('Request data: $data');
    await reference.set(data);
  }

  Future<void> deleteData({required String documentPath}) async {
    final reference = getIt<FirebaseFirestore>().doc(documentPath);
    debugPrint('Path: $documentPath');
    await reference.delete();
  }

  Stream<T> documentsStream<T>({
    required String documentPath,
    required T Function(Map<String, dynamic>? jsonData, String documentID)
        deMapping,
  }) {
    final reference = getIt<FirebaseFirestore>().doc(documentPath);

    final streamSnapshots = reference.snapshots();

    return streamSnapshots.map((doc) => deMapping(doc.data(), doc.id));
  }

  //TODO: this function isn't clear enough for me
  Stream<List<T>> collectionsStream<T>({
    required String collectionPath,
    required T Function(Map<String, dynamic>? data, String documentID)
        deMapping,

    ///this function called if you want to query or filter the docs of the collection
    ///this function takes Qury as paramter and return Query output
    ///this function is the process that will be acted on data
    Query Function(Query query)? queryPeocess,
    int Function(T lhs, T rhs)? sort,
  }) {
    ///this query is the structre that you will perform queries on it
    Query query = getIt<FirebaseFirestore>().collection(collectionPath);
    if (queryPeocess != null) {
      ///this condition means that if you passed queryProcess to that function
      /// so, make that process on that query
      query = queryPeocess(query);
    }

    /// Why I creatd an object of QuerySnapshot ? ==> because it contain data retrieved from database
    /// and it include methods to access and manipluate data as iterating over the docs (map method)
    final querysnapshotsStream = query.snapshots();

    return querysnapshotsStream.map((querySnapshot) {
      final result = querySnapshot.docs
          .map((docSanpshot) => deMapping(
              docSanpshot.data() as Map<String, dynamic>, docSanpshot.id))
          .where((value) => value != null)
          .toList();
      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      if (sort != null) result.sort(sort);
      return result;
    });
  }
}
