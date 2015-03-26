$(window).load(function() {
    if (typeof console === "object") {
        console.log("\nNel cielo e nelle altre cose mute\nTerramadre\nNon senza dolore\nIo vivo\nNè più di un albero non meno di una stella\nNei suoni e nei silenzi\nDi terra\n\n(Francesco Di Giacomo)\n\n");
    }

    var imgs = document.getElementsByTagName("img");
    for (var i = 0; i < imgs.length; i++) {
        if (imgs[i].id != "avatar") {
            imgs[i].className += " img-responsive";
        }
    }

    $(document).keyup(function(e) {
        var url;
        if ($('#searchbox').val() == '')
        {
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
            if ( typeof url != 'undefined' &&
                document.location.pathname.toString() != url ) {
                    location.href = url;
            }
        }
    });
});

function valid_search()
{
    var s = window.location.search;
    if (s == '' || s == '?q=' || new RegExp(/\?[^q]/).test(s)) return false;
    return true;
}
