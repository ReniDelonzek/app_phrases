import 'package:app_phrases/domain/entities/phrase.dart';
import 'package:app_phrases/presentation/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Cantadas'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(children: const [
          UserAccountsDrawerHeader(
            accountName: Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: SizedBox(),
            currentAccountPicture: Icon(Icons.person),
            decoration: BoxDecoration(color: Colors.black),
          ),
        ]),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Phrase>>(
              future: controller.getData(),
              builder: (_, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return const Text('Falha ao carregar os dados');
                }
                return FlutterCarousel(
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    height: 400.0,
                    showIndicator: true,
                    slideIndicator: const CircularSlideIndicator(),
                  ),
                  items: snap.data!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      'text ${i.flirt}',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  )),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}
