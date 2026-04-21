<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

class UserFactory extends Factory
{
    public function definition(): array
    {
        return [
            "username" => $this->faker->unique()->userName(),
            "role" => "employee",
            "email" => $this->faker->unique()->email(),
            "password" => Hash::make($this->faker->password()),
        ];
    }
}
