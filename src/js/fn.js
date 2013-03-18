function init(){
	var preTags = $('pre').get();
	console.log(preTags);
	for (var x = 0; x<preTags.length; x++){
		$(preTags[x]).addClass('prettyprint');
	}
}

function loadShareButtons(){

	//	G+
  window.___gcfg = {lang: 'en'};
  (function(){
  	var po = document.createElement("script");
  	po.type = "text/javascript"; po.async = true;
  	po.src = "https://apis.google.com/js/plusone.js";
  	var s = document.getElementsByTagName("script")[0];
  	s.parentNode.insertBefore(po, s);
  })();

	//	Twitter
	!function(d,s,id){
		var js,fjs=d.getElementsByTagName(s)[0];
		if(!d.getElementById(id)){
			js=d.createElement(s);
			js.id=id;
			js.src="//platform.twitter.com/widgets.js";
			fjs.parentNode.insertBefore(js,fjs);
		}}(document,"script","twitter-wjs");
	}