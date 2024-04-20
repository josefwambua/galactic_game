// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(GalacticGovernanceApp());
}

class GalacticGovernanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galactic Governance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GalacticGovernancePage(),
    );
  }
}

class GalacticGovernancePage extends StatefulWidget {
  @override
  _GalacticGovernancePageState createState() => _GalacticGovernancePageState();
}

class _GalacticGovernancePageState extends State<GalacticGovernancePage> {
  int resources = 1000;
  int stability = 100;
  final player = AudioCache();

  void allocateResourcesToEconomy() {
    setState(() {
      resources += 100;
      stability -= 10;
    });
    checkGameState();
  }

  void allocateResourcesToMilitary() {
    setState(() {
      resources -= 150;
      stability -= 20;
    });
    checkGameState();
  }

  void allocateResourcesToDiplomacy() {
    setState(() {
      resources -= 50;
      stability += 30;
    });
    checkGameState();
  }

  void endTurn() {
    setState(() {
      resources -= 50;
      stability -= 5;
    });
    checkGameState();
  }

  void checkGameState() {
  if (resources <= 0) {
    playSound('lose.mp3'); // Play lose sound
    gameOver("Your empire has collapsed due to lack of resources.");
  } else if (stability <= 0) {
    playSound('lose.mp3'); // Play lose sound
    gameOver("Your empire has collapsed due to instability.");
  } else if (stability >= 200) {
    playSound('win.mp3'); // Play win sound
    winGame();
  }
}

  void playSound(String soundFileName) {
    player.play('assets/sounds/$soundFileName');
  }

  void gameOver(String message) {
    playSound('lose.mp3'); // Play lose sound
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Restart"),
              onPressed: () {
                setState(() {
                  resources = 1000;
                  stability = 100;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void winGame() {
    playSound('win.mp3'); // Play win sound
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You have achieved stability and won the game."),
          actions: <Widget>[
            TextButton(
              child: Text("Restart"),
              onPressed: () {
                setState(() {
                  resources = 1000;
                  stability = 100;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: SafeArea(
          child: AppBar(
            title: Text('Galactic Governance'),
            actions: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/josefwambua.jpg'),
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Resources: $resources'),
                    Text('Stability: $stability'),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Image.asset('assets/images/economy.jpg', width: 100, height: 100),
                          ElevatedButton(
                            onPressed: allocateResourcesToEconomy,
                            child: Text('Allocate to Economy'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Image.asset('assets/images/military.jpg', width: 100, height: 100),
                          ElevatedButton(
                            onPressed: allocateResourcesToMilitary,
                            child: Text('Allocate to Military'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Image.asset('assets/images/diplomacy.jpg', width: 100, height: 100),
                          ElevatedButton(
                            onPressed: allocateResourcesToDiplomacy,
                            child: Text('Allocate to Diplomacy'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: endTurn,
                      child: Text('End Turn'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Josef Wambua',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/josefwambua.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}