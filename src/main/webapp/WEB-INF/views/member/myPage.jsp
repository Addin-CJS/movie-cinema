<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>
<section class="showMyPage">
    <div class="myPage-navbar">
            <h3>마이페이지</h3>
            <div>
                <aside>
                    <ul>
                        <li id="showMyInfo" onclick="showSubMenu('myInfo');">
                            <i><img src="/img/icons/man.png" alt="people"></i>
                                <span>개인 정보</span>
                            <ul id="myInfo" style="display: none">
                                <li id="myInfoEdit">
                                    <i><img src="/img/icons/edit.png" alt="people"></i>
                                    <span>내 정보 수정</span>
                                </li>
                                <li id="resetMyPw">
                                    <i><img src="/img/icons/locked.png" alt="people"></i>
                                    <span>비밀번호 재설정</span>
                                </li>
                                <li>
                                    <i><img src="/img/icons/out.png" alt="people"></i>
                                    <span>회원 탈퇴</span>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">
                                <i><img src="/img/icons/tickets.png" alt="people"></i>
                                <span>예매 내역 조회</span>
                            </a>
                        </li>
                        <li id="showMyReviews">
                                <i><img src="/img/icons/comments.png" alt="people"></i>
                                <span>리뷰 보기</span>
                        </li>
                        <li>
                            <a href="#">
                                <i><img src="/img/icons/film.png" alt="people"></i>
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
                type: 'GET', // 요청 방식
                success: function(data) {
                    $('.showPage').html(data);
                }
            });
        });

        $("#resetMyPw").click(function(e) {
            e.preventDefault();
            $.ajax({
                url: '/member/resetMyPw',
                type: 'GET', // 요청 방식
                success: function(data) {
                    $('.showPage').html(data);
                }
            });
        });

        $("#showMyReviews").click(function(e) {
            e.preventDefault();
            $.ajax({
                url: '/member/myReviews',
                type: 'GET', // 요청 방식
                success: function(data) {
                    $('.showPage').html(data);
                }
            });
        });


    });
</script>
<jsp:include page="../layouts/footer.jsp"/>