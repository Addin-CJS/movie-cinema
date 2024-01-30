<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>


<section>
    <div class="register">
        <h3>회원가입</h3>

        <form action="register" method="post" id="enrollForm">
            <table>
                <tr>
                    <th><label for="username">ID</label></th>
                    <td>
                        <div">
                            <input type="text" name="username" class="form-control" id="username"
                                   placeholder="영문과 숫자를 조합해 6~10글자" maxlength="10">
                            <div id="checkIdResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="name">NAME</label></th>
                    <td>
                        <div>
                            <input type="text" name="name" id="name" placeholder="이름 입력" required>
                            <div id="checkNameResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="password">PW</label></th>
                    <td>
                        <div>
                            <input type="password" name="password" id="password" placeholder="영문, 숫자, 영문자 포함 8~12글자"  maxlength="12">
                             <div id="checkPwResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="email">EMAIL</label></th>
                    <td>
                        <div id="emailField">
                            <input id="emailId" required><span id="middle">@</span><input id="emailAddress">
                            <select class="form-select" aria-label="Default select example" id="emailOption"
                                    onchange="handleEmailOption()" required>
                                <option value="input">직접입력</option>
                                <option value="@naver.com">naver.com</option>
                                <option value="@hanmail.net">hanmail.net</option>
                                <option value="@google.com">google.com</option>
                                <option value="@apple.com">apple.com</option>
                            </select>
                            <input type="hidden" id="totalEmail" name="email" value="">
                            <div id="checkEmailResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="phoneNumber">PHONE</label></th>
                    <td>
                        <div class="mb-3">
                            <input name="phoneNumber" id="phoneNumber" placeholder="- 빼고 입력해주세요"  maxlength="11" required>
                            <div id="checkPhoneResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="kakaoAddress">ADDRESS</label></th>
                    <td>
                        <div id="addressField">
                            <input type="text" name="homeAddress" id="kakaoAddress" readonly>
                            <input type="button" value="주소 검색" onclick="findAddr();">
                            <div id="checkAddressResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="submit">회원가입</button>
                        <button type="reset">초기화</button>
                    <td>
                <tr>
            </table>
        </form>
    </div>
</section>

<script>
    $(() => {
        const $idInput = $("#username");
        const getIdCheck = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]{5,10}$/;
        const $checkIdResult = $("#checkIdResult");
        const $enrollFormSubmit = $("#enrollForm :submit");

        $idInput.focus();


        $idInput.on('blur keyup', function() {
            const id = $idInput.val();
            let isValidId = false;

            if (event.type === 'blur' && !id) {
                $checkIdResult.show().css("color", "red").text('아이디를 입력해주세요.');
                $enrollFormSubmit.attr("disabled", true);
                return;
            } else if (!getIdCheck.test(id)) {
                $checkIdResult.show().css("color", "red").text('아이디는 영문과 숫자를 포함해 6~10자 입니다.');
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
                            $checkIdResult.show().css("color", "red").text("이미 사용중 ID입니다.");
                            $enrollFormSubmit.attr("disabled", true);
                        } else if (result === "false") {
                            $checkIdResult.show().css("color", "green").text("사용가능한 ID입니다.");
                            $enrollFormSubmit.attr("disabled", false);
                        } else {
                            $checkIdResult.show().css("color", "red").text("ID 중복 체크 중 오류가 발생했습니다.");
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

   // 비밀번호
   $(() => {
        const $pwInput = $("#password");
        var getPwCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$!%])[A-Za-z\d@#$!%]{8,12}$/;
        const $checkPwResult = $("#checkPwResult");
        const $enrollFormSubmit = $("#enrollForm :submit");

        $pwInput.on('input', function() {
            const pw = $pwInput.val();

            if(!pw) {
                $checkPwResult.show().css("color", "red").text('비밀번호를 입력해주세요.');
                $enrollFormSubmit.attr("disabled", true);
                return;
            } else if (!getPwCheck.test(pw)) {
                 $checkPwResult.show().css("color", "red").text('비밀번호는 영문과 숫자, 특수기호를 포함해 8~12자 입니다.');
                 $enrollFormSubmit.attr("disabled", true);
                 return;
            } else {
                $checkPwResult.show().css("color", "green").text('사용가능한 비밀번호입니다.');
                $enrollFormSubmit.attr("disabled", false);
            }
        })
   });

   // 이름
   $(() => {
        const $nameInput = $("#name");
        var getNameCheck = /^[a-zA-Z가-힣]+$/;
        const $checkNameResult = $("#checkNameResult");
        const $enrollFormSubmit = $("#enrollForm :submit");

        $nameInput.on('input', function() {
            const name = $nameInput.val();

            if(!name){
                 $checkNameResult.show().css("color", "red").text('이름을 입력해주세요.');
                 $enrollFormSubmit.attr("disabled", true);
            } else {
                $checkNameResult.hide();
            }
        })
   });

    // 전화번호
    $(() => {
        const $phoneInput = $("#phoneNumber");
        var getPhoneCheck = /^[0-9]{11}$/;
        const $checkPhoneResult = $("#checkPhoneResult");
        const $enrollFormSubmit = $("#enrollForm :submit");

        $phoneInput.on('input', function() {
            const phone = $phoneInput.val();

            if(!phone) {
            $checkPhoneResult.show().css("color", "red").text('휴대폰 번호를 입력해주세요.');
            $enrollFormSubmit.attr("disabled", true);
             return;
            } else if (!getPhoneCheck.test(phone)) {
                 $checkPhoneResult.show().css("color", "red").text('전화번호에는 숫자만 넣어주세요. 전화번호는 11자리 입니다.');
                 $enrollFormSubmit.attr("disabled", true);
                 return;
            } else {
                $checkPhoneResult.show().css("color", "green").text('유효한 전화번호입니다.');
                $enrollFormSubmit.attr("disabled", false);
            }
        })
   });

    $("#enrollForm").submit(function(event) {
        const username = $("#username").val().trim();
        const name = $("#name").val().trim();
        const password = $("#password").val().trim();
        const emailId = $("#emailId").val().trim();
        const emailAddress = $("#emailAddress").val().trim();
        const phoneNumber = $("#phoneNumber").val().trim();
        const kakaoAddress = $("#kakaoAddress").val().trim();

        if (!username || !name || !password || !emailId || !emailAddress || !phoneNumber || !kakaoAddress) {
            alert("필수 입력 값을 모두 입력해주세요.");
            event.preventDefault(); // 폼 제출 방지
            return false;
        }
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