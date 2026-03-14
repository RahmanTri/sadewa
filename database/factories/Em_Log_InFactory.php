<?php

namespace Database\Factories;
use Illuminate\Database\Eloquent\Factories\Factory;

class Em_Log_inFactory extends Factory
{
    /**
     * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Em_log_in>
     */
    public function definition(): array
    {

        static $numbers;

        if ($numbers == null) {
            $numbers = range(1, 50);
            shuffle($numbers);
        }

        return [
            "employee_id" => array_pop($numbers),
            "login_time" => $this->faker->randomElement(["09:00:00", "08:00:00", "07:45:00", "07:15:00"]),
            "status" => $this->faker->randomElement(["late", "on_time"]),
            "created_at" => $this->faker->dateTimeBetween('-2 month', 'now')
        ];
    }
}
