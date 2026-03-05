<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Employee;
use Illuminate\Support\Facades\Validator;

class employee_controller extends Controller
{
    //
    public function index()
    {
        $employees = Employee::all();

        return response()->json([
            "Success" => true,
            "message" => "Sukses menerima data",
            "data" => $employees,
        ], 200);
    }

    public function store(Request $request)
    {
        $valida = Validator::make($request->all(), [
            "user_id" => "required",
            "name" => "required|string|max:150",
            "company_id" => "required|string|max:8",
            "division_id" => "required",
            "phone_number" => "required|string|max:13",
            "face_data" => "sometimes|nullable",
        ], [
            "user_id.required" => "ID user tidak boleh kosong",
            "name.required" => "Nama tidak boleh kosong",
            "name.max" => "Nama maksimal 150 karakter",
            "company_id.required" => "ID karyawan perushaan tidak boleh kosong",
            "company_id.max" => "ID keryawan perusahaan maksimal 8 karakter",
            "division_id.required" => "ID divisi tidak boleh kosong",
            "phone_number.required" => "Nomor telepon tidak boleh kosong",
            "phone_number.max" => "Nomor telepon maksimal 13 angka",
        ]);

        if ($valida->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'gagal menyimpan data',
                'errors' => $valida->errors(),
            ], 422);
        }

        $validatedData = $valida->validate();

        $employee = Employee::create($validatedData);

        return response()->json([
            'success' => true,
            'message' => 'sukses menambahkan data',
            'data' => $employee,
        ], 200);
    }

    public function update(Request $request, $id)
    {

        $target = Employee::find($id);

        if (!$target) {
            return response()->json([
                'success' => false,
                'message' => "data dengan ID $id tidak ditemukan",
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            "user_id" => "sometimes|required",
            "name" => "sometimes|required|string|max:150",
            "company_id" => "sometimes|required|string|max:8",
            "division_id" => "sometimes|required",
            "phone_number" => "sometimes|required|string|max:13",
            "face_data" => "sometimes|nullable",
        ], [
            "user_id.required" => "ID user tidak boleh kosong",
            "name.required" => "Nama tidak boleh kosong",
            "name.max" => "Nama maksimal 150 karakter",
            "company_id.required" => "ID karyawan perushaan tidak boleh kosong",
            "company_id.max" => "ID keryawan perusahaan maksimal 8 karakter",
            "division_id.required" => "ID divisi tidak boleh kosong",
            "phone_number.required" => "Nomor telepon tidak boleh kosong",
            "phone_number.max" => "Nomor telepon maksimal 13 angka",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "gagal membarui data",
                "errors" => $validator->errors(),
            ], 422);


        }

        $validatedData = $validator->validate();

        $oldData = $target;

        $target->update($validatedData);

        return response()->json([
            "success" => true,
            "message" => "sukses membarui data",
            "data" => $target,
            "old_data" => $oldData,
        ], 200);

    }

    public function destroy(Request $request, $id)
    {
        $target = Employee::find($id);

        if (!$target) {
            return response()->json([
                "success" => false,
                "message" => "data dengan ID $id tidak ditemukan",
            ], 404);
        }

        $target->delete();
        return response()->json([
            "success" => true,
            "message" => "sukses menghapus data",
            "data" => $target,
        ], 200);
    }
}
