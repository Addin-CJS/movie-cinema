$(document).ready(function(){
    //indicator
    let marker = $('.marker');
    let items = $('#menu-box li');
    let currentPath = window.location.pathname;

    function initializeIndicator() {
        items.each(function() {
            let path = $(this).data("path");
            if (path && currentPath.includes(path)) {
                updateIndicator(this);
            }
        });
    }

    function updateIndicator(element) {
        marker.css('left', element.offsetLeft + 'px');
        marker.css('width', element.offsetWidth + 'px');
    }

    initializeIndicator();


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
});

