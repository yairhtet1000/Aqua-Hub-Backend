<?php

namespace Database\Factories;

use App\Models\Category;
use App\Models\Post;
use App\Models\Tank;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class PostFactory extends Factory
{
    protected $model = Post::class;

    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'category_id' => Category::factory(),
            'tank_id' => Tank::factory(),
            'title' => fake()->sentence(6),
            'content' => fake()->paragraphs(3, true),
            'status' => fake()->randomElement(['published', 'draft', 'archived']),
        ];
    }

    /**
     * Create a post without an associated tank.
     */
    public function withoutTank(): static
    {
        return $this->state(fn(array $attributes) => [
            'tank_id' => null,
        ]);
    }

    /**
     * Create a published post.
     */
    public function published(): static
    {
        return $this->state(fn(array $attributes) => [
            'status' => 'published',
        ]);
    }
}
