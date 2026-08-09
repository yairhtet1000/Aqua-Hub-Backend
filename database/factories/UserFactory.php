<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\Role;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class UserFactory extends Factory
{
    protected $model = User::class;

    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'email' => fake()->unique()->safeEmail(),
            'email_verified_at' => now(),
            'password' => '$2y$12$1LAmtsbYmkXgQcD0.XYCA./MHOMRXoFKiaO1tX1.9PmzpSkOysUqq', // default 'password'
            'phone' => fake()->phoneNumber(),
            'avatar' => fake()->imageUrl(),
            'bio' => fake()->sentence(),
            'remember_token' => Str::random(10),
            // Default to an existing Role ID or create a new Role if none exists
            'role_id' => Role::inRandomOrder()->first()?->id ?? Role::factory(),
        ];
    }
}