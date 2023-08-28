// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
<<<<<<< Updated upstream
=======
import "./add_jquery"
// function myfunc(){
// $(document).ready(function(){
//     $(".apb").click(function(){
//         $.ajax({
//             url: change_status_path,
//             type: "GET"
//         })
//     })
// })
// }
$(".statusbtn").on("click", function(){
    alert("button clicked");
})
// window.onload = myfunc;
>>>>>>> Stashed changes
