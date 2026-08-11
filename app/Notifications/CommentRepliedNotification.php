<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\DatabaseMessage;

class CommentRepliedNotification extends Notification
{
    use Queueable;

    public $post;
    public $replier;
    public $parentComment;

    public function __construct($post, $replier, $parentComment)
    {
        $this->post = $post;
        $this->replier = $replier;
        $this->parentComment = $parentComment;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable): DatabaseMessage
    {
        return new DatabaseMessage([
            'message' => "{$this->replier->name} replied to your comment on \"{$this->post->title}\".",
            'post_id' => $this->post->id,
            'sender_id' => $this->replier->id,
            'sender_name' => $this->replier->name,
            'sender_avatar' => $this->replier->avatar,
            'type' => 'comment_replied',
        ]);
    }
}
