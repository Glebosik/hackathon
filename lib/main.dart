import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/app/app.dart';
import 'package:hackathon/firebase_options.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestoreRepository = FirestoreRepository();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );

  //TODO
  List<SvgAssetLoader> loaders = [];
  loaders.add(SvgAssetLoader(Assets.icons.cloudLogo.path));
  loaders.add(SvgAssetLoader(Assets.icons.logoName.path));
  loaders.add(SvgAssetLoader(Assets.icons.moscow.path));
  loaders.add(SvgAssetLoader(Assets.icons.moscowAccess.path));
  for (int i = 0; i < loaders.length; ++i) {
    svg.cache.putIfAbsent(
        loaders[i].cacheKey(null), () => loaders[i].loadBytes(null));
  }

  runApp(App(
    authenticationRepository: authenticationRepository,
    firestoreRepository: firestoreRepository,
  ));
}
