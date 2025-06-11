import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

import "@fullcalendar/core/main.css";
import "@fullcalendar/daygrid/main.css";

import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import Raty from "raty.js";
window.raty = function (elem, opt) {
  let raty = new Raty(elem, opt);
  raty.init();
  return raty;
};

document.addEventListener("turbolinks:load", function () {
  const calendarEl = document.getElementById("calendar");
  if (!calendarEl) return;

  const calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, interactionPlugin],
    initialView: "dayGridMonth",
    events: "/reading_logs.json",
    eventClick: function (info) {
      window.location.href = info.event.url;
      info.jsEvent.preventDefault();
    },
  });

  calendar.render();
});
