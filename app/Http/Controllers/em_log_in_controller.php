<?php

namespace App\Http\Controllers;

use App\Models\Division;
use App\Models\Employee;
use App\Models\User;
use Illuminate\Http\Request;
use App\Models\Em_log_in;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use function PHPUnit\Framework\returnArgument;

class em_log_in_controller extends Controller
{
    //
    public function index()
    {
        $retrieve = Em_log_in::all();

        return response()->json([
            "success" => true,
            "message" => "Sukses mengambil data",
            "data" => $retrieve,
        ], 200);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "employee_id" => "required",
            "login_time" => "required",
            "status" => "required",

        ], [
            "employee_id.required" => "ID karyawan tidak boleh kosong",
            "login_time.required" => "Waktu tidak boleh kosong",
            "status.required" => "Status tidak boleh kosong",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "gagal menyimpan data",
                "eror" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        $data = Em_log_in::create($validatedData);

        return response()->json([
            "success" => true,
            "message" => "Sukses menyimpan data",
            "data" => $data,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            "employee_id" => "sometimes|required",
            "login_time" => "sometimes|required",
            "status" => "sometimes|required",
        ], [
            "employee_id.required" => "ID karyawan tidak boleh kosong",
            "login_time.required" => "Waktu tidak boleh kosong",
            "status.required" => "Status tidak boleh kosong",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal membarui data",
                "data" => $validator->errors(),
            ], 422);
        }
    }

    public function destroy($id)
    {
        $log_in = Em_log_in::find($id);

        if (!$log_in) {
            return response()->json([
                "success" => false,
                "message" => "ID $id tidak ditemukan di dalam database",
            ], 404);
        }

        $log_in->delete();

        return response()->json([
            "success" => true,
            "message" => "Sukses menghapus data",
        ], 200);
    }

    public function check_in(Request $request)
    {
        $time = Carbon::createFromFormat('H:i:s', $request->time);
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $employee = Employee::where('user_id', $user->id)->first();
        $status = "";
        $division = Division::where('id', $employee->division_id)->first();

        $checkIn = Carbon::createFromFormat('H:i:s', $division->checkin_time);
        $tolerance = (int) $division->tolerance;

        $lowerBound = $checkIn->copy()->subMinutes($tolerance);
        $upperBound = $checkIn->copy()->addMinutes($tolerance);

        if ($time->between($lowerBound, $upperBound)) {
            $status = "on_time";
        } elseif ($time->gt($upperBound)) {
            $status = "late";
        }

        $login_data = [
            "employee_id" => $employee->id,
            "login_time" => $time,
            "status" => $status
        ];

        $data = Em_log_in::create($login_data);

        return response()->json([
            "success" => true,
            "message" => "berhasil checkin dalam kondisi $status",
            "data" => $data
        ], 200);
    }
}
