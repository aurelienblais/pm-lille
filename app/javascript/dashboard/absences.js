$(document).on('turbolinks:load', () => {
    if (typeof RECURRING_ABSENCES !== 'undefined') {
        RECURRING_ABSENCES.forEach((absence) => {
            absence = JSON.parse(absence);
            $element = $('[data-agent="' + absence.agent_id + '"][data-date="' + absence.date + '"]')
            $element
              .css('background', absence.absence_type.color)
              .attr('title', absence.absence_type.name);
            $element.find('.day-texture').attr('class', 'day-texture ' + absence.absence_type.texture);
        });
    }

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

    if (typeof RECURRING_ABSENCES !== 'undefined' && typeof ABSENCES !== 'undefined')
    {
        absences = []
        total = ABSENCES.concat(RECURRING_ABSENCES).reduce(function (rv, x) {
            x = JSON.parse(x);
            if (!x.recurring)
                absences.push(x.date);
            rv[x.absence_type.id] = 1 + (rv[x.absence_type.id] || 0);
            return rv;
        }, {});

        RECURRING_ABSENCES.forEach(x => {
            x = JSON.parse(x);
            console.log(absences);
            console.log(x.date);
           if (absences.includes(x.date))
               total[x.absence_type.id] = total[x.absence_type.id] - 1;
        });

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