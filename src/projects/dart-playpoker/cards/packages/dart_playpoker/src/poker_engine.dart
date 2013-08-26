part of playpoker;

class Game {

  int state;
  Player human;
  Player computer;
  List<Card> servedCards=[];

  Player createHuman() {
    Player h = new Player();
    h.changing=[];
    h.hand=[];
    h.human=true;
    return h;
  }

  Player createComputer() {
    Player c = createHuman();
    c.human=false;
    return c;
  }

  void init() {
    state = 0;
    servedCards=[];
    human.hand=[];
    computer.hand=[];
    human.changing=[];
    computer.changing=[];
  }

  void serveHand(Player player){
    while(player.hand.length < 5){
        Card inCard = pickCard();
        if (beenServed(inCard) == false){
          servedCards.add(inCard);
          player.hand.add(inCard);
        }
      }
   }

  Card pickCard(){
    int  randomSuite, randomRank;
    var rnd = new Random();
    randomSuite = rnd.nextInt(4);
    randomRank = 2 + rnd.nextInt(13);

    Card giveCard = new Card(randomSuite,randomRank);
    return giveCard;
  }

  bool beenServed(Card toAdd){
    for (var card in servedCards){
      if(card.nameOfCard() == toAdd.nameOfCard()){
        return true;
      }
    }
    return false;
  }

  // Evaluation!
  // TODO: 1) async 2) do things faster by avoiding temporary mapping (not sure)
  String evaluateHand(Player player){
    Map<int,int> cardsMultiplicities = new Map();
    for(var card in player.hand){
      if(cardsMultiplicities[card.r]==null){
        cardsMultiplicities[card.r]=1;
      }
      else{
        cardsMultiplicities[card.r]++;
      }
    }

    int encMultiplicity=0;

    for (var multiplicity in cardsMultiplicities.values){
      encMultiplicity+=pow(multiplicity,2);
    }

    player.encHand = encMultiplicity;

    switch(encMultiplicity){
      case 5:
        allOnes(player);
        break;
      case 7:
        player.handValue='Pair';
        break;
      case 11:
        player.handValue='Three Of A Kind';
        break;
      case 9:
        player.handValue='Two Pairs';
        break;
      case 13:
        player.handValue='Fullhouse';
        break;
      case 17:
        player.handValue='Four Of A Kind';
        break;
    }
    return player.handValue;
  }

  void allOnes(Player player){
    List R = [player.hand[0].r,player.hand[1].r,player.hand[2].r,player.hand[3].r,player.hand[4].r];
    R.sort();

    if(R[4]==R[0]+4){
      if(this.isFlush(player)){
        player.handValue='Straight Flush';
        player.encHand=18;
      }
      else{
        player.handValue='Straight';
        player.encHand=12;
      }
    }
    else if (R[4]==14 && R[0]==2 && R[3]==5){
      if(this.isFlush(player)){
        player.handValue='Straight Flush';
        player.encHand=18;
      }
      else{
        player.handValue='Straight';
        player.encHand=12;
      }
    }
    else {
      if (this.isFlush(player)){
        player.handValue='Flush';
        player.encHand=14;
      }
      else{
        player.handValue='High Card';
        player.encHand=1;
      }
    }
  }


  bool isFlush(Player player){
    List allSuites = [player.hand[0].s,player.hand[1].s,player.hand[2].s,player.hand[3].s,player.hand[4].s];
    for(var i=0;i<allSuites.length-1;i++){
      if(allSuites[i]!=allSuites[i+1]){
        return false;
      }
    }
    return true;
  }


  // Comparison methods
  Map compareHands() {
    if(human.encHand>computer.encHand) {
      return {"humanWinner":true,"reason":"you have a higher hand."};
    } else if(human.encHand==computer.encHand) {
      //TODO: same hand comparison
      switch(human.encHand) {
        case 1:
          return compareHighCard();
        case 7:
          return comparePair();
        case 9:
          return compareTwoPairs();
        case 11:
          return compareThreeOfAKind();

        //TODO: Fullhouse
        //TODO: Four Of A Kind
        //TODO: Straights

      }
    }
    return {"humanWinner":false,"reason":"you have a lower hand."};
  }

  // Same hand comparison
  Map compareHighCard() {

    // Dummy cards to please max detecting
    Card humanMax = new Card(0,0);
    Card computerMax = new Card(0,0);

    for(var card in human.hand){
      if(card>humanMax){
        humanMax = card;
      }
    }

    for (var card in computer.hand){
      if(card>computerMax){
        computerMax = card;
      }
    }

    if(humanMax>computerMax){
      return {"humanWinner":true,"reason":"you have a higher High Card"};
    }
    else{
      return {"humanWinner":false,"reason":"you have a lower High Card"};
    }
  }

  Map comparePair() {
    Map playerPair= new Map();
    for (var card in human.hand){
      if(playerPair[card.r]==null){
        playerPair[card.r]=[card];
      }
      else{
        playerPair[card.r].add(card);
      }
    }

    Map computerPair= new Map();
    for (var card in computer.hand){
      if(computerPair[card.r]==null){
        computerPair[card.r]=[card];
      } else {
        computerPair[card.r].add(card);
      }
    }

    int playerPairRank;
    List playerPairValue = [];
    playerPair.forEach((k,v){
      if(v.length==2){
        playerPairRank=k;
        playerPairValue=v;
      }
    });

    int computerPairRank;
    List computerPairValue = [];
    computerPair.forEach((k,v){
      if(v.length==2){
        computerPairRank=k;
        computerPairValue=v;
      }
    });


    if(playerPairRank>computerPairRank){
      return {"humanWinner":true,"reason":"you have a higher Pair."};
    }
    else if(playerPairRank<computerPairRank){
      return {"humanWinner":false,"reason":"you have a lower Pair."};
    }
    else{
      bool hasSpades = false;
      for (var searchSpades in playerPairValue){
        if(searchSpades.s==3) hasSpades = true;
      }
      if(hasSpades) {
        return {"humanWinner":true,"reason":"you have the card of Spades."};
      }
      return {"humanWinner":false,"reason":"computer has the card of Spades."};
    }
  }

  Map compareTwoPairs() {
    bool hasSpades = false;
    Map humanMap = {};
    Map computerMap = {};
    List<int> humanTwoPairs = [];
    List<int> computerTwoPairs = [];

    //TODO: group these loops
    for(var card in human.hand) {
      if(humanMap[card.r.toString()]==null) humanMap[card.r.toString()]=1;
      else humanMap[card.r.toString()]++;
    }

    for(var card in computer.hand) {
      if(computerMap[card.r.toString()]==null) computerMap[card.r.toString()]=1;
      else computerMap[card.r.toString()]++;
    }

    humanMap.forEach((k,v){
      if(v==2){
        humanTwoPairs.add(k);
      }
    });

    computerMap.forEach((k,v){
      if(v==2){
        computerTwoPairs.add(k);
      }
    });

    humanTwoPairs.sort();
    computerTwoPairs.sort();

   //TODO: clear
   int humanMin = int.parse(humanTwoPairs[0].toString());
   int computerMin = int.parse(computerTwoPairs[0].toString());
   int humanMax = int.parse(humanTwoPairs[1].toString());
   int computerMax = int.parse(computerTwoPairs[1].toString());

   //TODO: simplify logic
   if(humanMax > computerMax) {
      return {"humanWinner":true, "reason":"you have a higher Two Pairs."};
    } else if(humanMax < computerMax) {
      return {"humanWinner":false, "reason":"you have a lower Two Pairs."};
    } else {
      // same max, check if same min, if not, higher min wins, else look for Spades
      if(humanMin>computerMin){
        return {"humanWinner":true, "reason":"you have a higher Two Pairs."};
      } else if (humanMin<computerMin) {
        return {"humanWinner":false, "reason":"you have a lower Two Pairs."};
      } else {
        // look for Spades
        for(var card in human.hand) {
          if(card.r==humanMax){
            if(card.s==3){
              hasSpades = true;
            }
          }
        }

        if(!hasSpades){
          for(var card in human.hand){
            if(card.r==humanMin){
              if(card.s==3){
                hasSpades = true;
              }
            }
          }
        }

        if(hasSpades){
          return {"humanWinner":true, "reason":"you have the card of Spades."};
        }
        return {"humanWinner":false, "reason":"computer has the card of Spades."};
      }
    }
  }

  Map compareThreeOfAKind() {
    Map humanMap = {};
    Map computerMap = {};
    int humanThreeOfAKindValue;
    int computerThreeOfAKindValue;

    //TODO: group these loops
    for(var card in human.hand) {
      if(humanMap[card.r.toString()]==null) humanMap[card.r.toString()]=1;
      else humanMap[card.r.toString()]++;
    }

    for(var card in computer.hand) {
      if(computerMap[card.r.toString()]==null) computerMap[card.r.toString()]=1;
      else computerMap[card.r.toString()]++;
    }

    humanMap.forEach((k,v){
      if(v==3) humanThreeOfAKindValue = int.parse(k);
    });

    computerMap.forEach((k,v){
      if(v==3) computerThreeOfAKindValue = int.parse(k);
    });

    if(humanThreeOfAKindValue>computerThreeOfAKindValue) {
      return {"humanWinner":true, "reason":"you have a higher Three Of A Kind."};
    }
    return {"humanWinner":false, "reason":"you have a lower Three Of A Kind."};

  }
  // State switchers
  void state0() {
    Gui.init(this);
    state=0;
    state1();
  }

  void state1() {
    state=1;
    serveHand(human);
    serveHand(computer);
    Gui.showCards(this);
    evaluateHand(human);
    evaluateHand(computer);
    Gui.updateStatusBar('You have a <b>${human.handValue}</b>. You can now change up to 4 cards or jump to showdown');
  }

  void state2() {
    // You are changin your cards
    state=2;
    // remove cards
    for ( Card card in human.changing ) {
      human.hand.remove(card);
    }

    // fill the hand with new cards
    serveHand(human);
    evaluateHand(human);
    state3();
  }

  void state3() {
    // Showdown
    state=3;
    Gui.showCards(this, showdown:true);
    Gui.resetCardPosition();
    Gui.hideShowdownButton();
    Gui.updateStatusBar('You have a <b>${human.handValue}</b>,'
      ' computer has a <b>${computer.handValue}</b>: '
      '${Gui.generateVerboseVerdict(this.compareHands())}');
  }
}

class Card {
  // s = suite
  // r = rank
  int r,s;

  var suiteNames = ['Clubs','Diamonds','Hearts','Spades'];
  var rankNames = ['None','None', '2', '3', '4', '5', '6', '7','8', '9', '10', 'Jack', 'Queen', 'King','Ace'];

  Card(this.s,this.r) { }

  String nameOfCard(){
    return '${rankNames[this.r]} of ${suiteNames[this.s]}';
  }

  String toString() => this.nameOfCard();

  String cardImage() => 'cards/${suiteNames[this.s][0].toLowerCase()}${this.r}.png';

  operator >(Card other) {
    if ( this.r > other.r){
    return true;
  }
  else if (this.r == other.r){
    if ( this.s > other.s){
      return true;
      }
    }
  return false;
  }

  operator <(Card other) {
    if ( this.r < other.r){
    return true;
  }
  else if (this.r == other.r){
    if ( this.s < other.s){
      return true;
      }
    }
  return false;
  }

  operator ==(Card other) {
    if (this.r == other.r && this.s == other.s) return true;
    return false;
  }

}

class Player{
  // String name;
  bool human;
  List<Card> hand = [];
  List<Card> changing = [];
  String handValue;
  int encHand;
  //TODO: Map
}