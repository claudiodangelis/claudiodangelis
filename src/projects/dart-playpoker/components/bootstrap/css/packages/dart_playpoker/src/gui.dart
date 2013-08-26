part of playpoker;

class Gui{
  //TODO: group `query() statements`
  static Map<String,bool> toggled = {
    "h1" : false,
    "h2" : false,
    "h3" : false,
    "h4" : false,
    "h5" : false
    };

  static void init(Game game) {
    // Initialization of poker engine
    game.init();

    //TODO: clear
    toggled["h1"]=false;
    toggled["h2"]=false;
    toggled["h3"]=false;
    toggled["h4"]=false;
    toggled["h5"]=false;

    unhideShowdownButton();

    // Laying covered cards
    List<String> slots = ['c1','c2','c3','c4','c5','h1','h2','h3','h4','h5'];
    for (var slot in slots){
      query('#$slot').style
      ..backgroundImage='url(img/deck.png)'
      ..width='71px'
      ..height='96px';
    }
    resetCardPosition();
  }

  static void showCards(Game game, {bool showdown:false}) {
    //TODO: group these loops
    for(var i=0; i<5;i++){
      query('#h${i+1}').style
      ..backgroundImage='url(${game.human.hand[i].cardImage()})'
      ..width='71px'
      ..height='96px';
      }

    if(showdown){
      for(var i=0; i<5;i++){
        query('#c${i+1}').style
        ..backgroundImage='url(${game.computer.hand[i].cardImage()})'
        ..width='71px'
        ..height='96px';
        }
    }
  }

  static void toggleAndSelect(Game game, int slot){
    // Note to self: Card index == $slot - 1
    //TODO: simplify logic
    //TODO: remove 4-cards-limit warning if useless
    int margin;
    if(Gui.toggled["h$slot"]) {
      // Already selected
      Gui.toggled["h$slot"]=!Gui.toggled["h$slot"];
      game.human.changing.remove(game.human.hand[slot-1]);
      margin=0;
    } else {
      // Being selected
      if(game.human.changing.length!=4) {
        game.human.changing.add(game.human.hand[slot-1]);
        Gui.toggled["h$slot"]=!Gui.toggled["h$slot"];
        margin=25;
      } else {
        margin=0;
        Gui.updateStatusBar("You can change only 4 cards.");
      }
    }

    // Manage "Change cards" button
    if(Gui.toggled.values.contains(true)) {
      //GOTO state 2
      query("#showdown")
      ..classes = ["btn","btn-success"]
      ..text = "Change cards and jump to Showdown";
    } else {
      //GOTO state 3
      query("#showdown")
      ..classes = ["btn","btn-info"]
      ..text = "Showdown";
    }

    query("#h$slot").style.marginTop="-${margin}px";
  }

  static String generateVerboseVerdict(Map results) {
    String tmp;
    if(results["humanWinner"]){
      tmp="you won ";
    } else {
      tmp="computer won ";
    }

    tmp=tmp+"because "+results["reason"];
    return tmp;
  }

  static void updateStatusBar(String msg){
    //TODO: add a level of message (warning, success, alert, info, etc)
    query('#status').innerHtml=msg;
  }

  static void resetCardPosition() {

    query('#h1').style.marginTop='0px';
    query('#h2').style.marginTop='0px';
    query('#h3').style.marginTop='0px';
    query('#h4').style.marginTop='0px';
    query('#h5').style.marginTop='0px';

  }

  static void hideShowdownButton() {
    query("#showdown").style
    ..visibility='hidden'
    ..display='none';
  }

  static void unhideShowdownButton() {
    query("#showdown")
    ..text="Showdown"
    ..classes=["btn","btn-info"]
    ..style.visibility='visible'
    ..style.display='inline';
  }
}