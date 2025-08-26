import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/* Example of go_router with named routes

This scenario demonstrates how to navigate using named locations instead of
URLs.

Instead of hardcoding the URI locations , you can also use the named
locations. To use this API, give a unique name to each GoRoute. The name can
then be used in context.namedLocation to be translate back to the actual URL
location.

data model : 
  Artist created a collection of ArtObject
  

 */

/// Artist data class.
class Artist {
  /// Create a artist.
  const Artist({
    required this.id,
    required this.name,
    required this.mapIdArtwork,
  });

  final int id;

  /// The name of the artist.
  final String name;

  /// created artworks (art object)
  final Map<int, Artwork> mapIdArtwork;
}

/// Person data class.
class Artwork {
  /// Creates a person.
  const Artwork({required this.id, required this.name});
  final int id;

  /// The first name of the person.
  final String name;
}

const Map<int, Artist> mapIdArtist = <int, Artist>{
  1: Artist(
    id: 1,
    name: 'Doe',
    mapIdArtwork: <int, Artwork>{
      1001: Artwork(id: 1001, name: 'ballad'),
      1002: Artwork(id: 1002, name: 'djmix'),
    },
  ),
  2: Artist(
    id: 2,
    name: 'Wong',
    mapIdArtwork: <int, Artwork>{
      2001: Artwork(id: 2001, name: 'landscape'),
      2002: Artwork(id: 2002, name: 'pottery'),
    },
  ),
};

void main() => runApp(App());

/// The main app.
class App extends StatelessWidget {
  /// Creates an [App].
  App({super.key});

  /// The title of the app.
  static const String title = 'GoRouter Example: Named Routes';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: _router,
    title: title,
    debugShowCheckedModeBanner: false,
  );

  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        name: 'home',
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
        routes: <GoRoute>[
          GoRoute(
            name: 'artist',
            path: 'artist/:artistid',
            builder: (BuildContext context, GoRouterState state) =>
                ArtistScreen(artistid: state.pathParameters['artistid']!),
            routes: <GoRoute>[
              GoRoute(
                name: 'artwork',
                path: 'artwork/:artid',
                builder: (BuildContext context, GoRouterState state) {
                  return ArtworkScreen(
                    artistid: state.pathParameters['artistid']!,
                    artworkid: state.pathParameters['artid']!,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// The home screen that shows a list of artist (as Tiles).
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(App.title)),
      body: ListView(
        children: <Widget>[
          // make a :widget:ListTile
          for (final MapEntry<int, Artist> entry in mapIdArtist.entries)
            ListTile(
              title: Text(entry.value.name),
              onTap: () => context.go(
                context.namedLocation(
                  'artist',
                  pathParameters: <String, String>{
                    'artistid': entry.key.toString(),
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// The screen that shows a list of persons in a family.
class ArtistScreen extends StatelessWidget {
  /// Creates a [ArtistScreen].
  const ArtistScreen({required this.artistid, super.key});

  /// The id family to display.
  final String artistid;

  @override
  Widget build(BuildContext context) {
    final Map<int, Artwork> mapIdArtwork = mapIdArtist[artistid]!.mapIdArtwork;
    return Scaffold(
      appBar: AppBar(title: Text(mapIdArtist[artistid]!.name)),
      body: ListView(
        children: <Widget>[
          for (final MapEntry<int, Artwork> entry in mapIdArtwork.entries)
            ListTile(
              title: Text(entry.value.name),
              onTap: () => context.go(
                context.namedLocation(
                  'artwork',
                  pathParameters: <String, String>{
                    'artistid': artistid.toString(),
                    'artworkid': entry.key.toString(),
                  },
                  queryParameters: <String, String>{'qid': 'quid'},
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// The person screen.
class ArtworkScreen extends StatelessWidget {
  /// Creates a [ArtworkScreen].
  const ArtworkScreen({
    required this.artistid,
    required this.artworkid,
    super.key,
  });

  /// The id of family this person belong to.
  final String artistid;

  /// The id of the person to be displayed.
  final String artworkid;

  @override
  Widget build(BuildContext context) {
    final Artist artist = mapIdArtist[artistid]!;
    final Artwork artwork = artist.mapIdArtwork[artworkid]!;
    return Scaffold(
      appBar: AppBar(title: Text(artwork.name)),
      body: Text('${artist.name} created ${artwork.name} '),
    );
  }
}
