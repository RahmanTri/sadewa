<?php

namespace Database\Seeders;

use App\Models\Point;
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
        // $faceData = [
        //     0.0213,
        //     -0.1045,
        //     0.3321,
        //     -0.2210,
        //     0.0876,
        //     -0.1452,
        //     0.0567,
        //     0.2981,
        //     -0.0724,
        //     0.1890,
        //     0.1123,
        //     -0.0541,
        //     0.2765,
        //     -0.1987,
        //     0.0432,
        //     0.1345,
        //     -0.0891,
        //     0.2104,
        //     -0.1456,
        //     -0.0789,
        //     0.3120,
        //     -0.0567,
        //     0.1345,
        //     -0.2011,
        //     0.0987,
        //     0.2450,
        //     -0.1765,
        //     0.0543,
        //     -0.2891,
        //     0.1024,
        //     0.1765,
        //     -0.0332,
        //     0.0891,
        //     0.2104,
        //     -0.1456,
        //     -0.0789,
        //     0.3120,
        //     -0.0567,
        //     0.1345,
        //     -0.2011,
        //     0.0987,
        //     0.2450,
        //     -0.1765,
        //     0.0543,
        //     -0.2891,
        //     0.1024,
        //     0.1765,
        //     -0.0332,
        //     0.0213,
        //     -0.1045,
        //     0.3321,
        //     -0.2210,
        //     0.0876,
        //     -0.1452,
        //     0.0567,
        //     0.2981,
        //     -0.0724,
        //     0.1890,
        //     0.1123,
        //     -0.0541,
        //     0.2765,
        //     -0.1987,
        //     0.0432,
        //     0.1345,
        //     -0.0891,
        //     0.2104,
        //     -0.1456,
        //     -0.0789,
        //     0.3120,
        //     -0.0567,
        //     0.1345,
        //     -0.2011,
        //     0.0987,
        //     0.2450,
        //     -0.1765,
        //     0.0543,
        //     -0.2891,
        //     0.1024,
        //     0.1765,
        //     -0.0332,
        //     0.0891,
        //     0.2104,
        //     -0.1456,
        //     -0.0789,
        //     0.3120,
        //     -0.0567,
        //     0.1345,
        //     -0.2011,
        //     0.0987,
        //     0.2450,
        //     -0.1765,
        //     0.0543,
        //     -0.2891,
        //     0.1024,
        //     0.1765,
        //     -0.0332,
        //     0.0213,
        //     -0.1045,
        //     0.3321,
        //     -0.2210,
        //     0.0876,
        //     -0.1452,
        //     0.0567,
        //     0.2981,
        //     -0.0724,
        //     0.1890,
        //     0.1123,
        //     -0.0541,
        //     0.2765,
        //     -0.1987,
        //     0.0432,
        //     0.1345
        // ];
        // $jsonEncode = json_encode($faceData);


        // User::create([
        //     "role" => "employee",
        //     "username" => "employee01",
        //     "email" => "employee01@gmail.com",
        //     "password" => Hash::make("employee123")
        // ]);

        // User::create([
        //     "role" => "admin",
        //     "username" => "admin01",
        //     "email" => "admin01@gmail.com",
        //     "password" => Hash::make("admin12345")
        // ]);

        // User::factory()->count(50)->create();

        // Division::create([
        //     "division_name" => "Mobile Production",
        //     "checkin_time" => "09:00:00",
        //     "checkout_time" => "17:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => "30"
        // ]);

        // Division::create([
        //     "division_name" => "WEB Devolopment",
        //     "checkin_time" => "08:00:00",
        //     "checkout_time" => "16:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => 45
        // ]);

        // Division::create([
        //     "division_name" => "Mobile Devolopment",
        //     "checkin_time" => "08:00:00",
        //     "checkout_time" => "16:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => 45
        // ]);

        // Division::create([
        //     "division_name" => "Network",
        //     "checkin_time" => "08:00:00",
        //     "checkout_time" => "16:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => 45
        // ]);

        // Division::create([
        //     "division_name" => "Security Shift-1",
        //     "checkin_time" => "07:00:00",
        //     "checkout_time" => "16:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => 45
        // ]);

        // Division::create([
        //     "division_name" => "Security Shift-2",
        //     "checkin_time" => "16:00:00",
        //     "checkout_time" => "23:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => 45
        // ]);

        // Division::create([
        //     "division_name" => "Security Shift-3",
        //     "checkin_time" => "23:00:00",
        //     "checkout_time" => "07:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => 45
        // ]);

        // Division::create([
        //     "division_name" => "Kebersihan",
        //     "checkin_time" => "07:00:00",
        //     "checkout_time" => "18:00:00",
        //     "latitude" => -6.200000,
        //     "longitude" => 106.800000,
        //     "tolerance" => 45
        // ]);

        // Employee::create([
        //     "company_id" => 'KSS1001',
        //     "user_id" => 1,
        //     "name" => "David",
        //     "division_id" => 1,
        //     "phone_number" => "089635412765",
        //     "face_data" => $jsonEncode
        // ]);

        // Employee::factory()->count(50)->create();

        // Em_log_in::factory()->count(50)->create();

        // Em_log_out::factory()->count(50)->create();

        // Em_log_in::factory()->count(7)->create();

        Point::factory()->count(50)->create();

    }
}
