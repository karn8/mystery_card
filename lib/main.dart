import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mystery_cards/start_page.dart';
void main() {
  runApp(MyApp());
}

const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 19, 19, 19),
);

class TaskValues{
  String spadesTask = '';
  String clubsTask = '';
  String heartsTask = '';
  String diamondsTask = '';
}

const homeRoute = '/home/' ;
const startRoute = '/start/';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '52 Card Deck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home: const LandingPage(),
      routes: {
        homeRoute: (context) =>  CardsPage(),
        startRoute: (context) => const LandingPage(),},
        //home: CardsPage(title: 'MYSTERY CARD'),
    );
  }
}




class CardsPage extends StatefulWidget {
  CardsPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  List<Widget> myCards = [];
  List<Widget> myCardsFlip = [];

  Widget _myAnimatedWidget = Container();

  final PageController ctrl = PageController(viewportFraction: 0.85);
  int currentPage = 0;
  bool isFlip = false;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    if (myCards.isEmpty) {
      setState(() {
        CardSuit.values.forEach((suit) {
          CardType.values.forEach((type) {
            myCards.add(buildCard(suit, type));
            myCardsFlip.add(buildCardSide(suit, type));
          });
        });
      });
    }
    print('Total Cards ${myCards.length}');
    shuffle();
  }

  Widget _buildStoryPage(List list, int index, bool active, bool value) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 50 : 125;

    return AnimatedContainer(
      key: ValueKey(value),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: blur,
              offset: Offset(offset, offset))
        ],
      ),
      child: list[index],
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (const ValueKey(1) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: 4.rotationY(value)..setEntry(3, 0, tilt),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: Center(
          child: Wrap(
            spacing: 9.0,
            children: [
              const Icon(
                Icons.batch_prediction,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Text(widget.title!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          isFlip = !isFlip;
          //shuffle();
          setState(() {});
        },
        child: Center(
          child: AspectRatio(
            aspectRatio: 0.71428571428,
            child: PageView.builder(
              controller: ctrl,
              itemCount: myCards.length,
              itemBuilder: (context, int currentIdx) {
                bool active = currentIdx == currentPage;
                isFlip
                    ? _myAnimatedWidget =
                        _buildStoryPage(myCardsFlip, currentIdx, active, true)
                    : _myAnimatedWidget =
                        _buildStoryPage(myCards, currentIdx, active, false);
                return AnimatedSwitcher(
                    transitionBuilder: _transitionBuilder,
                    duration: const Duration(milliseconds: 500),
                    child: _myAnimatedWidget);
              },
            ),
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          tooltip: 'Shuffle',
          child: const Icon(Icons.shuffle),
          onPressed: () => {
            isFlip = !isFlip,
            shuffle(),
            ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Deck Shuffled! Double tap to flip a card"),
                  ))
            }),
          

      

      
    );
  }

  void shuffle() {
    setState(() {
      myCards.shuffle();
    });
  }

  Widget buildCard(suit, type) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(40.0),
            padding: const EdgeInsets.all(9.0),
            child: buildCardCenter(suit, type),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: buildCardCorner(suit, type)),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
                alignment: Alignment.bottomRight,
                child: RotatedBox(
                    quarterTurns: 2, child: buildCardCorner(suit, type))),
          )
        ],
      ),
    );
  }

  Widget buildCardSide(suit, type) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                      0.9
                    ],
                    colors: [
                      Color.fromARGB(255, 210, 13, 213),
                      Color.fromARGB(255, 42, 110, 219),
                      Colors.indigo,
                      Colors.teal
                    ])),
          )
        ],
      ),
    );
  }

  Widget buildContainer(CardSuit suit, int turns) {
    final size = 51.0;
    return RotatedBox(
      quarterTurns: turns,
      child: Container(
        child: Text(
          getSuite(suit),
          style: TextStyle(fontSize: size, color: getSuitColor(suit)),
        ),
      ),
    );
  }

  Widget buildCardCenter(CardSuit suit, CardType type) {
    switch (type) {
      case CardType.ace:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle,),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
        
          //child: buildContainer(suit, 0));
      case CardType.two:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.three:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.four:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.five:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.six:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.seven:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.eight:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.nine:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.ten:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.jack:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.queen:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
      case CardType.king:
        if(suit == CardSuit.spades ){
          return Center(
          child: Text(tasks.spadesTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.hearts){
          return Center(
          child: Text(tasks.heartsTask,style: kTitleTextStyle),);
        } else if (suit == CardSuit.diamonds){
          return Center(
          child: Text(tasks.diamondsTask,style: kTitleTextStyle),);
        } else {
          return Center(
          child: Text(tasks.clubsTask,style: kTitleTextStyle),);
        }
    }
  }

  Widget buildCardCorner(CardSuit suit, CardType type) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          getType(type),
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
            color: getSuitColor(suit),
          ),
        ),
        Container(
          child: Text(
            getSuite(suit),
            style: TextStyle(
                fontSize: suit == CardSuit.diamonds ? 21.0 : 18.0,
                color: getSuitColor(suit)),
          ),
        )
      ],
    );
  }

  Color? getSuitColor(CardSuit suit) {
    switch (suit) {
      case CardSuit.clubs:
        return Colors.black;
      case CardSuit.diamonds:
        return Colors.redAccent[700];
      case CardSuit.hearts:
        return Colors.redAccent[700];
      case CardSuit.spades:
        return Colors.black;
    }
  }

  String getSuite(CardSuit suit) {
    switch (suit) {
      case CardSuit.clubs:
        return '♣️';
      case CardSuit.diamonds:
        return '♦️';
      case CardSuit.hearts:
        return '♥';
      case CardSuit.spades:
        return '♠️';
    }
  }

  String getType(CardType type) {
    switch (type) {
      case CardType.ace:
        return 'A';
      case CardType.two:
        return '2';
      case CardType.three:
        return '3';
      case CardType.four:
        return '4';
      case CardType.five:
        return '5';
      case CardType.six:
        return '6';
      case CardType.seven:
        return '7';
      case CardType.eight:
        return '8';
      case CardType.nine:
        return '9';
      case CardType.ten:
        return '10';
      case CardType.jack:
        return 'J';
      case CardType.queen:
        return 'Q';
      case CardType.king:
        return 'K';
    }
  }
}

enum CardSuit { clubs, diamonds, hearts, spades }

enum CardType {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king
}


//new commit