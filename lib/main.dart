import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'api.dart';
import 'movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> _tabs = [  PopularTab(), LatestTab(),  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'Latest',
          ),

        ],
      ),
    );
  }
}

class LatestTab extends StatefulWidget {
  /*@override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Latest Movies'),
    );
  }*/
  @override
  _MoviesListPageState1 createState() => _MoviesListPageState1();
}
class _MoviesListPageState1 extends State<LatestTab> {
  final ApiService _apiService = ApiService();
  // late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _latestMovies;

  @override
  void initState() {
    super.initState();
    // _popularMovies = _apiService.getPopularMovies();
    _latestMovies = _apiService.getLatestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _latestMovies,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = snapshot.data![index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  trailing: Text(movie.voteAverage.toString()),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

    );
  }
}

class PopularTab extends StatefulWidget {
  @override
  _MoviesListPageState2 createState() => _MoviesListPageState2();
}

class _MoviesListPageState2 extends State<PopularTab> {
  final ApiService _apiService = ApiService();
  late Future<List<Movie>> _popularMovies;
  // late Future<List<Movie>> _latestMovies;

  @override
  void initState() {
    super.initState();
    _popularMovies = _apiService.getPopularMovies();
    // _latestMovies = _apiService.getLatestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
                future: _popularMovies,
                builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final movie = snapshot.data![index];
                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          title: Text(movie.title),
                          subtitle: Text(movie.overview),
                          trailing: Text(movie.voteAverage.toString()),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),

    );
  }
}
