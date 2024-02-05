<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section>
        <div class="resetMyPw">
            <h3>비밀번호 재설정</h3>
            <sec:authentication var="loginUser" property="principal.member"/>
            <form action="resetMyPw" method="post" id="resetMyPwForm">
                <table>
                     <tr>
                        <th><label for="password">PW</label></th>
                        <td>
                            <div>
                                <input type="password" name="password" id="password" placeholder="영문, 숫자, 영문자 포함 8~12글자"  maxlength="12">
                                 <div id="checkPwResult1" style="font-size: 0.8em; display: none;"></div>
                            </div>
                        </td>
                     </tr>
                      <tr>
                         <th><label for="password">PW 확인</label></th>
                         <td>
                             <div>
                                 <input type="password" id="passwordCheck" placeholder="비밀번호를 한번 더 입력해주세요."  maxlength="12">
                                  <div id="checkPwResult2" style="font-size: 0.8em; display: none;"></div>
                             </div>
                         </td>
                      </tr>
                      <tr>
                        <td colspan="2">
                             <button type="submit">재설정</button>
                        </td>
                      </tr>
                </table>
                <input type="hidden" name="memberId" value="${loginUser.memberId}">
                <input type="hidden" name="username" value="${loginUser.username}">
                <input type="hidden" name="name" value="${loginUser.name}">
                <input type="hidden" name="email" value="${loginUser.email}">
                <input type="hidden" name="phoneNumber" value="${loginUser.phoneNumber}">
                <input type="hidden" name="homeAddress" value="${loginUser.homeAddress}">
            </form>
        </div>
</section>

<script>
    $(() => {
        const $pwInput = $("#password");
        var getPwCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$!%])[A-Za-z\d@#$!%]{8,12}$/;
        const $checkPwResult1 = $("#checkPwResult1");
        const $enrollFormSubmit = $("#resetMyPwForm :submit");

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
