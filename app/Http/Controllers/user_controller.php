<?php

namespace App\Http\Controllers;

use App\Models\Division;
use App\Models\Em_log_in;
use Auth;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Employee;
use Carbon\Carbon;

class user_controller extends Controller
{
    //
    public function index()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $data = User::all();

        return response()->json([
            "success" => true,
            "data" => $data,
        ], 200);
    }

    public function getUser()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $employee = Employee::where('user_id', $user->id)
            ->join('users', 'employee.user_id', 'users.id')
            ->join('division', 'employee.division_id', 'division.id')
            ->join('point', 'employee.id', 'point.employee_id')
            ->select(
                'employee.id',
                'users.username as username',
                'users.email as email',
                'employee.company_id as id_perusahaan',
                'employee.name as nama_karyawan',
                'employee.phone_number as no_hp',
                'employee.profile_pic as foto_profil',
                'employee.logged_in as status_masuk',
                'employee.logged_out as status_keluar',
                'division.division_name as nama_divisi',
                'point.point_value as poin',
                'point.positive_streak as streak_positif',
                'point.negative_streak as streak_negatif',
            )
            ->first();

        $latestLogin = Em_log_in::where('employee_id', $employee->id)
            ->select(
                'employee_log_in.employee_id as id_karyawan',
                'employee_log_in.created_at as waktu_masuk',
                'employee_log_in.status as status',
            )
            ->where('created_at', '>=', Carbon::now()->subDays(6))
            ->get();

        $faceData = Employee::where('employee.id', $user->id)->first()->face_data;


        return response()->json([
            "success" => true,
            "data" => $employee,
            "face_data" => json_decode($faceData),
            "latest_login" => $latestLogin
        ], 200);
    }
}
