<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="../js/script.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <header>
       <jsp:include page="../layouts/header.jsp" />
    </header>
    <section>
        <div class="register">
           <h4>회원가입</h4>
           <form action="register" method="post">
               <table>
                    <tr>
                        <th><label for="username">ID</label></th>
                        <td><div class="mb-3">
                            <input type="text" name="username" id="username" placeholder="영문 6글자 이상">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="name">NAME</label></th>
                        <td><div class="mb-3">
                            <input type="text" name="name" id="name" placeholder="이름 입력">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="password">PW</label></th>
                        <td><div class="mb-3">
                            <input type="password" name="password" id="password" placeholder="영문, 숫자 포함 8글자 이상">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="email">EMAIL</label></th>
                        <td>
                            <div>
                                <input name="email" id="email" placeholder="메일 주소">
                                <select class="form-select" aria-label="Default select example" id="emailOption" onchange="handleEmailOption()">
                                    <option value="input">직접입력</option>
                                    <option value="@naver.com">@naver.com</option>
                                    <option value="@hanmail.net">@hanmail.net</option>
                                    <option value="@google.com">@google.com</option>
                                    <option value="@apple.com">@apple.com</option>
                                </select>
                            </div>
                        </td>
                    </tr>

                     <tr>
                        <th><label for="phoneNumber">PHONE</label></th>
                        <td><div class="mb-3">
                            <input name="phoneNumber" id="phoneNumber" placeholder="-빼고 입력해주세요">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="kakaoAddress">ADDRESS</label></th>
                        <td>
                            <input type="text" name="homeAddress"  id="kakaoAddress" readonly>
                            <input type="button" value="주소 검색" onclick="findAddr();">
                        </td>
                    </tr>
               </table>
               <button type="submit">회원가입</button>&emsp;
               <button type="reset">초기화</button>
           </form>
        </div>
    </section>
       <jsp:include page="../layouts/footer.jsp" />
</body>
</html>

