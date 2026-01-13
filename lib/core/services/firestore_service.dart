import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get instance => _firestore;

  // CREATE / UPDATE
  Future<void> setData({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    await _firestore
        .collection(collection)
        .doc(docId)
        .set(data, SetOptions(merge: merge));
  }

  // READ BY ID
  Future<DocumentSnapshot<Map<String, dynamic>>> getById({
    required String collection,
    required String docId,
  }) async {
    return await _firestore.collection(collection).doc(docId).get();
  }

  // DELETE
  Future<void> delete({
    required String collection,
    required String docId,
  }) async {
    await _firestore.collection(collection).doc(docId).delete();
  }

  // STREAM COLLECTION
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required String collection,
  }) {
    return _firestore.collection(collection).snapshots();
  }

  // QUERY (IMPORTANT – fixes your error)
  Query<Map<String, dynamic>> query({
    required String collection,
  }) {
    return _firestore.collection(collection);
  }
}
