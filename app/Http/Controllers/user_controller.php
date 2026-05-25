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

    public function fetchUser()
    {
        $user = Auth::user();
        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $data = User::where('id', $user->id)->first()
            ->join('employee', 'employee.user_id', '=', 'users.id')
            ->join('division', 'division.id', '=', 'employee.division_id')
            ->join('point', 'point.employee_id', '=', 'employee.id')
            ->select(
                'users.id as user_id',
                'users.email as email',
                'employee.name as nama_lengkap',
                'employee.phone_number as no_telp',
                'employee.profile_pic as foto_profil',
                'employee.division_id as id_divisi',
                'point.point_value as poin',
                'division.division_name as nama_divisi',
                'employee.logged_in as logged_in',
                'employee.logged_out as logged_out',
            )
            ->get()
        ;

        return response()->json([
            'success' => true,
            'message' => 'berhasil mendapatkan data untuk home',
            'refreshed_userData' => $data,
        ], 200);


    }

    public function getLatestLogin()
    {
        $user = Auth::user();
        // $tomorrow = Carbon::tomorrow()->endOfDay();
        // $startOfWeek = $tomorrow->copy()->startOfWeek(Carbon::SUNDAY);

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        $latestLogin = Em_log_in::where('employee_id', $employee->id)
            ->select(
                'employee_log_in.created_at as hari',
                'employee_log_in.status as status',
            )
            ->whereBetween('created_at', [Carbon::now()->startOfWeek(Carbon::SUNDAY), Carbon::now()->endOfDay()])
            ->get();

        return response()->json([
            "success" => true,
            "latest_login" => $latestLogin
        ], 200);
    }

    public function getUserDivision()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        $employeeDivision = Division::where('id', $employee->division_id)->first();

        return response()->json([
            "success" => true,
            "data" => $employeeDivision
        ], 200);

    }
}
