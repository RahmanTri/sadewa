<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Employee;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Point;

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
            "name" => "sometimes|required|string|max:150",
            "company_id" => "sometimes|required|string|max:8",
            "division_id" => "sometimes|required",
            "phone_number" => "sometimes|required|string|max:13",
            "face_data" => "sometimes|nullable",
        ], [
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
    public function emregister(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "username" => "required|string|max:24",
            "password" => "required|string|min:8",
            "email" => "required|email",
            "name" => "required|string|max:150",
            "division_id" => "required",
            "phone_number" => "required|string|max:13|min:12",

        ], [
            "username.required" => "Username harus diisi!",
            "username.max" => "Username maksimal 24 karakter",
            "password.required" => "Password harus diisi!",
            "pasword.min" => "Buat password setidaknya 8 karakter",
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid",
            "name.required" => "Nama tidak boleh kosong!",
            "name.max" => "Nama maksimal 150 karakter!",
            "division_id.required" => "ID divisi harus diisi!",
            "phone_number.required" => "Nomor telepon harus diisi!",
            "phone_number.max" => "Nomor telepon tidak valid",
            "phone_number.min" => "Nomor telepon tidak valid",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal mendaftar!",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        $companyPrefix = 'KKS';
        $divisonId = $validatedData['division_id'];
        $idNumber = Employee::max('id') + 1 ?? 0;
        $companyId = $companyPrefix . str_pad($divisonId, 2, '0', STR_PAD_LEFT) . str_pad($idNumber, 3, '0', STR_PAD_LEFT);

        $createdUser = User::where('email', $validatedData['email'])->first();

        if (!$createdUser) {

            $data = User::create([
                "username" => $validatedData["username"],
                "password" => Hash::make($validatedData["password"]),
                "email" => $validatedData["email"],
                // "role" => $validatedData["role"],
            ]);
        } else {
            $data = $createdUser;
        }

        $createdEmployee = Employee::where('user_id', $data["user_id"])->first();

        if (!$createdEmployee) {

            $employee = Employee::create([
                "user_id" => $data->id,
                "name" => $validatedData["name"],
                "company_id" => $companyId,
                "phone_number" => $validatedData["phone_number"],
                "division_id" => $validatedData["division_id"],
            ]);
        } else {
            $employee = $createdEmployee;
        }

        $createdPoint = Point::where("employee_id", $employee["id"])->first();

        if (!$createdPoint) {

            $point = Point::create([
                "employee_id" => $employee->id,
            ]);

        } else {
            $point = $createdPoint;
        }


        return response()->json(
            [
                "success" => true,
                "message" => "Sukses membuat akun",
                "data" => [
                    "user_data" => $data,
                    "employee_data" => $employee,
                    "pont_data" => $point,
                ],
            ],
            201
        );
    }

}
