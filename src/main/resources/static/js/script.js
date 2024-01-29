$(() => {
    //indicator
    let marker = $('.marker');
    let items = $('nav ul li');

    function indicator(e) {
        marker.css('left', e.offsetLeft + 'px');
        marker.css('width', e.offsetWidth + 'px');
    }

    items.each(function () {
        $(this).click(function (e) {
            indicator(e.target);
        });
    });

//scroll
    let nav = $('nav');

    $(window).scroll(function () {
        if ($(this).scrollTop() >= 20) {
            nav.addClass('nav');
        } else {
            nav.removeClass('nav');
        }

        if ($(this).scrollTop() >= 700) {
            nav.addClass('navBlack');
        } else {
            nav.removeClass('navBlack');
        }
    });

//menu
    let menuBx = $('#menu-box');
    let a = true;

    $('#menu').click(function () {
        // 클릭 이벤트 핸들러
        if (a == true) {
            menuBx.css('display', 'block');
            $(this).removeClass('fa-bars').addClass('fa-remove');
            a = false;
        } else {
            menuBx.css('display', 'none');
            $(this).removeClass('fa-remove').addClass('fa-bars');
            a = true;
        }
    });


    $(".carousel").owlCarousel({
        margin: 20,
        loop: true,
        autoplay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: true,
        responsive: {
            0: {
                items: 3,
                nav: true
            },
            600: {
                items: 3,
                nav: true
            },
            1000: {
                items: 3,
                nav: true
            }
        }
    });

});

