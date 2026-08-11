<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\DatabaseMessage;

class PostLikedNotification extends Notification
{
    use Queueable;

    public $post;
    public $liker;

    public function __construct($post, $liker)
    {
        $this->post = $post;
        $this->liker = $liker;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable): DatabaseMessage
    {
        return new DatabaseMessage([
            'message' => "{$this->liker->name} liked your post \"{$this->post->title}\".",
            'post_id' => $this->post->id,
            'sender_id' => $this->liker->id,
            'sender_name' => $this->liker->name,
            'sender_avatar' => $this->liker->avatar,
            'type' => 'post_liked',
        ]);
    }
}
