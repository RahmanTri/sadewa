<?php

namespace App\Console\Commands;

use App\Models\Employee;
use Illuminate\Console\Command;
use App\Models\activity_log;
use App\Models\Em_log_in;
use App\Models\Em_log_out;
use App\Models\Point;
use App\Models\point_log;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\em_log_in_controller;
use Carbon\Carbon;

class AutoAbsen extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'create:autoAbsen';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate absen masuk dan keluar otomatis';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $now = Carbon::now('Asia/Jakarta');

        $employees = Employee::all();

        foreach ($employees as $employee) {
            $point = Point::where('employee_id', $employee->id)->first();
            $signIn = Em_log_in::where('employee_id', $employee->id)->whereDate('created_at', $now->toDateString())->first();

            if (!$signIn && $now->gte($employee->division->checkout_time)) {
                Em_log_in::create([
                    'employee_id' => $employee->id,
                    'login_time' => $now->translatedFormat('H:i:s'),
                    'status' => 'absent',
                ]);

                $point->point_value -= 2;
                $point->positive_streak = 0;
                $point->negative_streak += 3;

                point_log::create([
                    'employee_id' => $employee->id,
                    'previous_value' => $point->point_value,
                    'added_value' => -2,
                ]);
                $point->save();

                activity_log::create([
                    'user_id' => $employee->user_id,
                    'activity_type' => 'Alpha Masuk',
                    'description' => 'Anda tidak melakukan absen (Alpha)',
                ]);
            }

            $signOut = Em_log_out::where('employee_id', $employee->id)->whereDate('created_at', $now->toDateString())->first();
            if (!$signOut && $now->gte($employee->division->checkout_time)) {

                $point = Point::where('employee_id', $employee->id)->first();

                Em_log_out::create([
                    'employee_id' => $employee->id,
                    'logout_time' => $now->translatedFormat('H:i:s'),
                    'status' => 'absent',
                ]);

                $point->point_value -= 1;
                $point->positive_streak = 0;
                point_log::create([
                    'employee_id' => $employee->id,
                    'previous_value' => $point->point_value,
                    'added_value' => -1,
                ]);
                $point->save();

                activity_log::create([
                    'user_id' => $employee->user_id,
                    'activity_type' => 'Alpha Keluar',
                    'description' => 'Anda tidak melakukan absen (Alpha)',
                ]);


            }
            Employee::update(['logged_in' => 1, 'logged_out' => 1]);
        }

        $this->info('Absen masuk dan keluar otomatis telah dibuat.');
    }
}
