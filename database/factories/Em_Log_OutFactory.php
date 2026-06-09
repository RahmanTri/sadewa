<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Em_log_out;

class Em_Log_OutFactory extends Factory
{

    public function definition(): array
    {

        static $numbers;

        if ($numbers == null) {
            $numbers = range(1, 50);
            shuffle($numbers);
        }

        return [
            "employee_id" => array_pop($numbers),
            "logout_time" => $this->faker->randomElement(["16:00:00", "15:00:00", "18:45:00", "17:15:00"]),
            "status" => $this->faker->randomElement(["on_time", "early", "absent"])
        ];
    }
}
