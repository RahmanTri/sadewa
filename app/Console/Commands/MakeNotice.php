<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Employee;
use App\Models\notices;

class MakeNotice extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'create:createNotice';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send Notifications to all employees';

    /**
     * Execute the console command.
     */
    public function handle()
    {

        $rawData = Employee::join('point', 'employee_id', '=', 'employee.id')
            ->select('employee.id as employee_id', 'point.point_value')
            ->get();

        foreach ($rawData as $employee) {
            if ($employee->point_value <= 50) {
                notices::create([
                    'title' => 'Pengingat Point Rendah',
                    'content' => 'Pointmu saat ini berada di bawah batas wajar! Jika dalam 2 minggu anda tidak menunjukkan sebuah perubahan, maka siap-siap untuk dipanggil oleh HRD!',
                    'employee_id' => $employee->employee_id,
                    'is_read' => 0
                ]);
            } elseif ($employee->point_value <= 75) {
                notices::create([
                    'title' => 'Pengingat Point Menengah',
                    'content' => 'Pointmu saat ini berada pada pertengahan! Lebih disiplin lagi dan tingkatkan pointmu, jangan sampai pointmu dibawah batas wajar!',
                    'employee_id' => $employee->employee_id,
                    'is_read' => 0
                ]);
            } elseif ($employee->point_value >= 85) {
                notices::create([
                    'title' => 'Pengingat Point Tinggi',
                    'content' => 'Pointmu saat ini Berkarisma! Pertahankan Pointmu dan nikmati bonus-bonus yg tersedia!',
                    'employee_id' => $employee->employee_id,
                    'is_read' => 0
                ]);
            }
        }
        $this->info("Notice Berhasil dibuat");
    }
}
