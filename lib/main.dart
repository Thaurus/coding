

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );

  }
}

class HomeScreen extends StatelessWidget {
  final int amountOfCategories = 3; // Change this to the desired number of categories

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(amountOfCategories, (index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the new screen and pass the index as a parameter
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(index+1),
                  ),
                );
              },
              child: Text('Kategorie  ${index + 1}'),
            )
            );
          }),
        ),
      ),
    );
  }
}
class FinishScreen extends StatelessWidget {
  final int index;
  FinishScreen (this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
              children: [
                Text(
                  'Du hast Kategorie $index geschafft! Zeig das deiner Lehrkraft :)',
                  style: TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: Image.asset(
                      "assets/images/done.png",
                      fit: BoxFit.contain),
                    
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the new screen and pass the index as a parameter
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text('Zurück zur Auswahl'),
                )
              ]
          )
        )

      ),
    );
  }
}
class QuizScreen extends StatefulWidget {
  final int index;

  QuizScreen(this.index);

  @override
  _QuizScreenState createState() => _QuizScreenState(index);
}

class _QuizScreenState extends State<QuizScreen> {
  final int index;
  _QuizScreenState (this.index);

  final TextEditingController _textController = TextEditingController();
  final List<TextEditingController> _controllers =
      List.generate(10, (index) => TextEditingController());


  var picturesTexts;

  int currentImageIndex = 0;

  bool didNoMistake = true;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    picturesTexts = getCategory(index);
  }

  void updateImage() {
    if (didNoMistake){
      setState(() {
      picturesTexts.removeAt(currentImageIndex);
      if (picturesTexts.length <= 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishScreen(index),
          ),
        );
      }
      currentImageIndex = (currentImageIndex % picturesTexts.length).toInt();
      });
    }
    else {
      setState(() {
      currentImageIndex = ((currentImageIndex + 1) % picturesTexts.length).toInt();
      });
    }

    didNoMistake = true;

  }
  List<String> getCategory(int category) {
    switch (category) {
      case 1:
        return [
          "assets/images/simple/affe.png",
          "assets/images/simple/hund.png",
          "assets/images/simple/lila.png",
          "assets/images/simple/oma.png",
          "assets/images/simple/haus.png",
          "assets/images/simple/buch.png",
          "assets/images/simple/baum.png",
          "assets/images/simple/hand.png",
          "assets/images/simple/ei.png",
          "assets/images/simple/hase.png",
          "assets/images/simple/maus.png",
          "assets/images/simple/auto.png",
          "assets/images/simple/ball.png",
          "assets/images/simple/apfel.png"
        ];
      case 2:
        return [
          "assets/images/medium/fisch.png",
          "assets/images/medium/katze.png",
          "assets/images/medium/vogel.png",
          "assets/images/medium/tasse.png",
          "assets/images/medium/flasche.png",
          "assets/images/medium/stuhl.png",
          "assets/images/medium/schuh.png",
          "assets/images/medium/blume.png",
          "assets/images/medium/keks.png",
          "assets/images/medium/wurm.png",
          "assets/images/medium/stern.png",
          "assets/images/medium/stein.png",
          "assets/images/medium/brot.png"
        ];
      case 3:
        return [
          "assets/images/hard/fuchs.png",
          "assets/images/hard/panda.png",
          "assets/images/hard/kerze.png",
          "assets/images/hard/kamera.png",
          "assets/images/hard/schiff.png",
          "assets/images/hard/lampe.png",
          "assets/images/hard/schwamm.png",
          "assets/images/hard/gitarre.png",
          "assets/images/hard/kuchen.png",
          "assets/images/hard/trampolin.png",
          "assets/images/hard/fahrrad.png",
          "assets/images/hard/ballon.png",
          "assets/images/hard/hamster.png"
        ];
      default:
        return [];
    }

  }

  String joinTexts(List<TextEditingController> controllers) {
    String text = "";
    for (TextEditingController controller in controllers) {
      text += controller.text;
    }
    return text;
  }

  void clearText(List<TextEditingController> controllers) {
    for (TextEditingController controller in controllers) {
      controller.clear();
    }
  }
  String getWordFromImagePath(String path) {
    return path.split('/').last.split('.').first;
  }

  Future<void> _sleep() async {
    await Future.delayed(Duration(seconds: 4));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Oberhalb: Bild
              Expanded(
                child: Image.asset(
                    picturesTexts[currentImageIndex],
                    fit: BoxFit.contain),
              ),
              // Unten: Text-Input
              Expanded(
                  //height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: getWordFromImagePath(picturesTexts[currentImageIndex])
                          .length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 50, // Adjust the width of each cell as needed
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _controllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _controllers[index].text = value.toUpperCase();
                              String text = joinTexts(_controllers);
                              if (getWordFromImagePath(picturesTexts[currentImageIndex])
                                      .substring(
                                          0, text.toLowerCase().length) !=
                                  text.toLowerCase()) {
                                //ist das der richtige Buchstabe?
                                _controllers[index].text = "";
                                didNoMistake = false;
                              }

                              if (text.toLowerCase() ==
                                  getWordFromImagePath(picturesTexts
                                  [currentImageIndex])) {
                                //Bild richtig erraten
                                Timer(Duration(seconds: 4) , () {
                                  clearText(_controllers);
                                  updateImage();
                                  FocusScope.of(context).nextFocus();
                                });
                              }
                              if (value.isNotEmpty) {
                                if (_controllers[index].text.isNotEmpty) {
                                  // Move to the next cell
                                  FocusScope.of(context).nextFocus();
                                }
                              }
                            },
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
