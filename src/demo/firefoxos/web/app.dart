import 'dart:html';
import 'dart:js' as js;
import 'dart:async';

void main() {
  new Timer(new Duration(seconds: 20), (){
    var n = new js.JsObject(js.context['Notification'],
        ["Ciao",'{body:"Ciao Daniele, yeah funziona"}']);    
  });
}