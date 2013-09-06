$(window).load(function() {
    
    var imgs = document.getElementsByTagName("img");
    for (var i = 0; i < imgs.length; i++) {
        if (imgs[i].id != "avatar") {
            imgs[i].className += " img-responsive";
        }
    }

    $(document).keyup(function(e) {
        var url;
        switch(e.keyCode) {
            case 66:
                // B
                url = '/';
                break;
            case 80:
                // P
                url = '/projects/';
                break;
            case 65:
                // A
                url = '/about/';
                break;
            case 70:
                // F
                url = '/archive.html';
                break;
            case 222:
                // ?
                $('#shortcuts').modal();
                break;                
        }
        if ( typeof url != 'undefined' && document.location.pathname.toString() != url ) {
            location.href = url;
        }
    });
})