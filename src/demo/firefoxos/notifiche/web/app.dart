import 'dart:js' as js;
import 'dart:async';

void main() {
  new Timer(new Duration(seconds: 10), () {
    new js.JsObject(js.context['Notification'], ["Ciao Daniele",
         new js.JsObject.jsify({"body":
           "This comes from Dart!"})]);
  });
}