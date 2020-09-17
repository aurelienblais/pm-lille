selectedDays = {};

$(document).on('click', '.day', (e) => {
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
    setEvent(eventId, eventName, color);
});

onSelectedDaysChange = () => {
    if (Object.keys(selectedDays).length === 0) {
        $('.event-picker').hide();
    } else {
        $('.event-picker').show();
    }
}

setEvent = (eventId, eventName, color) => {
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
                    $('[data-agent="' + agentId + '"][data-date="' + date + '"]')
                        .css('background', color)
                        .removeClass('active');
                }
            })
        });
        delete selectedDays[agentId];
    });
    onSelectedDaysChange();
}

$(document).on('turbolinks:load', () => {
   if (ABSENCES) {
       ABSENCES.forEach((absence) => {
          absence = JSON.parse(absence);
           $('[data-agent="' + absence.agent_id + '"][data-date="' + absence.date + '"]')
               .css('background', absence.absence_type.color)
               .attr('title', absence.absence_type.name);
       });
   }

    $('.dashboard-date').on('apply.daterangepicker', function(ev, picker) {
        $('.dashboard-form').submit();
    });
});