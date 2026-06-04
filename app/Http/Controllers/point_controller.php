<?php

namespace App\Http\Controllers;

use App\Models\point;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class point_controller extends Controller
{
	//
	public function index()
	{
		$points = point::all();

		return response()->json([
			"success" => true,
			"message" => "Sukses menerima data",
			"data" => $points,
		], 200);
	}

	public function store(Request $request)
	{
		$validator = Validator::make($request->all(), [
			"employee_id" => "required",
			"checkin_point" => "required",
			"early_checkout_point" => "required",
			"late_point" => "required",
		], [
			"employee_id.required" => "ID karyawan tidak boleh kosong",
			"checkin_point.required" => "Poin checkin tidak boleh kosong",
			"early_checkout_point.required" => "Poin early checkout tidak boleh kosong",
			"late_point.required" => "Poin terlambat tidak boleh kosong"
		]);

		if ($validator->fails()) {
			return response()->json([
				"success" => false,
				"error" => $validator->errors(),
			], 422);
		}

		$validateData = $validator->validate();

		$data = point::create($validateData);

		return response()->json([
			"success" => true,
			"data" => $data,
		], 200);
	}

	public function update(Request $request, $id)
	{
		$validator = Validator::make($request->all(), [
			"employee_id" => "sometimes|required",
			"checkin_point" => "sometimes|required",
			"early_checkin_point" => "sometimes|required",
			"late_point" => "sometimes|required",
		], [
			"employee_id.required" => "ID karyawan tidak boleh kosong",
			"checkin_point.required" => "Poin checkin tidak boleh kosong",
			"early_checkout_point.required" => "Poin early checkout tidak boleh kosong",
			"late_point.required" => "Poin terlambat tidak boleh kosong"
		]);

		if ($validator->fails()) {
			return response()->json([
				"success" => false,
				"error" => $validator->errors(),
			], 422);

			$validatedData = $validator->validate();

			$data = point::find($id);

			$data->update($validatedData);

			return response()->json([
				"success" => true,
				"data" => $data
			], 200);
		}
	}

	public function destroy($id)
	{
		$target = point::find($id);

		if (!$target) {
			return response()->json([
				"success" => false,
				"message" => "ID $id tidak ditemukan",
			], 404);
		}

		$target->delete();

		return response()->json([
			"success" => true,
			"message" => "data berhasil dihapus"
		], 200);
	}

	public function getUnderPoint()
	{
		$points = point::join('employee', 'employee.id', '=', 'point.employee_id')
			->join('division', 'division.id', '=', 'employee.division_id')
			->where('point_value', '<=', '40')
			->select(
				'employee.id as id',
				'employee.company_id as kode_karyawan',
				'employee.profile_pic as foto_profil',
				'division.division_name as divisi',
				'employee.name as nama_lengkap',
				'point.point_value as total_poin'
			)
			->get();

		return response()->json([
			"success" => true,
			"message" => "Sukses menerima data",
			"data" => $points,
		], 200);
	}
}