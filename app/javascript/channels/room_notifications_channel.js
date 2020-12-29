import consumer from "./consumer"

$(document).on('turbolinks:load', () => {
    if (typeof userId !== 'undefined') {
        consumer.subscriptions.create(
            {
                channel: "RoomNotificationsChannel",
                room: userId
            }, {
                connected() {
                    // Called when the subscription is ready for use on the server
                },

                disconnected() {
                    // Called when the subscription has been terminated by the server
                },

                received(data) {
                    if (typeof currentRoom !== 'undefined' && currentRoom == data.room_id)
                        return;
                    if (userId !== data.user_id || data.user_id === null) {
                        $(document).Toasts('create', {
                            title: 'Nouveau message',
                            body: 'Nouveau message de ' + data.user_name + ' dans la salle ' + data.room_name,
                            subtitle: '<a href="' + data.room_path + '">Voir</a>',
                            image: data.user_gravatar_url,
                            class: 'bg-info'
                        });
                    }
                }
            });
    }
});
