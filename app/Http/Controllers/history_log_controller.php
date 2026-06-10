<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Em_log_in;
use App\Models\Em_log_out;
use App\Models\Employee;
use App\Models\Division;



class history_log_controller extends Controller
{
    public function index()
    {

        $query = Employee::leftJoin(
            'employee_log_in',
            'employee_log_in.employee_id',
            '=',
            'employee.id'
        )
            ->leftJoin('employee_log_out', 'employee_log_out.employee_id', '=', 'employee.id')
            ->join('division', 'employee.division_id', '=', 'division.id')
            ->select(
                'employee_log_in.created_at as date',
                'employee.id',
                'employee.company_id',
                'employee.name as employee_name',
                'division.division_name',
                'employee_log_in.login_time as login',
                'employee_log_in.status as login_status',
                'employee_log_out.logout_time as logout_time',
                'employee_log_out.status as logout_status'
            );


        $data = $query->get()
            ->map(function ($item) {
                $item->date = Carbon::parse($item->date)->toDateString();
                return $item;
            });

        return response()->json([
            "success" => true,
            "message" => "data berhasil di dapatkan",
            "data" => $data
        ]);


    }

    public function fetch_histories()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $employee = Employee::where("user_id", $user->id)->first();

        $data = Em_log_in::where("employee_log_in.employee_id", $employee->id)
            ->where('employee_log_in.created_at', '>=', now()->subDays(364))
            ->join('employee_log_out', 'employee_log_out.employee_id', '=', 'employee_log_in.employee_id')
            ->where('employee_log_out.employee_id', $employee->id)
            ->where('employee_log_in.employee_id', $employee->id)
            ->whereRaw('DATE(employee_log_out.created_at) = DATE(employee_log_in.created_at)')
            ->select(
                'employee_log_in.created_at as date',
                'employee_log_in.login_time as waktu_masuk',
                'employee_log_in.status as status_masuk',
                'employee_log_out.logout_time as waktu_keluar',
                'employee_log_out.status as status_keluar'
            )
            ->get()
            ->filter(function ($item) {
                return Carbon::parse($item->date)->toDateString();
            })
            ->map(
                function ($item) {
                    $tanggal = Carbon::parse($item->date)->locale('id');
                    return [
                        'hari' => $tanggal->translatedFormat('l'),
                        'tanggal' => $tanggal->translatedFormat('d'),
                        'bulan' => $tanggal->translatedFormat('F'),
                        'tahun' => $tanggal->translatedFormat('Y'),
                        'waktu_masuk' => $item->waktu_masuk,
                        'status_masuk' => $item->status_masuk,
                        'waktu_keluar' => $item->waktu_keluar,
                        'status_keluar' => $item->status_keluar,
                    ];
                }
            );
            
        return response()->json([
            "success" => true,
            "message" => "data berhasil di dapatkan",
            "data" => $data
        ]);

    }
}