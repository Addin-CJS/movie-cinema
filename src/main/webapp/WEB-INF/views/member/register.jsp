<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
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
        <div class="register">
           <h4>회원가입</h4>

           <form action="register" method="post" id="enrollForm">


               <table>
                    <tr>
                        <th><label for="username" class="form-label">ID</label></th>
                        <td><div class="mb-3">
                            <input type="text" name="username" class="form-control" id="username" placeholder="영문 6글자 이상">
                            <div id="checkResult" style="font-size: 0.8em; display: none;"></div>
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="name" class="form-label">NAME</label></th>
                        <td><div class="mb-3">
                            <input type="text" name="name" class="form-control" id="name" placeholder="이름 입력">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="password" class="form-label">PW</label></th>
                        <td><div class="mb-3">
                            <input type="password" name="password" class="form-control" id="password" placeholder="영문, 숫자 포함 8글자 이상">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="email" class="form-label">EMAIL</label></th>
                        <td>
                            <div class="mb-3 d-flex">
                                <input name="email" class="form-control" id="email" placeholder="메일 주소">
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
                        <th><label for="phoneNumber" class="form-label">PHONE</label></th>
                        <td><div class="mb-3">
                            <input name="phoneNumber" class="form-control" id="phoneNumber" placeholder="-빼고 입력해주세요">
                        </div></td>
                    </tr>
                    <tr>
                        <th><label for="homeAddress" class="form-label">ADDRESS</label></th>
                        <td><div class="mb-3">
                            <input name="homeAddress" class="form-control" id="homeAddress" placeholder="주소를 입력해주세요">
                        </div></td>
                    </tr>
               </table>
               <button type="submit" class="btn btn-light">회원가입</button>&emsp;
               <button type="reset" class="btn btn-light">초기화</button>
           </form>
        </div>
    </section>
    <jsp:include page="../layouts/footer.jsp" />


    <script>
        $(()=>{
            const $idInput = $("#username");
            $idInput.keyup(function() {
                if($idInput.val().length >= 5) {
                    $.ajax({
                        url: "idCheck",
                        data: {id: $idInput.val()},
                        success:function(result) {
                            console.log(result);
                            if(result) {
                                $("#checkResult").show();
                                $("#checkResult").css("color", "red").text("이미 사용중인 ID입니다.");
                                $("#enrollForm :submit").attr("disabled", true);
                            } else {
                                $("#checkResult").show();
                                $("#checkResult").css("color", "green").text("사용가능한 ID입니다.");
                                $("#enrollForm :submit").attr("disabled", false);
                            }
                        },
                        error:function(){
                            console.log("아이디 중복체크용 ajax통신 실패");
                        }
                    })
                } else {
                    $("#checkResult").hide();
                    $("#enrollForm :submit").attr("disabled", true);
                }
            })
        })
    </script>





</body>
</html>

