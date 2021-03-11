require("@rails/ujs").start()
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "bootstrap"
import "jquery"
import "popper.js"
import "packs/main.js"
import "../stylesheets/application.scss";


document.addEventListener("turbolinks:load", function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    })
})


Rails.start()
Turbolinks.start()
ActiveStorage.start()



