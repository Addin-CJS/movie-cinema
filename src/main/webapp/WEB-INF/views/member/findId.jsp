<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>

<section>
        <div class="findId">
            <h4>아이디 찾기</h4>
            <form action="findId" method="post" id="findIdForm">
                <table>
                    <tr>
                        <th><label for="name">NAME</label></th>
                        <td>
                            <div>
                                <input name="name" id="name" class="form-control" placeholder="이름" type="text">
                            </div>
                        </td>
                    </tr>
                     <tr>
                         <th><label for="phoneNumber">PHONE</label></th>
                         <td>
                            <input name="phoneNumber" id="phoneNumber" class="form-control" placeholder="전화번호" type="text" maxlength="11">
                         </td>
                     </tr>
                </table>
                <button type="submit">아이디 찾기</button>
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
                        $("#findIdResult").html("찾으시는 아이디는 `" + name + "` 입니다.");
                        $("#findIdResult").append('<div><a href="/member/login">로그인으로 돌아가기</a></div>');
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