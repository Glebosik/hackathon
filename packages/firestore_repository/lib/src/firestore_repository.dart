import 'dart:async';

import 'package:cache/cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firestore_repository/src/models/models.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

class FirestoreRepository {
  /// {@macro authentication_repository}
  FirestoreRepository({
    CacheClient? cache,
    FirebaseFirestore? firestore,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final CacheClient _cache;

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
}
