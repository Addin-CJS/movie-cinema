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
                    <li id="writeAnnounce">
                        <a href="/writeAnnounce">공지사항 작성</a>
                    </li>
                </ul>
            </aside>
        </div>
    </div>
    <div class="showAdminPage">
    </div>
</section>
<script>
    var membersData = {};

    $(document).ready(function () {
        updatePage();
    });

    function updatePage() {
        $.ajax({
            url: '/api/members',
            method: 'GET',
            dataType: 'json',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (data) {
                var membersHtml = '<table><tr><th>회원 ID</th><th>사용자명</th><th>이름</th><th>이메일</th><th>전화번호</th><th>주소</th><th></th></tr>';
                $.each(data, function (index, member) {
                    membersData[member.memberId] = member;

                    membersHtml += '<tr id="member-' + member.memberId + '">' +
                        '<td>' + member.memberId + '</td>' +
                        '<td class="username">' + member.username + '</td>' +
                        '<td class="name">' + member.name + '</td>' +
                        '<td class="email">' + member.email + '</td>' +
                        '<td class="phoneNumber">' + member.phoneNumber + '</td>' +
                        '<td class="homeAddress">' + member.homeAddress + '</td>' +
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
    }

    function modifyMember(memberId) {
        var member = membersData[memberId]; // 전역 변수에서 회원 정보 가져오기

        // 회원 정보를 사용하여 입력 필드 생성
        var memberRow = $("#member-" + memberId);
        memberRow.find(".username").html('<input type="text" value="' + member.username + '" />');
        memberRow.find(".name").html('<input type="text" value="' + member.name + '" />');
        memberRow.find(".email").html('<input type="email" value="' + member.email + '" />');
        memberRow.find(".phoneNumber").html('<input type="text" value="' + member.phoneNumber + '" />');
        memberRow.find(".homeAddress").html('<input type="text" value="' + member.homeAddress + '" />');

        memberRow.find("td:last-child").html('<button onclick="saveMember(' + memberId + ')">저장</button>');
    }

    function saveMember(memberId) {
        if(confirm("회원정보를 수정 하시겠습니까?")) {
            var memberRow = $("#member-" + memberId);
            var username = memberRow.find(".username input").val();
            var name = memberRow.find(".name input").val();
            var email = memberRow.find(".email input").val();
            var phoneNumber = memberRow.find(".phoneNumber input").val();
            var homeAddress = memberRow.find(".homeAddress input").val();

            $.ajax({
                url: "/api/member/modify",
                type: "POST",
                data: {
                    "memberId": memberId,
                    "username": username,
                    "name": name,
                    "email": email,
                    "phoneNumber": phoneNumber,
                    "homeAddress": homeAddress
                },
                success: function(response) {
                    updatePage(); // 성공적으로 수정 후 페이지 업데이트
                },
                error: function(xhr, status, error) {
                    console.log(error);
                    alert("회원 정보 수정 실패");
                }
            });
        }
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