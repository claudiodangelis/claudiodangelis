import 'package:dart_playpoker/playpoker.dart';
import 'dart:html';

main() {

  Game game = new Game();
  game.human = game.createHuman();
  game.computer = game.createComputer();

  for ( int i = 1; i<6; i++ ) {
    query('#h${i}').onClick.listen((_){
      // One can toggle cards only if state is 1 (Reading cards)
      if(game.state==1) Gui.toggleAndSelect(game,i);
    });
  }

  // Game starts here
  game.state0();


  query("#newHand").onClick.listen((_){
    game.state0();
  });

  query("#showdown").onClick.listen((_){
    if(Gui.toggled.values.contains(true)) {
      game.state2();
    } else {
      game.state3();
    }
  });

}
