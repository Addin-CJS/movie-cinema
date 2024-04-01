<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section>
        <div class="withdraw">
            <h3>회원 탈퇴<br><br>
                탈퇴한 아이디는 다시 사용할 수 없습니다. <br>
                회원 탈퇴시 더 이상 서비스 이용이 불가능하며, 모든 데이터가 삭제됩니다. </h3>
            <sec:authentication var="loginUser" property="principal.member"/>
            <form action="confirmWithdraw" method="post" id="withdrawForm">
                <div class="withdrawInfo">
                    <div class="withdrawWrap">
                        <label for="password">ID</label>
                        <div>
                            <input name="username" id="username" value="${loginUser.username}" readonly>
                        </div>
                    </div>
                    <div class="withdrawWrap">
                        <label for="password">PW</label>
                        <div>
                            <input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요"  maxlength="12">
                        </div>
                     </div>
                    <div id="checkMemberResult" display: none;"></div>
                    <div>
                        <button type="button" style="display:none;" id="withdrawButton" onclick="confirmWithdrawal()">탈퇴</button>
                    </div>
                    <input type="hidden" name="memberId" value="${loginUser.memberId}">
                    <input type="hidden" name="name" value="${loginUser.name}">
                    <input type="hidden" name="email" value="${loginUser.email}">
                    <input type="hidden" name="phoneNumber" value="${loginUser.phoneNumber}">
                    <input type="hidden" name="homeAddress" value="${loginUser.homeAddress}">
                </div>
            </form>
        </div>
</section>

<script>
    $(() => {
        $("#password").on("input", function() {
            if ($(this).val().length > 0) {
                $.ajax({
                    url: "withdrawMember",
                    type: "post",
                    data : {
                        password: $(this).val(),
                        username: "${loginUser.username}",
                        name: "${loginUser.name}"
                    },
                    success: function (result) {
                        console.log(result);
                        if(result) {
                            $("#checkMemberResult").html("계정이 확인되었습니다.").show();
                            $("#withdrawButton").show();
                        } else {
                            $("#checkMemberResult").html("비밀번호가 틀렸습니다. 다시 입력해주세요.").show();
                            $("#withdrawButton").hide();
                        }
                    },
                    error: function() {
                        console.log("계정 찾기 ajax 통신 실패");
                        $("#withdrawButton").hide();
                    }
                });
            } else {
                $("#checkMemberResult").hide();
                $("#withdrawButton").hide();
            }
        });
    });

    function confirmWithdrawal() {
        if (confirm("정말로 탈퇴하시겠습니까?")) {
            let formData = new FormData();
            formData.append("username", "${loginUser.username}");
            formData.append("password", document.getElementById("password").value);
            formData.append("name", "${loginUser.name}");
            formData.append("email", "${loginUser.email}");
            formData.append("phoneNumber", "${loginUser.phoneNumber}");
            formData.append("homeAddress", "${loginUser.homeAddress}");

            console.log(formData);
            $.ajax({
                url:"confirmWithdraw",
                type:"post",
                data: formData,
                processData: false,
                contentType: false,
                success: function(result) {
                    if(result ==="success") {
                        alert("회원 탈퇴가 완료되었습니다. 감사합니다.");
                        window.location.href = "/logout";
                    }
                },
                error: function() {
                    alert("회원 탈퇴 ajax 통신오류");
                }
            });
        } else {
            confirm("취소되었습니다.")
        }
    }
</script>
