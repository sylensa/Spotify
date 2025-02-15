import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spotify/controllers/album/album_controller.dart';
import 'package:spotify/controllers/artist/artist_controller.dart';
import 'package:spotify/controllers/authentication/authentication_controller.dart';
import 'package:spotify/controllers/conectivity_controller/connectivity_cubit.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/flavor_settings.dart';
import 'package:spotify/repository/authentication_repo.dart';
import 'package:spotify/screens/search_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlavorSettings.init(FlavorType.DEV);
 final toeks = await AuthenticationRepo().getSpotifyAccessToken();
  print('toeks: $toeks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationController>(
          create: (context) => AuthenticationController(AuthenticationRepo())..getSpotifyToken(),
        ),
        BlocProvider<AlbumController>(
          create: (context) => AlbumController(),
        ),
        BlocProvider<ArtistController>(
          create: (context) => ArtistController(),
        ),
        BlocProvider<ConnectivityCubit>(
          create: (context) => ConnectivityCubit(),
        ),
      ],
      child:  FlavorBanner(
        child:MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
            boldText: false,
          ),
          child:  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: rootNavigatorKey,
            title: 'Spotify',
            theme: ThemeData(
                useMaterial3: false,
                fontFamily: "Proxima",
                brightness: Brightness.light
            ),
            home:  SearchScreen(),
          ),
        ),
      ),
    );
  }
}


