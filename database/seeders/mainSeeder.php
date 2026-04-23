<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Seeder;
use App\Models\Employee;
use App\Models\User;
use App\Models\Division;
use App\Models\Em_log_in;
use App\Models\Em_log_out;


class mainSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            "role" => "employee",
            "username" => "employee01",
            "email" => "employee01@gmail.com",
            "password" => Hash::make("employee123")
        ]);

        User::create([
            "role" => "admin",
            "username" => "admin01",
            "email" => "admin01@gmail.com",
            "password" => Hash::make("admin12345")
        ]);

        User::factory()->count(50)->create();

        Division::create([
            "division_name" => "Mobile Production",
            "checkin_time" => "09:00:00",
            "checkout_time" => "17:00:00",
            "tolerance" => "30"
        ]);

        Division::create([
            "division_name" => "WEB Devolopment",
            "checkin_time" => "08:00:00",
            "checkout_time" => "16:00:00",
            "tolerance" => 45
        ]);

        Division::create([
            "division_name" => "Mobile Devolopment",
            "checkin_time" => "08:00:00",
            "checkout_time" => "16:00:00",
            "tolerance" => 45
        ]);

        Division::create([
            "division_name" => "Network",
            "checkin_time" => "08:00:00",
            "checkout_time" => "16:00:00",
            "tolerance" => 45
        ]);

        Division::create([
            "division_name" => "Security Shift-1",
            "checkin_time" => "07:00:00",
            "checkout_time" => "16:00:00",
            "tolerance" => 45
        ]);

        Division::create([
            "division_name" => "Security Shift-2",
            "checkin_time" => "16:00:00",
            "checkout_time" => "23:00:00",
            "tolerance" => 45
        ]);

        Division::create([
            "division_name" => "Security Shift-3",
            "checkin_time" => "23:00:00",
            "checkout_time" => "07:00:00",
            "tolerance" => 45
        ]);

        Division::create([
            "division_name" => "Kebersihan",
            "checkin_time" => "07:00:00",
            "checkout_time" => "18:00:00",
            "tolerance" => 45
        ]);

        Employee::create([
            "company_id" => 'KSS1001',
            "user_id" => 1,
            "name" => "David",
            "division_id" => 1,
            "phone_number" => "089635412765",
            // "face_data" => "265868 - 6969696 - 6537"
        ]);

        Employee::factory()->count(50)->create();

        Em_log_in::factory()->count(50)->create();

        Em_log_out::factory()->count(50)->create();
    }
}
