// $(document).on("ajax:complete", function (event, data, status, xhr) {
//     // response will come underneath of ‘data’ variable
//     var response = data.message;
//     alert(response)
// });

// $(document).on('ajax:success', '.statusbtn', function (event) {
//     var data = event.detail[0];
//     if (data.approved) {
//         $('.statusbtn').text('Disapprove');
//     } else {
//         $('.statusbtn').text('Approve');
//     }
// });

$(".statusbtn").click(function(){
    alert("Clicked")
})