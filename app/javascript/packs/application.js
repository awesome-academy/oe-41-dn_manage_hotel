//= require jquery
//= require jquery_ujs
import "../stylesheets/application.scss"
import "popper.js"
import "jquery"
require("packs/jquery.ajaxchimp.min")
require("packs/jquery.counterup")
require("packs/jquery.form")
require("packs/jquery.magnifig-popup.min")
require("packs/jquery.slicknav.min")
require("packs/jquery.validate.min")
require("packs/jquery.scrollUp.min")
require("@rails/ujs").start()
require("bootstrap")
require("jquery")
require("packs/main")
document.addEventListener("turbolinks:load", function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    })
})



import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
// application.js
toastr.options = {
  // thay đổi nội dung hiển thị trên nút close, vd như "Đóng"
  "closeButton": false,

  // thay đổi vị trí của notification
  "positionClass": "toast-top-right",

  // Các thông báo có hiển thị cùng 1 lúc hay khi cái sau xuất hiện sẽ ẩn cái trước
  "preventDuplicates": false,

  // action khi click vào thông báo
  "onclick": null,

  // thời gian, hiệu ứng hiển thị và ẩn
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}
