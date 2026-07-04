import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// Removed unused external package imports to avoid missing package errors.
void main() {
  runApp(const CinemaTixApp());
}

class CinemaTixApp extends StatelessWidget {
  const CinemaTixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CinemaTix',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff0F172A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        // Use default dark text theme to avoid requiring GoogleFonts package
        textTheme: ThemeData.dark().textTheme,
      ),
      home: const SplashScreen(),
    );
  }
}

class Movie {
  final String title;
  final String poster;
  final String backdrop;
  final String genre;
  final String duration;
  final double rating;
  final String synopsis;

  const Movie({
    required this.title,
    required this.poster,
    required this.backdrop,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.synopsis,
  });
}

final List<Movie> favoriteMovies = [];

List<String> myTickets = [];

bool hasTicket = false;

final List<Movie> movies = [

  Movie(
    title: "Dune Part Two",

    poster:
        "https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
    backdrop:
        "https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
    genre: "Sci-Fi",
    duration: "2h 46m",
    rating: 8.8,
    synopsis:
        "Paul Atreides joins the Fremen to seek revenge while becoming the prophesied leader of Arrakis.",
  ),
  Movie(
    title: "Godzilla x Kong",
    poster:
        "https://image.tmdb.org/t/p/w500/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg",
    backdrop:
        "https://image.tmdb.org/t/p/original/z8d8A8wQ8PZ0jQJ6j8lR7X2Yw9D.jpg",
    genre: "Action",
    duration: "1h 55m",
    rating: 7.7,
    synopsis:
        "Godzilla and Kong must unite against a new threat hidden inside Hollow Earth.",
  ),
  Movie(
  title: "Deadpool & Wolverine",
  poster: "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg",
  genre: "Action",
  duration: "2h 8m",
  rating: 8.3,
  synopsis: "Deadpool teams up with Wolverine to save the multiverse.",
),

Movie(
  title: "Inside Out 2",
  poster: "https://image.tmdb.org/t/p/w500/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/stKGOm8UyhuLPR9sZLjs5AkmncA.jpg",
  genre: "Animation",
  duration: "1h 36m",
  rating: 8.1,
  synopsis: "Riley faces new emotions as she enters her teenage years.",
),

Movie(
  title: "Kung Fu Panda 4",
  poster: "https://image.tmdb.org/t/p/w500/nqXsAaQsKw2gKpkfhIgjXNDRqg7.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/kYgQzzjNis5jJalYtIHgrom0gOx.jpg",
  genre: "Animation",
  duration: "1h 34m",
  rating: 7.5,
  synopsis: "Po searches for his successor while facing a dangerous villain.",
),

Movie(
  title: "The Batman",
  poster: "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/b0PlSFdDwbyK0cf5RxwDpaOJQvQ.jpg",
  genre: "Action",
  duration: "2h 56m",
  rating: 8.4,
  synopsis: "Batman investigates a series of murders committed by the Riddler.",
),

Movie(
  title: "Spider-Man: No Way Home",
  poster: "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
  genre: "Action",
  duration: "2h 28m",
  rating: 8.6,
  synopsis: "Spider-Man seeks Doctor Strange's help after his identity is revealed.",
),

Movie(
  title: "Avatar: The Way of Water",
  poster: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/s16H6tpK2utvwDtzZ8Qy4qm5Emw.jpg",
  genre: "Sci-Fi",
  duration: "3h 12m",
  rating: 7.9,
  synopsis: "Jake Sully protects his family from a returning threat.",
),

Movie(
  title: "Oppenheimer",
  poster: "https://image.tmdb.org/t/p/w500/ptpr0kGAckfQkJeJIt8st5dglvd.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg",
  genre: "Drama",
  duration: "3h 0m",
  rating: 8.5,
  synopsis: "The story of J. Robert Oppenheimer and the atomic bomb.",
),

Movie(
  title: "John Wick: Chapter 4",
  poster: "https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/h8gHn0OzBoaefsYseUByqsmEDMY.jpg",
  genre: "Action",
  duration: "2h 49m",
  rating: 8.0,
  synopsis: "John Wick faces the High Table in his toughest battle yet.",
),

Movie(
  title: "The Super Mario Bros. Movie",
  poster: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
  genre: "Animation",
  duration: "1h 32m",
  rating: 7.7,
  synopsis: "Mario and Luigi enter the Mushroom Kingdom to save Princess Peach.",
),

Movie(
  title: "Mission: Impossible - Dead Reckoning",
  poster: "https://image.tmdb.org/t/p/w500/NNxYkU70HPurnNCSiCjYAmacwm.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/628Dep6AxEtDxjZoGP78TsOxYbK.jpg",
  genre: "Action",
  duration: "2h 43m",
  rating: 8.0,
  synopsis: "Ethan Hunt races to stop a dangerous AI weapon.",
),
Movie(
  title: "Agak Laen",
 poster:
"https://upload.wikimedia.org/wikipedia/id/8/82/Agak_Laen.jpg",

  backdrop: "https://image.tmdb.org/t/p/original/fTzqkM8xQ0qL7sQ0kH5u9g0v7hQ.jpg",
  genre: "Comedy",
  duration: "1h 59m",
  rating: 8.3,
  synopsis:
      "Empat sahabat mengelola rumah hantu yang tiba-tiba menjadi viral setelah sebuah kejadian tak terduga.",
),

Movie(
  title: "Pengabdi Setan 2",
  poster:
"https://upload.wikimedia.org/wikipedia/id/0/0b/Pengabdi_Satan_2.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/3jSxS9zK0dQYb2Kx4gX8v2M4kQY.jpg",
  genre: "Horror",
  duration: "1h 59m",
  rating: 7.6,
  synopsis:
      "Teror kembali menghantui sebuah keluarga yang pindah ke rumah susun tua.",
),

Movie(
  title: "KKN di Desa Penari",
  poster:
"https://upload.wikimedia.org/wikipedia/id/5/5f/KKN_di_Desa_Penari.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/k7Q4vK0fWm5uR5QjA0jQwLrV3rM.jpg",
  genre: "Horror",
  duration: "2h 10m",
  rating: 7.1,
  synopsis:
      "Sekelompok mahasiswa mengalami kejadian mistis saat menjalani KKN di sebuah desa terpencil.",
),

Movie(
  title: "Miracle in Cell No. 7",
 poster:
"https://upload.wikimedia.org/wikipedia/id/5/56/Miracle_in_Cell_No._7_%28film_Indonesia%29.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/h4vK2fP7jY8Q9sL3mD7nT4Q2P9A.jpg",
  genre: "Drama",
  duration: "2h 25m",
  rating: 8.4,
  synopsis:
      "Seorang ayah dengan keterbatasan intelektual berjuang untuk bertemu kembali dengan putrinya.",
),

Movie(
  title: "Siksa Kubur",
  poster: "https://image.tmdb.org/t/p/w500/z3P8n4j9K7Y0kL2fM8nV3Q9hP2R.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/q9L5vN8dM3kP2rF7hW6jX1aT9Q.jpg",
  genre: "Horror",
  duration: "1h 57m",
  rating: 7.5,
  synopsis:
      "Seorang wanita mencari bukti tentang siksa kubur dengan menghadapi kejadian-kejadian mengerikan.",
),

Movie(
  title: "Warkop DKI Reborn",
  poster: "https://image.tmdb.org/t/p/w500/7rXj0mJQ2dP8L5hY4vN9kA3bF6Q.jpg",
  backdrop: "https://image.tmdb.org/t/p/original/d6QkM8nP4vT2rY9hL5jW3aF7Q8X.jpg",
  genre: "Comedy",
  duration: "1h 34m",
  rating: 6.9,
  synopsis:
      "Petualangan kocak Dono, Kasino, dan Indro dalam versi modern.",
),
];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.local_movies,
              size: 90,
              color: Colors.orange.shade400,
            ),

            const SizedBox(height: 20),

            Text(
              "CinemaTix",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 10),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 40),

              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Login to continue",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Create Account"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;

  final pages = [
  HomeScreen(),
  SearchScreen(),
  FavoriteScreen(),
  ProfileScreen(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final crossAxis =
        width > 1400 ? 7 :
        width > 1100 ? 6 :
        width > 900 ? 5 :
        width > 700 ? 4 :
        width > 500 ? 3 : 2;

    return SafeArea(
      child: ListView(
        children: [

                    Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Good Evening 👋",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Arjuna",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
  children: [

    
    Row(
  children: [

    if (hasTicket)

      IconButton(
  icon: const Icon(Icons.confirmation_number_outlined),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MyTicketScreen(),
      ),
    );
  },
),

    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.notifications_none),
    ),
  ],
),
  ],
)
              ],
            ),
          ),

          const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search movie...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: PageController(viewportFraction: .9),
              itemCount: movies.length,
              itemBuilder: (_, index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          movie.backdrop,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black87,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.genre,
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 45,
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              children: [

                _category("All", true),
                _category("Action", false),
                _category("Sci-Fi", false),
                _category("Comedy", false),
                _category("Drama", false),
                _category("Animation", false),
                _category("Horror", false),

              ],
            ),
          ),

          const SizedBox(height: 30),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: 
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "Now Playing",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AllMoviesScreen(),
      ),
    );
  },
  child: const Text(
    "See All",
    style: TextStyle(
      color: Colors.orange,
      fontWeight: FontWeight.bold,
    ),
  ),
),

              ],
            ),
          ),

          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.62,
            ),
            itemCount: movies.length,
            itemBuilder: (_, index) {
              final movie = movies[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(movie: movie),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: movie.title,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            movie.poster,
                            width: 180,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(movie.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _category(
      String title,
      bool selected,
      ) {

    return Container(
      
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        backgroundColor:
            selected ? Colors.orange : Colors.grey[900],
        label: Text(title),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(movie.title),

  actions: [

    IconButton(
onPressed: () {

  if (!favoriteMovies.contains(movie)) {
    favoriteMovies.add(movie);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Added to Favorite ❤️"),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Already in Favorite"),
      ),
    );
  }

},
      

      icon: const Icon(
        Icons.favorite_border,
      ),

    ),

  ],

),
      body: ListView(
        children: [

          Hero(
            tag: movie.title,
            child: Image.network(
              movie.poster,
              width: double.infinity,
              height: 420,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [

                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),

                    const SizedBox(width: 6),

                    Text(movie.rating.toString()),

                    const SizedBox(width: 20),

                    Text(movie.genre),

                    const SizedBox(width: 20),

                    Text(movie.duration),

                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  "Synopsis",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  movie.synopsis,
                  style: const TextStyle(
                    height: 1.6,
                  ),
                ),

const SizedBox(height: 25),

const Divider(),

const SizedBox(height: 15),

Row(

  mainAxisAlignment:
      MainAxisAlignment.spaceAround,

  children: [

    Column(

      children: [

        Icon(
          Icons.movie_creation_outlined,
          color: Colors.orange,
        ),

        SizedBox(height: 5),

        Text("Studio 3"),

      ],

    ),

    Column(

      children: [

        Icon(
          Icons.calendar_month,
          color: Colors.orange,
        ),

        SizedBox(height: 5),

        Text("3 Jul 2026"),

      ],

    ),

    Column(

      children: [

        Icon(
          Icons.access_time,
          color: Colors.orange,
        ),

        SizedBox(height: 5),

        Text("19:00"),

      ],

    ),

  ],

),

const SizedBox(height: 25),

const Text(
  "Cast",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 15),

Wrap(
  spacing: 10,
  runSpacing: 10,
  children: const [

    Chip(label: Text("Timothée Chalamet")),

    Chip(label: Text("Zendaya")),

    Chip(label: Text("Rebecca Ferguson")),

    Chip(label: Text("Austin Butler")),

  ],
),

const SizedBox(height: 30),

OutlinedButton.icon(
  onPressed: () async {
    final Uri url = Uri.parse(
      "https://www.youtube.com/results?search_query=${movie.title}+Official+Trailer",
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  },
  icon: const Icon(Icons.play_circle),
  label: const Text("Watch Trailer"),
),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.event_seat),
                    label: const Text(
                      "Book Ticket",
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CinemaScreen(),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class CinemaScreen extends StatelessWidget {
  const CinemaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cinemas = [
      "CGV Grand Indonesia",
      "XXI Plaza Indonesia",
      "Cinépolis Senayan",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Cinema"),
      ),
      body: ListView.builder(
        itemCount: cinemas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const Icon(Icons.movie),
              title: Text(cinemas[index]),
              subtitle: const Text("Jakarta"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScheduleScreen(
                      cinema: cinemas[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  final String cinema;

  const ScheduleScreen({
    super.key,
    required this.cinema,
  });

  @override
  Widget build(BuildContext context) {
    final schedule = [
      "10:00",
      "13:00",
      "16:00",
      "19:00",
      "21:30",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(cinema),
      ),
      body: ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(schedule[index]),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SeatBookingScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SeatBookingScreen extends StatefulWidget {
  const SeatBookingScreen({super.key});

  @override
  State<SeatBookingScreen> createState() =>
      _SeatBookingScreenState();
}

class _SeatBookingScreenState
    extends State<SeatBookingScreen> {

  final selectedSeats = <int>{};

final occupiedSeats = <int>{
  1,
  5,
  10,
  14,
  18,
  23,
  28,
  34,
};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Seat"),
      ),
      body: Column(
        children: [

          const SizedBox(height: 20),

          const Icon(
            Icons.crop_16_9,
            size: 120,
            color: Colors.orange,
          ),

          const Text("SCREEN"),
          const SizedBox(height: 15),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Icon(Icons.square, color: Colors.grey, size: 16),
    SizedBox(width: 5),
    Text("Available"),

    SizedBox(width: 20),

    Icon(Icons.square, color: Colors.orange, size: 16),
    SizedBox(width: 5),
    Text("Selected"),

    SizedBox(width: 20),

    Icon(Icons.square, color: Colors.red, size: 16),
    SizedBox(width: 5),
    Text("Occupied"),

  ],
),

const SizedBox(height: 15),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 48,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (_, index) {

                final selected =
                    selectedSeats.contains(index);

                final occupied =
                    occupiedSeats.contains(index);

                return GestureDetector(

  onTap: () {

  if (occupied) return;

  setState(() {

    if (selected) {
      selectedSeats.remove(index);
    } else {
      selectedSeats.add(index);
    }

  });

},

  child: Container(
    decoration: BoxDecoration(
      color: occupied
    ? Colors.red
    : selected
        ? Colors.orange
        : Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8),
    ),

    child: Center(
      child: Text(
        "${String.fromCharCode(65 + (index ~/ 8))}${index % 8 + 1}",
        style: TextStyle(
          color: selected ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

  ),
);
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: FilledButton(
  onPressed: selectedSeats.isEmpty
      ? null
      : () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentScreen(
                totalSeat: selectedSeats.length,
                totalPrice: selectedSeats.length * 50000,
              ),
            ),
          );
        },
  child: Text(
    "Continue (${selectedSeats.length} Seat)",
  ),
),
          ),

        ],
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final int totalSeat;
  final int totalPrice;

  const PaymentScreen({
    super.key,
    required this.totalSeat,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 20),
            const Text(
              "Payment Summary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text("Total Seats: $totalSeat"),
            const SizedBox(height: 10),
            Text("Total Price: Rp${totalPrice.toStringAsFixed(0)}"),
            const SizedBox(height: 30),

const Text(
  "Payment Method",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 20),

Card(
  child: ListTile(
    leading: const Icon(Icons.qr_code),
    title: const Text("QRIS"),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QueueScreen(
            payment: "QRIS",
            totalSeat: totalSeat,
          ),
        ),
      );
    },
  ),
),

Card(
  child: ListTile(
    leading: const Icon(Icons.account_balance_wallet),
    title: const Text("GoPay"),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QueueScreen(
            payment: "GoPay",
            totalSeat: totalSeat,
          ),
        ),
      );
    },
  ),
),

Card(
  child: ListTile(
    leading: const Icon(Icons.wallet),
    title: const Text("OVO"),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QueueScreen(
            payment: "OVO",
            totalSeat: totalSeat,
          ),
        ),
      );
    },
  ),
),

Card(
  child: ListTile(
    leading: const Icon(Icons.account_balance_wallet),
    title: const Text("DANA"),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QueueScreen(
            payment: "DANA",
            totalSeat: totalSeat,
          ),
        ),
      );
    },
  ),
),

Card(
  child: ListTile(
    leading: const Icon(Icons.credit_card),
    title: const Text("Credit Card"),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QueueScreen(
            payment: "Credit Card",
            totalSeat: totalSeat,
          ),
        ),
      );
    },
  ),
),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController controller = TextEditingController();

  List<Movie> searchResult = List.from(movies);

  @override
  void initState() {
    super.initState();

    controller.addListener(() {

      final keyword = controller.text.toLowerCase();

      setState(() {

        searchResult = movies.where((movie) {

          return movie.title.toLowerCase().contains(keyword) ||
              movie.genre.toLowerCase().contains(keyword);

        }).toList();

      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Search"),
      ),

      body: Column(

        children: [

          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Search Movie...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          Expanded(

            child: ListView.builder(

              itemCount: searchResult.length,

              itemBuilder: (_, index) {

                final movie = searchResult[index];

                return ListTile(

                  leading: ClipRRect(

                    borderRadius: BorderRadius.circular(8),

                    child: Image.network(
                      movie.poster,
                      width: 55,
                      fit: BoxFit.cover,
                    ),

                  ),

                  title: Text(movie.title),

                  subtitle: Text(movie.genre),

                  trailing: Row(

                    mainAxisSize: MainAxisSize.min,

                    children: [

                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),

                      const SizedBox(width: 5),

                      Text(movie.rating.toString())

                    ],

                  ),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) => DetailScreen(movie: movie),

                      ),

                    );

                  },

                );

              },

            ),

          )

        ],

      ),

    );

  }

}

class FavoriteScreen extends StatelessWidget {

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),

      body: favoriteMovies.isEmpty
    ? const Center(
        child: Text(
          "No Favorite Movie Yet ❤️",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      )
    : ListView.builder(

        padding: const EdgeInsets.all(20),

        itemCount: favoriteMovies.length,

        itemBuilder: (_, index) {

          final movie = favoriteMovies[index];

          return Card(

            margin: const EdgeInsets.only(bottom: 15),

            child: ListTile(

              leading: Image.network(

                movie.poster,

                width: 55,

                fit: BoxFit.cover,

              ),

              title: Text(movie.title),

              subtitle: Text(movie.genre),

              trailing: const Icon(

                Icons.favorite,

                color: Colors.red,

              ),

            ),

          );

        },

      ),

    );

  }

}

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: ListView(

        padding: const EdgeInsets.all(20),

        children: [

          const SizedBox(height: 30),

          const CircleAvatar(

            radius: 60,

            backgroundColor: Colors.orange,

            child: Icon(

              Icons.person,

              size: 60,

              color: Colors.white,

            ),

          ),

          const SizedBox(height: 20),

          const Center(

            child: Text(

              "Arjuna",

              style: TextStyle(

                fontSize: 26,

                fontWeight: FontWeight.bold,

              ),

            ),

          ),

          const SizedBox(height: 8),

          const Center(

            child: Text(

              "arjuna@email.com",

              style: TextStyle(

                color: Colors.grey,

              ),

            ),

          ),

          const SizedBox(height: 40),

          ListTile(

            leading: const Icon(Icons.history),

            title: const Text("Booking History"),

            trailing: const Icon(Icons.chevron_right),

            onTap: () {},

          ),

          ListTile(

            leading: const Icon(Icons.settings),

            title: const Text("Settings"),

            trailing: const Icon(Icons.chevron_right),

            onTap: () {},

          ),

          ListTile(

            leading: const Icon(Icons.logout),

            title: const Text("Logout"),

            trailing: const Icon(Icons.chevron_right),

            onTap: () {},

          ),

        ],

      ),

    );

  }

}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking History"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("Dune Part Two"),
            subtitle: Text("CGV • Seat A3"),
            trailing: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class QueueScreen extends StatefulWidget {
  final String payment;
  final int totalSeat;

  const QueueScreen({
    super.key,
    required this.payment,
    required this.totalSeat,
  });

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class TicketScreen extends StatelessWidget {
  final String payment;
  final int totalSeat;

  const TicketScreen({
    super.key,
    required this.payment,
    required this.totalSeat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Ticket"),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.confirmation_number,
                  size: 80,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Booking Success",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Movie Ticket"),
                const SizedBox(height: 20),
                Container(
                  width: 180,
                  height: 180,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: QrImageView(
  data: "TX-2026-001",
  size: 160,
  backgroundColor: Colors.white,
),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Booking ID : TX-2026-001",
                ),
                const SizedBox(height: 25),
                FilledButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text("Back Home"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QueueScreenState extends State<QueueScreen> {

  @override
void initState() {
  super.initState();

  Future.delayed(
    const Duration(seconds: 3),
    () {

      hasTicket = true;

myTickets.add("TX-2026-001");
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TicketScreen(
  payment: widget.payment,
  totalSeat: widget.totalSeat,
),
        ),
      );
    },
  );
}
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queue"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 20),
            const Text(
              "Your queue is being processed",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text("Payment Method: ${widget.payment}"),
            const SizedBox(height: 10),
            Text("Total Seats: ${widget.totalSeat}"),
          ],
        ),
      ),
    );
  }
}

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Movies"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("Dune Part Two"),
            subtitle: Text("Sci-Fi"),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("Godzilla x Kong"),
            subtitle: Text("Action"),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("Inside Out 2"),
            subtitle: Text("Animation"),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("Kung Fu Panda 4"),
            subtitle: Text("Comedy"),
          ),
        ],
      ),
    );
  }
}

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({super.key});

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tickets"),
      ),
      body: (myTickets.isNotEmpty)
          ? ListView(
              children: myTickets.map((ticket) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_number),
                    title: const Text("Movie Ticket"),
                    subtitle: Text("Booking ID : $ticket"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketScreen(
                            payment: "GoPay",
                            totalSeat: 1,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            )
          : const Center(
              child: Text(
                "You don't have any ticket yet 🎟️",
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}

