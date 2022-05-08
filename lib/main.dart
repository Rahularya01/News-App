import 'package:flutter/material.dart';
import 'package:news_app/api/get_news.dart';
import 'package:news_app/modals/news.dart';
import 'package:news_app/webpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String country = 'in';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text(
                    "News App by \n \nSarabjit Kaur \nGunika \nAmandeep \nNidhi"),
              ),
              ListTile(
                title: const Text("India"),
                onTap: () {
                  setState(() {
                    country = 'in';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Australia'),
                onTap: () {
                  setState(() {
                    country = 'au';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Hong Kong'),
                onTap: () {
                  setState(() {
                    country = 'hk';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('USA'),
                onTap: () {
                  setState(() {
                    country = 'us';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Canada'),
                onTap: () {
                  setState(() {
                    country = 'ca';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
          title: const Text(
            "News App",
            style: TextStyle(
              color: Color(0xFF222222),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: FutureBuilder<List<News>>(
          future: GetNews.getNews(country),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went Wrong"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebPage(
                            snapshot.data![index].url.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data![index].imageUrl),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          colorFilter: const ColorFilter.mode(
                            Colors.black54,
                            BlendMode.darken,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          snapshot.data![index].headline,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        // bottomNavigationBar: BottomNavigationBar(),
      ),
    );
  }
}
