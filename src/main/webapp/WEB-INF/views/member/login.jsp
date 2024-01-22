<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="../js/script.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header>
       <jsp:include page="../layouts/header.jsp" />
    </header>
    <section>
        <div class="login">
           <h4>로그인</h4>
           <form action="login" method="post">
               <table>
                    <tr>
                        <th><label for="userId" class="form-label">ID</label></th>
                        <td><div class="mb-3">
                            <input name="username" class="form-control" id="userId" placeholder="아이디를 입력해주세요">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="password" class="form-label">PW</label></th>
                        <td><div class="mb-3">
                            <input type="password" name="password" class="form-control" id="password" placeholder="비밀번호를 입력해주세요">
                        </div></td>
                    </tr>
               </table>
               <button type="button" class="btn btn-light" onclick="location.href='/member/register'">회원가입</button>&emsp;
               <button type="submit" class="btn btn-light">로그인</button>
           </form>
        </div>
    </section>
    <jsp:include page="../layouts/footer.jsp" />
</body>
</html>

