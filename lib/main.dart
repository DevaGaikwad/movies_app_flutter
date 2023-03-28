import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'api.dart';
import 'movie.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List Demo',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
                    body: TabBarView(
            children: [
              MoviesListPage2(),
              MoviesListPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final ApiService _apiService = ApiService();
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _latestMovies;

  @override
  void initState() {
    super.initState();
    _popularMovies = _apiService.getPopularMovies();
    _latestMovies = _apiService.getLatestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Popular'),
              Tab(text: 'Latest'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          )
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [

            Expanded(
              child:
                  FutureBuilder(
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

            ),
          ],
        ),
      ),
    );
  }
}

class MoviesListPage2 extends StatefulWidget {
  @override
  _MoviesListPageState2 createState() => _MoviesListPageState2();
}

class _MoviesListPageState2 extends State<MoviesListPage2> {
  final ApiService _apiService = ApiService();
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _latestMovies;

  @override
  void initState() {
    super.initState();
    _popularMovies = _apiService.getPopularMovies();
    _latestMovies = _apiService.getLatestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Popular'),
              Tab(text: 'Latest'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          )
      ),
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: [

            Expanded(
              child:
                  FutureBuilder(
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

            ),
          ],
        ),
      ),
    );
  }
}

