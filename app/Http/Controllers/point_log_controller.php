<?php

namespace App\Http\Controllers;

use App\Models\point_log;
use Auth;
use Illuminate\Http\Request;
use App\Models\Employee;
use Carbon\Carbon;

class point_log_controller extends Controller
{
    //
    public function getData() {

        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success"=> false,
                "message"=> "Unauthorized"
                ],401);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        if (!$employee) {
            return response()->json([
                "success"=> false,
                "message"=> "Anda tidak terdaftar sebagai karyawan"
                ],401);
        }

        $data = point_log::where('point_log.employee_id', $employee->id)
        ->where('point_log.created_at', '>=', now()->subDays(7))
        ->join('employee_log_in as emli', 'emli.employee_id', '=', 'point_log.employee_id')
        ->whereRaw('DATE(emli.created_at) = DATE(point_log.created_at)')
        ->select(
            'point_log.created_at as date',
            'point_log.previous_value as point_sebelumnya',
            'point_log.added_value as point_didapat',
            'emli.status as status_kehadiaran',
        )
        ->get()
        ->filter(function ($item) {
            return Carbon::parse($item->date)->toDateString();
        })
        ->map(function ($item) {
            $tanggal = Carbon::parse($item->date)->locale('id');
            return [
                'hari' => $tanggal->translatedFormat('l'),
                'tanggal' => $tanggal->format('d'),
                'bulan' => $tanggal->format('F'),
                'tahun' => $tanggal->format('Y'),
                'point_sebelumnya' => $item->point_sebelumnya,
                'point_didapat' => $item->point_didapat,
                'status_kehadiran' => $item->status_kehadiaran
            ];
        })
        ;

        return response()->json([
            "success" => true,
            'message' => "Sukses mengambil data",
            "data" => $data
        ], 200);

    }
}
