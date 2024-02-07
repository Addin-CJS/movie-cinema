<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layouts/header.jsp"/>
<section id="section">
    <div id="test"></div>
    <div class="container">
        <div class="successWrapper">
            <div class="successInfo">
                <div class="successMsg">
                    <h1>티켓팅 완료</h1>
                    <p>결제가 완료되었습니다. 감사합니다.</p>
                </div>

                <div class="successBtn">
                        <button id="homeBtn" onclick="location.href='/'">홈으로</button>
                        <button id="mypageBtn" onclick="location.href='/member/myPage'">마이페이지</button>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layouts/footer.jsp"/>