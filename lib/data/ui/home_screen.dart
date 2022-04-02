import 'package:fluttertoast/fluttertoast.dart';
import 'package:heala_test/data/model/joke_model.dart';

import 'package:flutter/material.dart';

import '../services/joke_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loading = true;
    getRandomJokes();
  }

  JokeModel joke = JokeModel();
  late bool _loading;
  bool showPunchline = false;
  void getRandomJokes() async {
    var response = await JokeService.getJoke();
    _loading = false;
    if (response.item1 != null) {
      setState(() {
        joke = response.item1!;
      });
    } else {
      Fluttertoast.showToast(
          msg: response.item2!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Make ma laugh'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _loading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: (() {
                        setState(() => showPunchline = true);
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            showPunchline = false;
                            _loading = true;
                          });
                          getRandomJokes();
                        });
                      }),
                      child: Text(
                        '${joke.setup}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Visibility(
                visible: showPunchline,
                child: Text(
                  '${joke.punchline}',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
