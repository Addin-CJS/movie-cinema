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
                                   placeholder="영문과 숫자를 조합해 6~10글자" maxlength="10">
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
                            <input id="emailId" required><span id="middle">@</span><input id="emailAddress">
                            <select class="form-select" aria-label="Default select example" id="emailOption"
                                    onchange="handleEmailOption()">
                                <option value="input">직접입력</option>
                                <option value="@naver.com">naver.com</option>
                                <option value="@hanmail.net">hanmail.net</option>
                                <option value="@google.com">google.com</option>
                                <option value="@apple.com">apple.com</option>
                            </select>
                            <input type="hidden" id="totalEmail" name="email" value="">
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
        const getIdCheck = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]{5,10}$/;
        const $checkResult = $("#checkResult");
        const $enrollFormSubmit = $("#enrollForm :submit");

        $idInput.keyup(function() {
            const id = $idInput.val();
            let isValidId = false;

            if (!id) {
                $checkResult.show().css("color", "red").text('아이디를 입력해주세요.');
                $enrollFormSubmit.attr("disabled", true);
                return;
            } else if (!getIdCheck.test(id)) {
                $checkResult.show().css("color", "red").text('아이디는 영문과 숫자를 포함해 6~10자 입니다.');
                $enrollFormSubmit.attr("disabled", true);
                return;
            } else {
             isValidId = true;
            }

            console.log("isValidId  " +  isValidId);

            // 유효성 검사를 통과한 경우에만 AJAX 요청 실행
            if(isValidId) {
                $.ajax({
                    url: "idCheck",
                    data: {id: id},
                    success: function (result) {
                        if (result === "true") {
                            $checkResult.show().css("color", "red").text("이미 사용중이거나 사용불가한 ID입니다.");
                            $enrollFormSubmit.attr("disabled", true);
                        } else if (result === "false") {
                            $checkResult.show().css("color", "green").text("사용가능한 ID입니다.");
                            $enrollFormSubmit.attr("disabled", false);
                        } else {
                            $checkResult.show().css("color", "red").text("ID 중복 체크 중 오류가 발생했습니다.");
                            $enrollFormSubmit.attr("disabled", true);
                        }
                    },
                    error: function () {
                        console.log("아이디 중복체크용 ajax통신 실패");
                    }
                });
            }
        })
    });



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

</script>

<jsp:include page="../layouts/footer.jsp"/>