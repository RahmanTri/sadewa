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
        $faceData = [
            0.0213,
            -0.1045,
            0.3321,
            -0.2210,
            0.0876,
            -0.1452,
            0.0567,
            0.2981,
            -0.0724,
            0.1890,
            0.1123,
            -0.0541,
            0.2765,
            -0.1987,
            0.0432,
            0.1345,
            -0.0891,
            0.2104,
            -0.1456,
            -0.0789,
            0.3120,
            -0.0567,
            0.1345,
            -0.2011,
            0.0987,
            0.2450,
            -0.1765,
            0.0543,
            -0.2891,
            0.1024,
            0.1765,
            -0.0332,
            0.0891,
            0.2104,
            -0.1456,
            -0.0789,
            0.3120,
            -0.0567,
            0.1345,
            -0.2011,
            0.0987,
            0.2450,
            -0.1765,
            0.0543,
            -0.2891,
            0.1024,
            0.1765,
            -0.0332,
            0.0213,
            -0.1045,
            0.3321,
            -0.2210,
            0.0876,
            -0.1452,
            0.0567,
            0.2981,
            -0.0724,
            0.1890,
            0.1123,
            -0.0541,
            0.2765,
            -0.1987,
            0.0432,
            0.1345,
            -0.0891,
            0.2104,
            -0.1456,
            -0.0789,
            0.3120,
            -0.0567,
            0.1345,
            -0.2011,
            0.0987,
            0.2450,
            -0.1765,
            0.0543,
            -0.2891,
            0.1024,
            0.1765,
            -0.0332,
            0.0891,
            0.2104,
            -0.1456,
            -0.0789,
            0.3120,
            -0.0567,
            0.1345,
            -0.2011,
            0.0987,
            0.2450,
            -0.1765,
            0.0543,
            -0.2891,
            0.1024,
            0.1765,
            -0.0332,
            0.0213,
            -0.1045,
            0.3321,
            -0.2210,
            0.0876,
            -0.1452,
            0.0567,
            0.2981,
            -0.0724,
            0.1890,
            0.1123,
            -0.0541,
            0.2765,
            -0.1987,
            0.0432,
            0.1345
        ];
        $jsonEncode = json_encode($faceData);

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
            "face_data" => $jsonEncode,
        ];
    }
}
