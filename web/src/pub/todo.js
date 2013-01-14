$(function () {
    $('#new-todo').submit(function (event) {
        event.preventDefault();
        var input = $("#new-todo input");
        var todoText = input.val();
        if (todoText) {
            $.ajax({
                type: 'POST',
                url:  "/todos",
                data: {todo: todoText}
            });
        }
    });
});