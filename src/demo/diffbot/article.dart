import 'dart:async';
import 'dart:html';
import 'package:diffbot/diffbot_browser.dart';

ParagraphElement title = query('#title');
ParagraphElement date = query('#date');
ParagraphElement author = query('#author');
ParagraphElement url = query('#url');
DivElement content  = query('#content');
InputElement input = query('#input');
ButtonElement btn = query('#btn');
ImageElement loading = query('#loading');

void main() {
  loading.src = 'ajax-loader.gif';
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  client.getArticle("http://techcrunch.com/2013/09/29/generation-touch-will-redraw-consumer-tech/",
  html:true)
  .then((Article article) {
    displayResults(article);
  }, onError:(ClientException e){
    content.text = e.toString();
  });

  btn.onClick.listen((e) {
    if(input.value != "") {
      loading.src = 'ajax-loader.gif';

      client.getArticle(input.value,html:true).then((Article article) {

        displayResults(article);
      }, onError:(ClientException e){
        content.text = e.toString();
      });
    }
  });
  

  AnchorElement try1 = query('#try1');
  try1.onClick.listen((e) {
    loading.src = 'ajax-loader.gif';
    client.getArticle(try1.text,html:true).then((Article article) {
      displayResults(article);
    });
  });
  
  AnchorElement try2 = query('#try2');
  try2.onClick.listen((e) {
    loading.src = 'ajax-loader.gif';
    client.getArticle(try2.text,html:true).then((Article article) {
      displayResults(article);
    });
  });
  
}

void displayResults(Article article) {
    final NodeValidatorBuilder _validator = new NodeValidatorBuilder.common()
    ..allowElement('a',attributes: ['href'])
    ..allowElement('img', attributes:['src']);

    loading.src='';
    title.text = article.title;
    author.text = article.author;
    date.text = article.date.toString();
    content.setInnerHtml(article.html, validator: _validator);
    url.text = article.url;
}