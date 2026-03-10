<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Employee>
 */
class employeeFactory extends Factory
{

    public function definition(): array
    {
        static $numbers;

        if ($numbers == null) {
            $numbers = range(3, 52);
            shuffle($numbers);
        }

        static $cid;
        if ($cid == null) {
            $cid = range(00000, 99999);
            shuffle($cid);
        }

        return [
            "company_id" => 'KKS' . array_pop($cid),
            "user_id" => array_pop($numbers),
            "name" => $this->faker->name(),
            "division_id" => $this->faker->numberBetween(1, 7),
            "phone_number" => '08' . $this->faker->numberBetween(1111111111, 9999999999),
            "face_data" => $this->faker->randomNumber(),
        ];
    }
}
