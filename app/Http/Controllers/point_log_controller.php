<?php

namespace App\Http\Controllers;

use App\Models\point_log;
use Auth;
use Illuminate\Http\Request;
use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class point_log_controller extends Controller
{
    //
    public function getData()
    {

        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        if (!$employee) {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak terdaftar sebagai karyawan"
            ], 401);
        }

        $data = DB::table('point_log as pl')
            ->where('pl.employee_id', $employee->id)
            ->where('pl.created_at', '>=', now()->subDays(7))
            ->LeftJoin('employee_log_in as emli', function ($join) {
                $join->on('pl.employee_id', '=', 'emli.employee_id')
                    ->whereRaw('DATE(pl.created_at) = DATE(emli.created_at)');
            })
            ->LeftJoin('employee_log_out as emlo', function ($join) {
                $join->on('pl.employee_id', '=', 'emlo.employee_id')
                    ->whereRaw('DATE(pl.created_at) = DATE(emlo.created_at)');
            })
            ->select(
                'pl.created_at as date',
                'pl.previous_value as point_sebelumnya',
                'pl.added_value as point_didapat',
                DB::raw("CASE 
                    WHEN pl.source = 'log_in' THEN emli.status
                    WHEN pl.source = 'log_out' THEN emlo.status
                    END as status
            "),
                DB::raw(
                    "CASE 
                WHEN pl.source = 'log_in' THEN 'Check-In'
                WHEN pl.source = 'log_out' THEN 'Check-Out'
                END as source"
                )
            )
            ->orderBy('pl.created_at', 'desc')
            ->get()
            ->filter(function ($item) {
                return Carbon::parse($item->date)->toDateString();
            })
            ->map(function ($item) {
                $tanggal = Carbon::parse($item->date)->locale('id');
                return [
                    'hari' => $tanggal->translatedFormat('l'),
                    'tanggal' => $tanggal->format('d'),
                    'bulan' => $tanggal->translatedFormat('F'),
                    'tahun' => $tanggal->format('Y'),
                    'point_sebelumnya' => $item->point_sebelumnya,
                    'point_didapat' => $item->point_didapat,
                    'sumber' => $item->source,
                    'status' => $item->status
                ];
            });

        return response()->json([
            "success" => true,
            'message' => "Sukses mengambil data",
            "data" => $data
        ], 200);

    }
}
