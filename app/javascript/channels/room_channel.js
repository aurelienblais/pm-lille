import consumer from "./consumer"

$(document).on('turbolinks:load', () => {
    $('[data-channel-subscribe="room"]').each(function (index, element) {
        const $element = $(element), room_id = $element.data('room-id')
        const messageTemplate = $('[data-role="message-template"]');

        $element.animate({scrollTop: $element.prop("scrollHeight")}, 1000)

        consumer.subscriptions.create(
            {
                channel: "RoomChannel",
                room: room_id
            },
            {
                received: function (data) {
                    var content = messageTemplate.clone(true, true);

                    content.find('.direct-chat-img').attr('src', data.user_avatar_url);
                    content.find('.direct-chat-name').text(data.user_name);
                    content.find('.direct-chat-text').text(data.message);
                    content.find('.direct-chat-timestamp').text(data.parsed_date);
                    content.removeClass('d-none');
                    if (userId !== data.user_id)
                        content.addClass('right');
                    $element.append(content);
                    $element.animate({scrollTop: $element.prop("scrollHeight")}, 1000);
                }
            }
        );
    });
});