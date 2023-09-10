// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery_ujs"
import "popper"
import "bootstrap"
// import "./add_jquery"

$(document).on('ajax:success', '.statusbtn', function (event,data, status) {
    console.log("Hello Running")
    alert("Hello Pankaj")
    var message = event.detail[0];
    console.log(message)
    var button = $(this);
    button.text(message);
});


$(document).on('ajax:error', '.statusbtn', function (event,data, status,xhr) {
    console.log("Ajax not success")
    console.log(status)
    console.log(data)
    console.log(event)
    console.log(xhr)
    // var xhr = event.detail[2];

    // Handle the error case here, e.g. show an error message
    // console.error('AJAX request error:', xhr.status, xhr.statusText);
});


// $(document).on('ajax:success', '#first', function (event) {
//     var data = event.detail[0];
//     alert("task done")
//     console.log(data)
//     if (data.approved) {
//         $('.statusbtn').text('Disapprove');
//     } else {
//         $('.statusbtn').text('Approve');
//     }
// });
// app/assets/javascripts/buses.js

// $(document).on('ajax:success', '#first, #second', function (event) {
//     var message = event.detail[0].message;
//     var button  = $(this);
//     alert("this code is working")

//     if(data.approved){
//         button.text("Disapprove")
//     }
//     else{
//         button.text("Approve")
//     }
//     // Update the status of the bus listing
//     // var busListing = $(this).closest('.bus-listing');
//     // busListing.find('p').text('Status: ' + (data.approved ? 'Approved' : 'Not Approved'));
// });
