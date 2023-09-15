import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/observer/app_bloc_observer.dart';
import 'utils/object_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  ObjectFactory().setPrefs(sharedPreferences);
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

