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

  Future<User?> getUserData(String userId) async {
    final docRef = _firestore.collection('users').doc(userId).get().then(
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

  Future<List<Application>> getUserApplications() async {
    List<Application> applications = [];
    final userId = _firebaseAuth.currentUser!.uid;
    final colRef = _firestore.collection('users/$userId/applications');
    QuerySnapshot snapshot = await colRef.get();
    for (int i = 0; i < snapshot.docs.length; ++i) {
      final data = snapshot.docs[i].data() as Map<String, dynamic>;
      applications.add(Application.fromFirestore(data));
    }
    return await applications;
  }

  Future<List<ApplicationUser>> getInspectorApplicationsWaiting() async {
    List<ApplicationUser> applications = [];
    final userId = _firebaseAuth.currentUser!.uid;
    final colRef = _firestore.collection('inspectors/$userId/applications');
    QuerySnapshot snapshot = await colRef.get();
    for (int i = 0; i < snapshot.docs.length; ++i) {
      final data = snapshot.docs[i].data() as Map<String, dynamic>;
      final user = await getUserData(data['applicantId']);
      applications.add(ApplicationUser(
          application:
              Application.fromFirestoreInspector(data, 'На рассмотрении'),
          user: user!));
    }
    return await applications;
  }

  Future<List<ApplicationUser>> getInspectorApplicationsApproved() async {
    List<ApplicationUser> applications = [];
    final userId = _firebaseAuth.currentUser!.uid;
    final colRef = _firestore.collection('inspectors/$userId/approved');
    QuerySnapshot snapshot = await colRef.get();
    for (int i = 0; i < snapshot.docs.length; ++i) {
      final data = snapshot.docs[i].data() as Map<String, dynamic>;
      final user = await getUserData(data['applicantId']);
      applications.add(ApplicationUser(
          application: Application.fromFirestoreInspector(data, 'Подтверждена'),
          user: user!));
    }
    return await applications;
  }

  Future<void> approveApplication(Application application) async {
    final String docId =
        '${application.applicantId} ${application.knoId} ${application.dateStart}';
    _firestore
        .doc('inspectors/${application.inspectorId}/applications/$docId')
        .delete();
    _firestore
        .doc('inspectors/${application.inspectorId}/approved/$docId')
        .set({
      'applicantId': application.applicantId,
      'dateStart': application.dateStart,
      'dateEnd': application.dateEnd,
      'inspectionType': application.inspectionType,
      'inspectionTopic': application.inspectionTopic,
      'inspectorId': application.inspectorId,
      'kno': application.knoId,
      'knoName': application.knoName,
      'status': 'Подтверждена',
    });
    _firestore
        .doc('users/${application.applicantId}/applications/$docId')
        .update({
      'status': 'Подтверждена',
    });
  }

  Future<void> declineApplication(Application application) async {
    final String docId =
        '${application.applicantId} ${application.knoId} ${application.dateStart}';
    _firestore
        .doc('inspectors/${application.inspectorId}/applications/$docId')
        .delete();
    _firestore
        .doc('users/${application.applicantId}/applications/$docId')
        .update({
      'status': 'Отклонена',
    });
    _firestore
        .doc('kno/${application.knoId}/freeSlots/${application.dateStart}')
        .set({
      'dateStart': application.dateStart,
      'dateEnd': application.dateEnd,
    });
  }

  Future<Map<String, dynamic>> getConferenceData() async {
    final docRef = await _firestore.doc('agora/agora').get();
    return docRef.data() as Map<String, dynamic>;
  }
}
