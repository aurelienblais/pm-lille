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

const moment = require('moment');
global.moment = moment;
window.moment = moment;

require("bootstrap");
require("admin-lte");
require('moment');
import Chart from 'chart.js/auto';
global.Chart = Chart;
window.Chart = Chart;
require('select2');


require('bootstrap-colorpicker');
require('bootstrap-daterangepicker');
require('bootstrap-datepicker');

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require('dashboard/main');

$(document).on('turbolinks:load', () => {
    $('.select2').select2();
    $('.select2-multiple').select2({ multiple: true })
    $('[data-toggle="tooltip"]').tooltip();
    $(".year-picker").datepicker({
        format: "yyyy",
        viewMode: "years",
        minViewMode: "years"
    });
    $('input[name="dates"]').daterangepicker({
        maxSpan: {
            days: 31
        },
        ranges: {
            'Hier': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Aujourd\'hui': [moment(), moment()],
            'Demain': [moment().add(1, 'days'), moment().add(1, 'days')],
            'Mois dernier': [moment().startOf('month').subtract(1, 'months'), moment().endOf('month').subtract(1, 'months')],
            'Mois courant': [moment().startOf('month'), moment().endOf('month')],
            'Mois prochain': [moment().startOf('month').add(1, 'months'), moment().endOf('month').add(1, 'months')],
        },
        "alwaysShowCalendars": true,
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

$(document).on({
    mouseenter: (e) => {
        const idx = parseInt($(e.target).closest('td').index()) + 1;
        $(e.target).closest('table').find('td:nth-child(' + idx +')').addClass('highlight');
    },
    mouseleave: (e) => {
        const idx = parseInt($(e.target).closest('td').index()) + 1;
        $(e.target).closest('table').find('td:nth-child(' + idx +')').removeClass('highlight');
    }
}, ".table-highlight td");