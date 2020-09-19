selectedDays = {};

$(document).on('click', '.day:not(.disabled)', (e) => {
    const $element = $(e.target).closest('.day');

    $element.toggleClass('active');

    const agentId = $element.data('agent')
    const date = $element.data('date')

    if ($element.hasClass('active')) {
        if (selectedDays[agentId] === undefined) {
            selectedDays[agentId] = [];
        }
        selectedDays[agentId].push(date);
    } else {
        if (selectedDays[agentId].length === 1) {
            delete selectedDays[agentId];
        } else {
            selectedDays[agentId] = selectedDays[agentId].splice(selectedDays[agentId].indexOf(date), 1);
        }
    }
    onSelectedDaysChange();
});

$(document).on('click', '[data-toggle="collapse"]', (e) => {
    $(e.target).parent().find('i').toggleClass('fa-angle-up fa-angle-down');
});

$(document).on('click', '.event-container, .color-display, .event-name', (e) => {
    const $element = $(e.target).closest('.event-container');
    const eventId = $element.data('event');
    const eventName = $element.data('name');
    const color = $element.data('color');
    const texture = $element.data('texture');
    setEvent(eventId, eventName, color, texture);
});

onSelectedDaysChange = () => {
    if (Object.keys(selectedDays).length === 0) {
        $('.event-picker').hide();
    } else {
        $('.event-picker').show();
    }
}

setEvent = (eventId, eventName, color, texture) => {
    Object.keys(selectedDays).forEach((agentId) => {
        selectedDays[agentId].forEach((date) => {
            $.ajax({
                type: 'POST',
                url: '/absences',
                data: {
                    absence: {
                        agent_id: agentId,
                        absence_type_id: eventId,
                        date: date
                    }
                },
                success: () => {
                    $element = $('[data-agent="' + agentId + '"][data-date="' + date + '"]');
                    $element
                        .css('background', color)
                        .removeClass('active');
                    $element.find('.day-texture').attr('class', 'day-texture ' + texture);
                    $('.refresh').show();
                }
            })
        });
        delete selectedDays[agentId];
    });
    onSelectedDaysChange();
}

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

    $('.dashboard-date').on('apply.daterangepicker changeDate', function (ev, picker) {
        $('.dashboard-form').submit();
    });

    $('.dashboard-team').on('change', function (ev, picker) {
        $('.dashboard-form').submit();
    });
});