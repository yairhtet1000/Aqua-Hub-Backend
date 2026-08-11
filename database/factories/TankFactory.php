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
        $waterType = fake()->randomElement(['freshwater', 'saltwater', 'brackish']);

        $temperature = match ($waterType) {
            'freshwater' => fake()->randomFloat(2, 68, 78),
            'saltwater' => fake()->randomFloat(2, 76, 82),
            'brackish' => fake()->randomFloat(2, 72, 80),
        };

        $phLevel = match ($waterType) {
            'freshwater' => fake()->randomFloat(2, 6.0, 7.5),
            'saltwater' => fake()->randomFloat(2, 7.8, 8.5),
            'brackish' => fake()->randomFloat(2, 7.0, 8.0),
        };

        return [
            'user_id' => User::factory(),
            'name' => fake()->words(2, true) . ' Tank',
            'volume_gallons' => fake()->randomFloat(2, 5, 120),
            'water_type' => $waterType,
            'temperature' => $temperature,
            'ph_level' => $phLevel,
            'aquascape_style' => fake()->optional()->randomElement(['Iwagumi', 'Dutch', 'Jungle', 'Reef', 'Planted']),
            'setup_date' => fake()->optional()->dateTimeBetween('-2 years', 'now'),
        ];
    }
}
