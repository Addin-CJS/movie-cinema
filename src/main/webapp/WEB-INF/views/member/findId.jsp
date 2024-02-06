<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>

<section>
        <div class="findId">
            <h2>아이디 찾기</h2>
            <form action="findId" method="post" id="findIdForm">
                <div class="findIdInfo">
                    <li class="findIdInput">
                        <input name="name" id="name" class="form-control" placeholder="이름을 입력해주세요" type="text">
                    </li>
                    <li class="findIdInput">
                        <input name="phoneNumber" id="phoneNumber" class="form-control" placeholder="전화번호를 입력해주세요" type="text" maxlength="11">
                    </li>
                     <div>
                        <button type="submit">아이디 찾기</button>
                     </div>
                </div>
            </form>
                 <div id="findIdResult"></div>
        </div>
</section>

<script>
    $(() => {
        $("#findIdForm").on('submit', function(e) {
                e.preventDefault();

            const name = $("#name").val();
            const phoneNumber = $("#phoneNumber").val();

            if (!name || !phoneNumber) {
                $("#findIdResult").html("모든 필드를 입력해주세요.");
                return;
            }

            $.ajax({
                url: "findId",
                type: "post",
                data : {
                    name: name,
                    phoneNumber: phoneNumber
                },
                success: function (result) {
                    console.log(result);
                    if(result) {
                        $("#findIdResult").html("찾으시는 아이디는 `" + result.username + "` 입니다.");
                        $("#findIdResult").append('<div><a href="/member/login">[로그인으로 돌아가기]</a></div>');
                    } else {
                        $("#findIdResult").html("아이디를 찾을 수 없습니다.");
                    }
                },
                error: function() {
                    console.log("아이디 찾기 ajax 통신 실패");
                }
            });
        })
    });
</script>


<jsp:include page="../layouts/footer.jsp"/>