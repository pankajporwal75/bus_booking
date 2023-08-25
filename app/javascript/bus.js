$(document).on("ajax:complete", function (event, data, status, xhr) {
    // response will come underneath of ‘data’ variable
    var response = data.message;
    alert(response)
});
