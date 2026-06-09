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
            $numbers = range(2, 51);
            shuffle($numbers);
        }

        return [
            "month" => $this->faker->randomElement(["Maret", "April", "Mei"]),
            "employee_id" => array_pop($numbers),
            "point_value" => $this->faker->numberBetween(20, 200),
            "source" => $this->faker->randomElement(["log_in", "log_out"]),
            "positive_streak" => 0,
            "negative_streak" => 0,
        ];
    }
}
