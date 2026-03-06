<?php

namespace App\Http\Controllers;

use App\Models\Division;
use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Models\Em_log_out;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class em_log_out_controller extends Controller
{

	public function index()
	{
		$retrieve = Em_log_out::all();

		return response()->json([
			"Success" => true,
			"message" => "Sukses menerima data",
			"data" => $retrieve,
		], 200);
	}

	public function store(Request $request)
	{
		$validator = Validator::make($request->all(), [
			"employee_id" => "required",
			"logout_time" => "required",
			"status" => "required",
		], [
			"employee_id.required" => "ID karyawan tidak boleh kosong",
			"logout_time.required" => "Waktu tidak boleh kosong",
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

		$data = Em_log_out::create($validatedData);

		return response()->json([
			"success" => true,
			"message" => "sukses menyimpan data",
			"data" => $data,
		], 200);
	}

	public function update(Request $request, $id)
	{
		$validator = Validator::make($request->all(), [
			"employee_id" => "sometimes|required",
			"logout_time" => "sometimes|required",
			"status" => "sometimes|required",
		], [
			"employee_id.required" => "ID karyawan tidak boleh kosong",
			"logout_time.required" => "Waktu tidak boleh kosong",
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
		$log_out = Em_log_out::find($id);

		if (!$log_out) {
			return response()->json([
				"success" => false,
				"message" => "ID $id tidak ditemukan di dalam database",
			], 404);
		}

		$log_out->delete();

		return response()->json([
			"success" => true,
			"message" => "Sukses menghapus data",
		], 200);
	}

	public function check_out(Request $request)
	{

		$chkTime = Carbon::createFromFormat('H:i:s', $request->time);

		$user = Auth::user();

		if (!$user) {
			return response()->json([
				'success' => false,
				'message' => 'Unauthorized',
			], 401);
		}

		$employee = Employee::where("user_id", $user->id)->first();
		$division = Division::where('id', $employee->division_id)->first();
		$chkoutTime = Carbon::createFromFormat('H:i:s', $division->checkout_time);
		$timeTolerance = (int) $division->tolerance;

		$lowerBound = $chkoutTime->copy()->subMinutes($timeTolerance);
		$upperBound = $chkoutTime->copy()->addMinutes($timeTolerance);

		$chkStatus = "";

		if ($chkTime->between($upperBound, $lowerBound)) {
			$chkStatus = "on_time";
		} elseif ($chkTime->lt($upperBound)) {
			$chkStatus = "early";
		} else {
			$chkStatus = "auto_log";
		}

		$logout_data = [
			"employee_id" => $employee->id,
			"logout_time" => $chkTime,
			"status" => $chkStatus,
		];

		$data = Em_log_out::create($logout_data);

		return response()->json([
			"success" => true,
			"message" => "Berhasil logout dalam kondisi $chkStatus",
			'data' => $data,
		], 201);
	}
}