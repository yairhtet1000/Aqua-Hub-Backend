<?php

namespace Database\Factories;

use App\Models\Comment;
use App\Models\Post;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class CommentFactory extends Factory
{
    protected $model = Comment::class;

    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'post_id' => Post::factory(),
            'parent_comment_id' => null,
            'content' => fake()->paragraph(),
        ];
    }

    /**
     * Create a reply to an existing comment.
     */
    public function reply(int $parentCommentId): static
    {
        return $this->state(fn(array $attributes) => [
            'parent_comment_id' => $parentCommentId,
        ]);
    }
}
