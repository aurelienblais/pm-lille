$(document).on('turbolinks:load', () => {
    if (typeof HOLIDAYS !== 'undefined') {
        HOLIDAYS.forEach((holiday) => {
            $element = $('[data-date="' + holiday.date + '"]')
            $element
                .css('background', '#123456')
                .attr('title', holiday.name);
        });
    }
});