<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>
<section class="showMyPage">
    <div class="myPage-navbar">
            <h3>마이페이지</h3>
            <div>
                <aside>
                    <ul>
                        <li id="showMyInfo" onclick="showSubMenu('myInfo');">
                                <span>개인 정보</span>
                            <ul id="myInfo"style="display: none">
                                <li id="myInfoEdit">
                                    <span>내 정보 수정</span>
                                </li>
                                <li id="resetMyPw">
                                    <span>비밀번호 재설정</span>
                                </li>
                                <li id="byeMember">
                                    <span>회원 탈퇴</span>
                                </li>
                            </ul>
                        </li>
                        <li id="showMyTickets">
                                <span>예매 내역 조회</span>
                        </li>
                        <li id="showMyReviews">
                                <span>리뷰 보기</span>
                        </li>
                        <li>
                            <a id="showMyInterestMovies">
                                <i><img src="/img/icons/film.png" alt="film"></i>
                                <span>관심 영화</span>
                            </a>
                        </li>
                    </ul>
                </aside>
            </div>
        </div>
        <div class="showPage">
        </div>
</section>

<script>
    function showSubMenu(menuId) {
        const subMenu = document.getElementById(menuId);
        if (subMenu.style.display === 'block') {
            subMenu.style.display = 'none';
        } else {
            subMenu.style.display = 'block';
        }
    }

    function loadReviewPage(pageNumber) {
        $.ajax({
            url: '/member/myReviews?page=' + pageNumber,
            type: 'GET',
            data: {
                page: pageNumber
            },
            success: function(data) {
                $('.showPage').html(data);
            }
        });
    }

    function loadTicketPage(pageNumber) {
        $.ajax({
            url: '/member/myTickets?page=' + pageNumber,
            type: 'GET',
            data: {
                page: pageNumber
            },
            success: function(data) {
                $('.showPage').html(data);
            }
        });
    }

    function loadInterestMoviesPage(pageNumber) {
        $.ajax({
            url: '/member/myInterestMovies?page=' + pageNumber,
            type: 'GET',
            success: function(data) {
                console.log("관심영화 목록 조회 성공");
                $('.showPage').html(data);
            }
        });
    }


    $(document).ready(function() {
        $("#showMyInfo").click(function(e) {
            e.preventDefault();
            $.ajax({
                url: '/member/myInfo',
                type: 'GET', // 요청 방식
                success: function(data) {
                    $('.showPage').html(data);
                }
            });
        });

        $("#myInfoEdit").click(function(e) {
            e.preventDefault();
            $.ajax({
                url: '/member/myPageEdit',
                type: 'GET',
                success: function(data) {
                    $('.showPage').html(data);
                }
            });
        });

        $("#resetMyPw").click(function(e) {
            e.preventDefault();
            $.ajax({
                url: '/member/resetMyPw',
                type: 'GET',
                success: function(data) {
                    $('.showPage').html(data);
                }
            });
        });



        $("#showMyInterestMovies").click(function(e) {
            e.preventDefault();
            loadInterestMoviesPage(0);
        });


        $("#showMyReviews").click(function(e) {
            e.preventDefault();
            loadReviewPage(0);
        });

        $("#showMyTickets").click(function(e) {
            e.preventDefault();
            loadTicketPage(0);
        });
    });
</script>
<jsp:include page="../layouts/footer.jsp"/>