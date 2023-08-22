import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()



document.addEventListener("turbolinks:load", function() {
    $('.post.unread').on('click', function() {
        var postId = $(this).data('post-id');

        $.ajax({
            type: 'POST',
            url: '/mark_post_as_read',
            data: { post_id: postId },
            success: function(data) {
                $('.post[data-post-id="' + postId + '"]').removeClass('unread');
            }
        });
    });
});
