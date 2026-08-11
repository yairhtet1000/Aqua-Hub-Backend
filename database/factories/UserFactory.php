<?php

namespace Database\Factories;

use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class UserFactory extends Factory
{
    protected $model = User::class;

    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'email' => fake()->unique()->safeEmail(),
            'password' => bcrypt('password'),
            'phone' => fake()->phoneNumber(),
            'avatar' => fake()->imageUrl(200, 200, 'people', true),
            'bio' => fake()->sentence(8),
            'role_id' => Role::inRandomOrder()->first()?->id ?? 3,
        ];
    }

    /**
     * Indicate that the model has a verified email.
     */
    public function verified(): static
    {
        return $this->state(fn (array $attributes) => [
            'email_verified_at' => now(),
        ]);
    }

    /**
     * Create a Member user (role_id = 3).
     */
    public function member(): static
    {
        return $this->state(fn (array $attributes) => [
            'role_id' => Role::where('name', 'Member')->first()?->id ?? 3,
        ]);
    }

    /**
     * Create an Admin user (role_id = 1).
     */
    public function admin(): static
    {
        return $this->state(fn (array $attributes) => [
            'role_id' => Role::where('name', 'Admin')->first()?->id ?? 1,
        ]);
    }
}
