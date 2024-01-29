$(() => {
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

// ------- 회원가입 -----------
// 아이디 중복검사
  $(() => {
        const $idInput = $("#username");
        $idInput.keyup(function () {
            if ($idInput.val().length >= 5) {
                $.ajax({
                    url: "idCheck",
                    data: {id: $idInput.val()},
                    success: function (result) {
                        console.log(result);
                        if (result) {
                            $("#checkResult").show();
                            $("#checkResult").css("color", "red").text("이미 사용중인 ID입니다.");
                            $("#enrollForm :submit").attr("disabled", true);
                        } else {
                            $("#checkResult").show();
                            $("#checkResult").css("color", "green").text("사용가능한 ID입니다.");
                            $("#enrollForm :submit").attr("disabled", false);
                        }
                    },
                    error: function () {
                        console.log("아이디 중복체크용 ajax통신 실패");
                    }
                })
            } else {
                $("#checkResult").hide();
                $("#enrollForm :submit").attr("disabled", true);
            }
        })
    })
// 카카오 주소
 function findAddr() {
        new daum.Postcode({
            oncomplete: function (data) {
                $("#kakaoAddress").val(data.address);
            }
        }).open();
    }

// 이메일 주소 가져오기
$("#emailId, #emailAddress, #emailOption").on('blur change', function() {
    email();
});

function email() {
    const emailId = $("#emailId").val();
    const middle = $("#middle").text();
    const emailAddress = $("#emailAddress").val();
    if(emailId != null && emailAddress != null) {
        $("#totalEmail").val(emailId+middle+emailAddress);
    }
}
function handleEmailOption() {
     var emailOption = $("#emailOption").val();
        if (emailOption === "input") {
            $("#emailAddress").val("").attr("disabled", false);
        } else {
            $("#emailAddress").val(emailOption.replace("@", "")).attr("disabled", true);
        }
    }