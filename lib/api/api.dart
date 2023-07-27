import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  CollectionReference getCollection(
      {required String collection, String? path, String? subCollection}) {
    var newCollection = FirebaseFirestore.instance.collection(collection);
    if (path != null && subCollection != null) {
      newCollection = newCollection.doc(path).collection(subCollection);
    }
    return newCollection;
  }

  Future<QuerySnapshot<Object?>> readCollection(
      {required String collection, String? path, String? subCollection}) async {
    return await getCollection(
            collection: collection, path: path, subCollection: subCollection)
        .get();
  }

  Future<DocumentSnapshot<Object?>> readPath(
      {required String collection,
      required String path,
      String? subCollection,
      String? subPath}) async {
    return await getCollection(
            collection: collection, path: subPath, subCollection: subCollection)
        .doc(path)
        .get();
  }

  Future<void> write(
      {required String collection,
      required String path,
      required Map<String, Object?> data,
      String? subCollection,
      String? subPath}) {
    return getCollection(
            collection: collection, path: subPath, subCollection: subCollection)
        .doc(path)
        .set(data);
  }

  Future<void> update(
      {required String collection,
      required String path,
      required Map<String, Object?> data,
      String? subCollection,
      String? subPath}) {
    return getCollection(
            collection: collection, path: subPath, subCollection: subCollection)
        .doc(path)
        .update(data);
  }

  Future<void> delete(
      {required String collection,
      required String path,
      String? subCollection,
      String? subPath}) {
    return getCollection(
            collection: collection, path: subPath, subCollection: subCollection)
        .doc(path)
        .delete();
  }

  Future<void> updateOrWrite(
      {required String collection,
      required String path,
      required Map<String, Object?> data,
      String? subCollection,
      String? subPath}) async {
    try {
      await update(
          collection: collection,
          subCollection: subCollection,
          subPath: subPath,
          path: path,
          data: data);
    } catch (e) {
      await write(
          collection: collection,
          subCollection: subCollection,
          subPath: subPath,
          path: path,
          data: data);
    }
  }

  Stream<DocumentSnapshot<Object?>> getStream(
      {required String collection, String? path}) {
    return getCollection(collection: collection).doc(path).snapshots();
  }
}
