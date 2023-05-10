import 'package:al_quran/providers/onboarding_provider.dart';
import 'package:al_quran/screens/page/about.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_quran/cubits/juz/cubit.dart';
import 'package:al_quran/cubits/chapter/cubit.dart';
import 'package:al_quran/screens/splash_screen.dart';
import 'package:al_quran/providers/app_provider.dart';
import 'package:al_quran/cubits/bookmarks/cubit.dart';
import 'package:al_quran/screens/home/home_screen.dart';
import 'package:al_quran/screens/juz/juz_index_screen.dart';
import 'package:al_quran/screens/surah/surah_index_screen.dart';
import 'package:al_quran/screens/share_app/share_app_screen.dart';
import 'package:al_quran/screens/bookmarks/bookmarks_screen.dart';
import 'package:al_quran/screens/onboarding/onboarding_screen.dart';
import 'package:al_quran/screens/help_guide/help_guide_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'configs/core_theme.dart' as theme;
import 'cubits/sura/cubit.dart';
import 'firebase_options.dart';

// initData() async {
//   // NewDbOpen dbOpen = NewDbOpen();

//   await dbOpen.openDb();

//   await dbOpen.readData();
// }

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // hive
  // await Hive.initFlutter();

  // Hive.registerAdapter<Juz>(JuzAdapter());
  // Hive.registerAdapter<Ayah>(AyahAdapter());
  // Hive.registerAdapter<SuraName>(SuraNameAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => JuzCubit()),
        BlocProvider(create: (_) => SurasCubit()),
        BlocProvider(create: (_) => ChapterCubit()),
        BlocProvider(create: (_) => BookmarkCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: ((context, value, child) {
          return MaterialChild(
            value: value,
          );
        }),
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final AppProvider? value;
  const MaterialChild({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shina Quran',
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      themeMode: value!.themeMode,
      home: Builder(
        builder: (context) => HomeScreen(
          maxSlide: MediaQuery.of(context).size.width * 0.835,
        ),
      ),
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{
        '/splash': (context) => const SplashScreen(),
        '/help': (context) => const HelpGuide(),
        '/about': (context) => const About(),
        '/share': (context) => const ShareAppScreen(),
        '/intro': (context) => const OnboardingScreen(),
        '/juzIndex': (context) => const JuzIndexScreen(),
        '/bookmarks': (context) => const BookmarksScreen(),
        '/surahIndex': (context) => const SurahIndexScreen(),
        '/home': (context) =>
            HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835),
      },
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data);
}
