<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>

<section>
        <div class="resetPw">
            <h2>비밀번호 재설정</h2>
            <form action="checkForResetPw" method="post" id="checkForResetPwForm">
                <div class="resetPwInfo">
                    <li class="resetPwInput">
                        <input name="username" id="username" class="form-control" placeholder="아이디" type="text">
                    </li>
                    <li class="resetPwInput">
                        <input name="name" id="name" class="form-control" placeholder="이름" type="text">
                    </li>
                     <li class="resetPwInput">
                        <input name="phoneNumber" id="phoneNumber" class="form-control" placeholder="전화번호" type="text" maxlength="11">
                     </li>
                     <div>
                            <button type="submit">계정 확인</button>
                     </div>
                </div>
            </form>
            <div id="findIdResult"></div>
            <form action="resetPw" method="post" id="resetPwForm" style="display:none;">
                <div>
                    <div>
                        <label for="password">PW</label>
                        <div class="resetPwInput">
                            <input type="password" name="password" id="password" placeholder="영문, 숫자, 영문자 포함 8~12글자"  maxlength="12">
                             <div id="checkPwResult1" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </div>
                    <div>
                         <label for="password">PW 확인</label>
                         <div class="resetPwInput">
                             <input type="password" id="passwordCheck" placeholder="비밀번호를 한번 더 입력해주세요."  maxlength="12">
                              <div id="checkPwResult2" style="font-size: 0.8em; display: none;"></div>
                         </div>
                    </div>
                </div>
                <div>
                    <input type="hidden" name="memberId" id="hiddenMemberId">
                    <input type="hidden" name="username" id="hiddenUsername">
                    <input type="hidden" name="name" id="hiddenName">
                    <input type="hidden" name="email" id="hiddenEmail">
                    <input type="hidden" name="phoneNumber" id="hiddenPhoneNumber">
                    <input type="hidden" name="homeAddress" id="hiddenHomeAddress">
                </div>
                <div>
                    <button type="submit">비밀번호 재설정</button>
                </div>
            </form>
        </div>
</section>

<script>
    $(() => {
        $("#checkForResetPwForm").on('submit', function(e) {
            e.preventDefault();

            const username = $("#username").val();
            const name = $("#name").val();
            const phoneNumber = $("#phoneNumber").val();

            // 입력값 검증
            if (!username || !name || !phoneNumber) {
                $("#findIdResult").html("모든 필드를 입력해주세요.");
                $("#resetPwForm").hide();
                return;
            }

            $.ajax({
                url: "checkForResetPw",
                type: "post",
                data : {
                    username: username,
                    name: name,
                    phoneNumber: phoneNumber
                },
                success: function (result) {
                    if(result && result.username === username) {
                        $("#findIdResult").html("계정확인이 되었습니다.");

                        $("#hiddenMemberId").val(result.memberId);
                        $("#hiddenUsername").val(result.username);
                        $("#hiddenName").val(result.name);
                        $("#hiddenEmail").val(result.email);
                        $("#hiddenPhoneNumber").val(result.phoneNumber);
                        $("#hiddenHomeAddress").val(result.homeAddress);

                        $("#resetPwForm").show();
                    } else {
                        $("#findIdResult").html("계정을 찾을 수 없습니다.");
                        $("#resetPwForm").hide();
                    }
                },
                error: function() {
                    console.log("계정 확인 ajax 통신 실패");
                    $("#resetPwForm").hide();
                }
            });
        });
    });

    $(() => {
        const $pwInput = $("#password");
        var getPwCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$!%])[A-Za-z\d@#$!%]{8,12}$/;
        const $checkPwResult1 = $("#checkPwResult1");
        const $enrollFormSubmit = $("#resetPwForm :submit");

        $pwInput.on('input', function() {
            const pw = $pwInput.val();

            if(!pw) {
                $checkPwResult1.show().css("color", "red").text('비밀번호를 입력해주세요.');
                $enrollFormSubmit.attr("disabled", true);
                return;
            } else if (!getPwCheck.test(pw)) {
                 $checkPwResult1.show().css("color", "red").text('비밀번호는 영문과 숫자, 특수기호를 포함해 8~12자 입니다.');
                 $enrollFormSubmit.attr("disabled", true);
                 return;
            } else {
                $checkPwResult1.show().css("color", "green").text('유효한 비밀번호입니다.');
                $enrollFormSubmit.attr("disabled", false);
            }
        })
    });

    $(function() {
        const $password = $("#password");
        const $passwordCheck = $("#passwordCheck");
        const $checkPwResult2 = $("#checkPwResult2");
        const $resetPwFormSubmit = $("#resetPwForm :submit");

        function validatePassword() {
            const pw = $password.val();
            const pwCheck = $passwordCheck.val();

            if (pw !== pwCheck) {
                $checkPwResult2.show().css("color", "red").text('비밀번호가 불일치합니다. 다시 입력해주세요.');
                $resetPwFormSubmit.attr("disabled", true);
            } else {
                $checkPwResult2.show().css("color", "green").text('비밀번호가 일치합니다.');
                $resetPwFormSubmit.attr("disabled", false);
            }
        }

        $password.on('input', validatePassword);
        $passwordCheck.on('input', validatePassword);
    });

</script>


<jsp:include page="../layouts/footer.jsp"/>