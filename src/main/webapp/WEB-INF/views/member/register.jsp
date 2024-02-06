<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>


<section>
    <div class="register">
        <h2>회원가입</h2>
        <form action="register" method="post" id="enrollForm">
            <div class="registerForm">
                <div class="registerTitle">
                    <div><label for="username">ID</label></div>
                    <div><label for="name">NAME</label></div>
                    <div><label for="password">PW</label></div>
                    <div><label>EMAIL</label></div>
                    <div><label for="phoneNumber">PHONE</label></div>
                    <div><label for="kakaoAddress">ADDRESS</label></div>
                </div>
                <div class="registerInfo">
                    <div>
                        <input type="text" name="username" class="form-control" id="username"
                               placeholder="영문과 숫자를 조합해 6~10글자" maxlength="10">
                        <div id="checkIdResult" style="font-size: 0.8em; display: none;"></div>
                    </div>
                    <div>
                        <div>
                            <input type="text" name="name" id="name" placeholder="이름 입력" required>
                            <div id="checkNameResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </div>
                    <div>
                        <input type="password" name="password" id="password" placeholder="영문, 숫자, 영문자 포함 8~12글자"  maxlength="12">
                         <div id="checkPwResult" style="font-size: 0.8em; display: none;"></div>
                    </div>
                    <div>
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
                    </div>
                    <div>
                        <div>
                            <input name="phoneNumber" id="phoneNumber" placeholder="- 빼고 입력해주세요"  maxlength="11" required>
                            <div id="checkPhoneResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </div>
                    <div>
                        <div id="addressField">
                            <input type="text" name="homeAddress" id="kakaoAddress" readonly>
                            <input type="button" value="주소 검색" onclick="findAddr();">
                            <div id="checkAddressResult" style="font-size: 0.8em; display: none;"></div>
                        </div>
                    </div>
                    <div class="registerBtn">
                        <button type="submit">회원가입</button>
                        <button type="reset">초기화</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>

<script>
  // 전체 필드 유효성 검사 통과 확인-1
  let validationResults = {
      username: false,
      password: false,
      name: false,
      phoneNumber: false,
      email: false
  }
  // 유효성 검사
  const validateInput = (input, regex, errorMsg, resultElement, fieldName) => {
      const value = input.val().trim();
      if(!value) {
          resultElement.show().css("color", "red").text('필수 입력 값 입니다.');
          validationResults[fieldName] = false;
          return false;
      } else if (!regex.test(value)) {
          resultElement.show().css("color", "red").text(errorMsg);
          validationResults[fieldName] = false;
          return false;
      } else {
          resultElement.show().css("color", "green").text('유효한 값 입니다.');
          validationResults[fieldName] = true;
          return true;
      }
  }

  $(document).ready(() => {
      const $enrollForm = $("#enrollForm");
      // 아이디 유효성 검사 및 중복 체크
      $("#username").on('blur keyup', function () {
          const idValidOk = validateInput($(this), /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]{5,10}$/,
          '아이디는 영문과 숫자를 포함해 6~10자 입니다.', $("#checkIdResult"));
          if(idValidOk) {
              checkIdDuplication($(this).val());
          }
      });
      // 비밀번호 유효성 검사
      $("#password").on('input', function () {
          validateInput($(this), /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$!%])[A-Za-z\d@#$!%]{8,12}$/,
          '비밀번호는 영문과 숫자, 특수기호를 포함해 8~12자 입니다.', $("#checkPwResult"));
      });
      // 이름 유효성 검사
      $("#name").on('input', function () {
          validateInput($(this), /^[a-zA-Z가-힣]+$/,
          '이름을 입력해주세요', $("#checkNameResult"));
      });
      // 전화번호 유효성 검사
      $("#phoneNumber").on('input', function () {
          validateInput($(this), /^[0-9]{11}$/,
          '숫자만 입력해주세요. 전화번호는 11자리 입니다.', $("#checkPhoneResult"));
      });
  })

    function checkIdDuplication(id) {
      $.ajax({
          url: "idCheck",
          data: { id: id },
          success: function(result) {
              const $checkIdResult = $("checkIdResult");
              if(result === "true") {
                  $checkIdResult.show().css("color", "red").text("이미 사용 중인 아이디 입니다.")
              } else if (result === "false") {
                  $checkIdResult.show().css("color", "green").text("사용 가능한 아이디 입니다.");
              } else {
                  $checkIdResult.show().css("color", "red").text("아이디 중복 체크 오류 발생");
              }
          },
          error: function () {
              console.log("아이디 중복 체크 ajax 통신 실패");
          }
      });
    }
    // 모든 필드 유효성 검사 통과 확인-2
    $("#enrollForm").submit(function (event) {
        const allValidOk = Object.values(validationResults).every(result => result);
        if(!allValidOk) {
            event.preventDefault();
            alert("모든 필드를 정확히 입력해주세요.");
            return false;
        }
  })

    // 카카오 주소
     function findAddr() {
            new daum.Postcode({
                oncomplete: function (data) {
                    $("#kakaoAddress").val(data.address);
                }
            }).open();
        }

    // 이메일 주소 DB에 저장
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
        const emailOption = $("#emailOption").val();
        if (emailOption === "input") {
            $("#emailAddress").val("").attr("disabled", false);
        } else {
            $("#emailAddress").val(emailOption.replace("@", "")).attr("disabled", true);
        }
    }

</script>

<jsp:include page="../layouts/footer.jsp"/>