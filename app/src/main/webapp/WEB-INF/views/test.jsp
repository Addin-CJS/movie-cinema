<jsp:include page="layouts/header.jsp"/>

<section>
    <div class="test">
        <div>
            <input id="inputText" type="text" class="text">
            <input type="submit" value="input" onclick="test(this)">
        </div>
        <div class="reply">
        </div>
    </div>
</section>

<script>

    $(document).ready(function (){

    });

    function test(target) {
        var inputVal = $("#inputText").val();

        $(".reply").append($("<span class='replyNumber'></span>").text("이거"));
        $(".reply").append($("<span class='replyContent'></span>").text(inputVal + "\n"));

        $.ajax({
            url: "test",
            type: "post",
            data : {
               "id":$("#inputText").val()
            },
            success: function (result) {
            },
            error: function() {
            }
        });
    }

</script>

<jsp:include page="layouts/footer.jsp"/>