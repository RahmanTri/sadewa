<?php

namespace App\Http\Controllers;

use App\Models\Point;
use Auth;
use App\Models\Employee;
use App\Models\Division;
use App\Models\Em_log_in;
use App\Models\Em_log_out;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class dashboard_controller extends Controller
{
    //
    public function fetch()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Anda belum login!"
            ], 401);
        }

        $employee = Employee::where("user_id", $user->id)->first();

        $weekInData = Em_log_in::day(7, $employee->id);
        $weekOutData = Em_log_out::day(7, $employee->id);
        $lateCount = Em_log_in::lateCount($employee->id);
        $emPoint = Point::where("employee_id", $employee->id)->first();

        return response()->json([
            "success" => true,
            "test" => $employee,
            "data" => [
                "employee" => $employee,
                "logIn" => $weekInData,
                "LogOut" => $weekOutData,
                "late" => $lateCount . "Hari",
                "point" => $emPoint,
            ]
        ], 200);
    }

    public function monitorDivision(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "division_id" => "required|int",
            "display_days" => "required|int",
        ], [
            "division_id.required" => "Division id diperlukan",
            "display_days.required" => "Jumlah hari diperlukan",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 403);
        }

        $validatedData = $validator->validate();

        $data = Employee::getByDiv($validatedData['division_id'], $validatedData['display_days'])->get();

        return response()->json([
            'success' => true,
            'data' => $data,
        ], 200);
    }

    public function monitorAll(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "display_days" => "required|int",
        ], [
            "display_days.required" => "Jumlah hari diperlukan",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 401);
        }

        $validatedData = $validator->validate();

        $data = Employee::getAll($validatedData['display_days'])->get();

        return response()->json([
            'success' => true,
            'data' => $data,
        ], 200);
    }
}
