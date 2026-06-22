<?php

namespace Database\Factories;
use Illuminate\Database\Eloquent\Factories\Factory;

class PointFactory extends Factory
{
    /**
     * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Point>
     */
    public function definition(): array
    {

        static $numbers;

        if ($numbers == null) {
            $numbers = range(2, 100);
            shuffle($numbers);
        }

        return [
            "employee_id" => array_pop($numbers),
            "point_value" => $this->faker->numberBetween(20, 100),
            "positive_streak" => 0,
            "negative_streak" => 0,
        ];
    }
}
