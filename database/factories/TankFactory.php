<?php

namespace Database\Factories;

use App\Models\Tank;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class TankFactory extends Factory
{
    protected $model = Tank::class;

    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'name' => fake()->words(2, true) . ' Tank',
            'volume_gallons' => fake()->randomFloat(2, 5, 120),
            'water_type' => fake()->randomElement(['freshwater', 'saltwater', 'brackish']),
            'aquascape_style' => fake()->optional()->randomElement(['Iwagumi', 'Dutch', 'Jungle', 'Reef']),
            'setup_date' => fake()->optional()->date(),
        ];
    }
}