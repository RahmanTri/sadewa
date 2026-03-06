<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Division;
use App\Models\User;
use App\Models\Employee;
use Illuminate\Support\Facades\Hash;

class division_seed extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Division::create([
            "division_name" => "Mobile Production",
            "checkin_time" => "09:00:00",
            "checkout_time" => "17:00:00",
            "tolerance" => "30"
        ]);

        // User::create([
        //     "role" => "employee",
        //     "email" => "employee01@gmail.com",
        //     "password" => Hash::make("employee123")
        // ]);

        Employee::create([
            "company_id" => "MP01",
            "user_id" => 1,
            "name" => "David",
            "division_id" => 1,
            "phone_number" => "089635412765",
            "face_data" => "265868 - 6969696 - 6537"
        ]);
    }
}
