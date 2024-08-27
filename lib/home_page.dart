import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pookieview/constant/colors.dart';
import 'package:pookieview/ui/movie/movie_home.dart';
import 'package:pookieview/ui/tv/tv_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  Widget getView() {
    if (selectedIndex == 0) {
      return const MovieHome();
    } else {
      return const TvHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pookie View',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        centerTitle: true,
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.deepOrangeAccent,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie,
              color: primaryColor,
            ),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
              color: primaryColor,
            ),
            label: 'TV',
          ),
        ],
      ),
    );
  }
}
