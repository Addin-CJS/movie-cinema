<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>


<section>
    <div class="register">
        <h4>회원가입</h4>

        <form action="register" method="post" id="enrollForm">

            <table>
                <tr>
                    <th><label for="username">ID</label></th>
                    <td>
                        <div class="mb-3">
                            <input type="text" name="username" class="form-control" id="username"
                                   placeholder="영문 6글자 이상">
                            <div id="checkResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="name">NAME</label></th>
                    <td>
                        <div class="mb-3">
                            <input type="text" name="name" id="name" placeholder="이름 입력">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="password">PW</label></th>
                    <td>
                        <div class="mb-3">
                            <input type="password" name="password" id="password" placeholder="영문, 숫자 포함 8글자 이상">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="email">EMAIL</label></th>
                    <td>
                        <div>
                            <input name="email" id="email" placeholder="메일 주소">
                            <select class="form-select" aria-label="Default select example" id="emailOption"
                                    onchange="handleEmailOption()">
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
                    <td>
                        <div class="mb-3">
                            <input name="phoneNumber" id="phoneNumber" placeholder="-빼고 입력해주세요">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="kakaoAddress">ADDRESS</label></th>
                    <td>
                        <input type="text" name="homeAddress" id="kakaoAddress" readonly>
                        <input type="button" value="주소 검색" onclick="findAddr();">
                    </td>
                </tr>
            </table>
            <button type="submit">회원가입</button>&emsp;
            <button type="reset">초기화</button>
        </form>
    </div>
</section>
<script>
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
 function findAddr() {
        new daum.Postcode({
            oncomplete: function (data) {
                $("#kakaoAddress").val(data.address);
            }
        }).open();
    }

</script>
<jsp:include page="../layouts/footer.jsp"/>