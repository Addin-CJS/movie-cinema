<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
    .showAdminPage {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        width: 80%;
    }

    .showAdminPage button {
        background: #b91c1c;
        margin: 2px;
        border: 0;
        outline: 0;
        display: block;
        position: relative;
        float: left;
        width: 60px;
        height: 30px;
        padding: 0;
        font-weight: 600;
        text-align: center;
        color: #FFF;
        border-radius: 5px;
        transition: all 0.2s ;
    }

    .showAdminPage table {
        margin-top: 40px;
        width: 80%;
        border-collapse: collapse;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }

    .showAdminPage th,
    .showAdminPage td {
        text-align: center;
        height: 100px;
        padding: 15px;
        background-color: rgba(255, 255, 255, 0.2);
        color: #fff;
    }

    .showAdminPage thead {
        th {
            background-color: #55608f;
        }
    }

    .showAdminPage tbody {
        tr {
            &:hover {
                background-color: rgba(255, 255, 255, 0.3);
            }
        }

        td {
            position: relative;

            &:hover {
                &:before {
                    content: "";
                    position: absolute;
                    left: 0;
                    right: 0;
                    top: -9999px;
                    bottom: -9999px;
                    background-color: rgba(255, 255, 255, 0.2);
                    z-index: -1;
                }
            }
        }
    }
</style>

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
                        '<button onclick="editMember(' + member.memberId + ')">수정</button>' +
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

    function editMember(memberId) {
    }

    function deleteMember(memberId) {
    }

</script>

<jsp:include page="../layouts/footer.jsp"/>
