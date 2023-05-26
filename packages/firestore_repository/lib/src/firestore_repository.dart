import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firestore_repository/src/models/models.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

class FirestoreRepository {
  /// {@macro authentication_repository}
  FirestoreRepository({
    FirebaseFirestore? firestore,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Future<User?> get currentUserData async {
    final docRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final user = User.fromFirestore(data);
        return user;
      },
      onError: (e) {
        print("Error getting document: $e");
        throw (e);
      },
    );
    return await docRef;
  }

  Future<List<Kno>> get knoData async {
    List<Kno> knoList = [];
    final colRef = _firestore.collection('kno');
    QuerySnapshot snapshot = await colRef.get();
    for (int i = 0; i < snapshot.docs.length; ++i) {
      final String knoId = snapshot.docs[i].id;
      final data = snapshot.docs[i].data() as Map<String, dynamic>;
      final String knoName = data['name'];
      final List<String> knoInspectors = List.from(data['inspectorsId']);
      final colRefInspections =
          _firestore.collection('kno/$knoId/inspectionType');
      Map<String, List<String>> knoInspectionTypes = {};
      QuerySnapshot snapshotInspections = await colRefInspections.get();
      for (int j = 0; j < snapshotInspections.docs.length; ++j) {
        final dataInspection =
            snapshotInspections.docs[j].data() as Map<String, dynamic>;
        knoInspectionTypes[snapshotInspections.docs[j].id] =
            List.from(dataInspection['topics']);
      }
      knoList.add(Kno(knoId, knoName, knoInspectors, knoInspectionTypes));
    }
    return await knoList;
  }

  Future<Map<DateTime, List<FreeSlot>>> getFreeSlots(String knoId) async {
    Map<DateTime, List<FreeSlot>> freeSlots = {};
    final colRef = _firestore.collection('kno/$knoId/freeSlots');
    QuerySnapshot snapshot = await colRef.get();
    for (int i = 0; i < snapshot.docs.length; ++i) {
      final data = snapshot.docs[i].data() as Map<String, dynamic>;
      final dateStart = data['dateStart']!.toDate();
      final dateEnd = data['dateEnd']!.toDate();
      final day = DateTime(dateStart.year, dateStart.month, dateStart.day);
      if (freeSlots.containsKey(day)) {
        freeSlots[day]!.add(FreeSlot(dateStart, dateEnd));
      } else {
        freeSlots[day] = [FreeSlot(dateStart, dateEnd)];
      }
    }
    return await freeSlots;
  }
}
