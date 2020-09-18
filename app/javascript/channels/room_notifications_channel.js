import consumer from "./consumer"

$(() => {
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
                if (currentRoom && currentRoom == data.room_id)
                    return;
                if (userId !== data.user_id) {
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
});
