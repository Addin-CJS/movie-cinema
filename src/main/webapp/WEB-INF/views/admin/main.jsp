<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section class="showMyPage">
    <div class="myPage-navbar">
        <h3>관리자 페이지</h3>
        <div>
            <aside>
                <ul>
                    <li id="showMyInfo" onclick="showSubMenu('myInfo');">
                        <span>회원 관리</span>
                    </li>
                </ul>
            </aside>
        </div>
    </div>
    <div class="showAdminPage">
    </div>
</section>
<script>
    $(document).ready(function () {
        $.ajax({
            url: '/api/members',
            method: 'GET',
            dataType: 'json',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (data) {
                var membersHtml = '<table><tr><th>회원 ID</th><th>사용자명</th><th>이름</th><th>이메일</th><th>전화번호</th><th>주소</th><th></th></tr>';
                $.each(data, function (index, member) {
                    membersHtml += '<tr>' +
                        '<td>' + member.memberId + '</td>' +
                        '<td>' + member.username + '</td>' +
                        '<td>' + member.name + '</td>' +
                        '<td>' + member.email + '</td>' +
                        '<td>' + member.phoneNumber + '</td>' +
                        '<td>' + member.homeAddress + '</td>' +
                        '<td>' +
                        '<button onclick="modifyMember(' + member.memberId + ')">수정</button>' +
                        '<button onclick="deleteMember(' + member.memberId + ')">삭제</button>' +
                        '</td>' +
                        '</tr>';
                });
                membersHtml += '</table>';
                $('.showAdminPage').html(membersHtml);
            },
            error: function (xhr, status, err) {
                console.log(err);
            }
        });
    });

    function modifyMember(memberId) {

    }

    function deleteMember(memberId) {
        if(confirm("회원을 삭제 하시겠습니까?")) {
            $.ajax({
                url: "/api/member/delete?memberId="+memberId,
                type: "GET",
                success: function(response) {
                    console.log(response);
                },
                error: function(xhr, status, error) {
                    console.log(error);
                    alert("회원 삭제 실패");
                }
            });
        }
    }

</script>

<jsp:include page="../layouts/footer.jsp"/>