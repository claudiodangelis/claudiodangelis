import 'dart:html';
import 'package:diffbot/diffbot_browser.dart';

void main() {
  ParagraphElement title = query('#title');
  DivElement items = query('#items');
  
  // Creates a new Diffbot client with a given auth token
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  
  client.getFrontpage("http://news.ycombinator.com").then((Frontpage fp) {
    title.text = fp.title;
    fp.items.forEach((FpItem item) {
      document.body.append(
        new ParagraphElement()
          ..append(
            new AnchorElement()
              ..text = item.title
              ..href = item.link
          )
      );
    });
  });
  
}