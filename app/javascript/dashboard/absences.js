$(document).on('turbolinks:load', () => {
    if (typeof ABSENCES !== 'undefined') {
        ABSENCES.forEach((absence) => {
            absence = JSON.parse(absence);
            $element = $('[data-agent="' + absence.agent_id + '"][data-date="' + absence.date + '"]')
            $element
                .css('background', absence.absence_type.color)
                .attr('title', absence.absence_type.name);
            $element.find('.day-texture').attr('class', 'day-texture ' + absence.absence_type.texture);
        });

        total = ABSENCES.reduce(function (rv, x) {
            x = JSON.parse(x);
            rv[x.absence_type.id] = 1 + (rv[x.absence_type.id] || 0);
            return rv;
        }, {});
        Object.keys(total).forEach((eventId) => {
            $("[data-event-type='" + eventId + "']").text(total[eventId]);
        });
    }

    if (typeof TEAM_ABSENCES !== 'undefined') {
        TEAM_ABSENCES.forEach((absence) => {
            absence = JSON.parse(absence);
            $element = $('[data-agent="' + absence.agent_id + '"][data-date="' + absence.date + '"]')
            $element
              .css('background', absence.absence_type.color)
              .attr('title', absence.absence_type.name);
            $element.find('.day-texture').attr('class', 'day-texture ' + absence.absence_type.texture);
        });
    }
});