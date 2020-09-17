// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

const jQuery = require("jquery");

global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

require("bootstrap");
require("admin-lte");
require('moment');

require('bootstrap-colorpicker');
require('bootstrap-daterangepicker');

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require('dashboard/main');

$(document).on('turbolinks:load', () => {
    $('[data-toggle="tooltip"]').tooltip();
    $('input[name="dates"]').daterangepicker({
        maxSpan: {
            days: 31
        },
        locale: {
            format: 'DD-MM-YYYY',
            separator: " - ",
            applyLabel: "Valider",
            cancelLabel: "Annuler",
            daysOfWeek: [
                'Lu',
                'Ma',
                'Me',
                'Je',
                'Ve',
                'Sa',
                'Di'
            ],
            monthNames: [
                'Janvier',
                'Février',
                'Mars',
                'Avril',
                'Mai',
                'Juin',
                'Juillet',
                'Août',
                'Septembre',
                'Octobre',
                'Novembre',
                'Décembre'
            ],
        }
    });
});
