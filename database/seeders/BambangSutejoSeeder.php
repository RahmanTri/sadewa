<?php

namespace Database\Seeders;

use App\Models\Point;
use App\Models\point_log;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Employee;
use App\Models\Em_log_in;
use App\Models\Em_log_out;

class BambangSutejoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $employeeId = '52';
        //
        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:01:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(10),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:23:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(9),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:42:28',
            'status' => 'late',
            'created_at' => now()->subDays(8),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:14:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(7),
        ]);


        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:01:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(6),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:23:28',
            'status' => 'late',
            'created_at' => now()->subDays(5),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:12:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(4),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:01:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(3),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:03:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(2),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:01:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(1),
        ]);

        Em_log_in::create([
            'employee_id' => $employeeId,
            'login_time' => '09:08:28',
            'status' => 'on_time',
            'created_at' => now(),
        ]);
        
        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:01:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(10),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:23:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(9),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:42:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(8),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '16:14:28',
            'status' => 'early',
            'created_at' => now()->subDays(7),
        ]);


        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:01:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(6),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:23:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(5),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:12:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(4),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '16:21:28',
            'status' => 'early',
            'created_at' => now()->subDays(3),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:03:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(2),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '17:01:28',
            'status' => 'on_time',
            'created_at' => now()->subDays(1),
        ]);

        Em_log_out::create([
            'employee_id' => $employeeId,
            'logout_time' => '16:24:28',
            'status' => 'early',
            'created_at' => now(),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 75,
            'added_value' => 1,
            'created_at' => now()->subDays(10),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 76,
            'added_value' => 1,
            'created_at' => now()->subDays(9),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 77,
            'added_value' => 1,
            'created_at' => now()->subDays(8),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 78,
            'added_value' => 1,
            'created_at' => now()->subDays(7),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 79,
            'added_value' => 1,
            'created_at' => now()->subDays(6),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 80,
            'added_value' => 1,
            'created_at' => now()->subDays(5),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 81,
            'added_value' => 1,
            'created_at' => now()->subDays(4),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 82,
            'added_value' => 2,
            'created_at' => now()->subDays(3),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 84,
            'added_value' => 2,
            'created_at' => now()->subDays(2),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 86,
            'added_value' => 2,
            'created_at' => now()->subDays(1),
        ]);

        Point_log::create([
            'employee_id' => $employeeId,
            'previous_value' => 88,
            'added_value' => 2,
            'created_at' => now(),
        ]);




    }
}
