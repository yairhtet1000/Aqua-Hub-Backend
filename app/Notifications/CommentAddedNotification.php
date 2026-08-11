<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\DatabaseMessage;

class CommentAddedNotification extends Notification
{
    use Queueable;

    public $post;
    public $commenter;

    public function __construct($post, $commenter)
    {
        $this->post = $post;
        $this->commenter = $commenter;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable): DatabaseMessage
    {
        return new DatabaseMessage([
            'message' => "{$this->commenter->name} commented on your post \"{$this->post->title}\".",
            'post_id' => $this->post->id,
            'sender_id' => $this->commenter->id,
            'sender_name' => $this->commenter->name,
            'sender_avatar' => $this->commenter->avatar,
            'type' => 'comment_added',
        ]);
    }
}
