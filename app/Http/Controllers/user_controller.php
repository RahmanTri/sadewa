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

    public function getLatestLogin()
    {
        $user = Auth::user();
        $tomorrow = Carbon::tomorrow();
        $startOfWeek = $tomorrow->copy()->startOfWeek(Carbon::SUNDAY);

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
            ->whereBetween('created_at', [$startOfWeek, $tomorrow])
            ->get();

        // $faceData = Employee::where('employee.id', $user->id)->first()->face_data;


        return response()->json([
            "success" => true,
            "latest_login" => $latestLogin
        ], 200);
    }
}
