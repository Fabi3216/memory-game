import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../widgets/memory_card.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardModel> cards = [];
  List<CardModel> flippedCards = [];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    List<String> images = [
      'assets/image1.png',
      'assets/image2.png',
      'assets/image3.png',
      // Add more image paths
    ];

    cards = images
        .map((image) => CardModel(id: images.indexOf(image), imagePath: image))
        .toList();
    cards.addAll(cards);
    cards.shuffle();
    setState(() {});
  }

  void _onCardTap(CardModel card) {
    setState(() {
      card.isFlipped = true;
      flippedCards.add(card);

      if (flippedCards.length == 2) {
        if (flippedCards[[1]].imagePath == flippedCards[[2]].imagePath) {
          flippedCards[[1]].isMatched = true;
          flippedCards[[2]].isMatched = true;
        } else {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              flippedCards[[1]].isFlipped = false;
              flippedCards[[2]].isFlipped = false;
            });
          });
        }
        flippedCards.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Spiel'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return MemoryCard(
            card: cards[index],
            onTap: cards[index].isMatched || cards[index].isFlipped
                ? () {}
                : () => _onCardTap(cards[index]),
          );
        },
      ),
    );
  }
}

