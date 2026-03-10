<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Division;

class division_seed extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
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
    }
}
