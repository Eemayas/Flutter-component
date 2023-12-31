// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:radiology/Pages/Case/case.dart';
import 'package:radiology/db/objbox.dart';
import 'package:radiology/objectbox.g.dart';
import './Pages/Settings/settings.dart';
import 'Pages/Home/home.dart';
import 'Pages/Settings/Componet/Provider/value.dart';
import 'package:objectbox/objectbox.dart' as objectbox;

const APP_NAME = "Radiology";

GoRouter _router = GoRouter(routes: [
  GoRoute(
      name: "home",
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return Home();
      },
      routes: [
        GoRoute(
            name: "case",
            path: "case",
            builder: (BuildContext context, GoRouterState state) {
              return Case(
                caseStorage: state.extra as CaseStorage,
              );
            }),
        GoRoute(
            name: "settings",
            path: "settings",
            builder: (BuildContext context, GoRouterState state) {
              return const Settings();
            }),
      ]),
]);

class App extends HookWidget {
  //final storage_permission = Permission.storage;
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage_permission = Permission.storage;

  if (await storage_permission.isDenied) {
    await storage_permission.request();
  }

  var sensitivityValue = await SensitivityValue.fromSharedPref();
  var resolveValue = await ResolveValue.fromSharedPref();
  objectbox.Store store =
      objectbox.Store(getObjectBoxModel(), directory: join((await getApplicationDocumentsDirectory()).path, "objectbox"));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => sensitivityValue),
      ChangeNotifierProvider(create: (_) => resolveValue),
      ChangeNotifierProvider(create: (_) => loadValue()),
      Provider(create: (_) => store)
    ],
    child: const App(),
  ));
}
