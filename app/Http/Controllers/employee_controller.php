<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Support\Facades\Storage;
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
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!",
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "name" => "required|string|max:150",
            "division_id" => "required",
            "phone_number" => "required|string|max:13",
            "face_data" => "sometimes|nullable",
        ], [
            "user_id.required" => "ID user tidak boleh kosong",
            "name.required" => "Nama tidak boleh kosong",
            "name.max" => "Nama maksimal 150 karakter",
            "division_id.required" => "ID divisi tidak boleh kosong",
            "phone_number.required" => "Nomor telepon tidak boleh kosong",
            "phone_number.max" => "Nomor telepon maksimal 13 angka",
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'gagal menyimpan data',
                'errors' => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        $companyPrefix = 'KKS';
        $divisonId = $validatedData['division_id'];
        $idNumber = Employee::max('id') + 1 ?? 0;
        $companyId = $companyPrefix . str_pad($divisonId, 2, '0', STR_PAD_LEFT) . str_pad($idNumber, 3, '0', STR_PAD_LEFT);

        $createdEmployee = Employee::where('user_id', $user->id)->first();

        if (!$createdEmployee) {
            $employee = Employee::create([
                'user_id' => $user->id,
                'company_id' => $companyId,
                'division_id' => $divisonId,
                'name' => $validatedData['name'],
                'phone_number' => $validatedData['phone_number'],
            ]);
        } else {
            $employee = $createdEmployee;
        }

        $createdPoint = Point::where('employee_id', $employee->id)->first();

        if (!$createdPoint) {
            $point = Point::create([
                'employee_id' => $employee->id,
            ]);
        } else {
            $point = $createdPoint;
        }

        return response()->json([
            'success' => true,
            'message' => 'sukses menambahkan data',
            'data' => $employee,
            'point' => $point,
        ], 201);
    }

    public function update(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ada'
            ], 403);
        }

        $target = Employee::where('user_id', $user->id)->first();

        if (!$target) {
            return response()->json([
                'success' => false,
                'message' => "data dengan ID $user->id tidak ditemukan",
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            "name" => "sometimes|required|string|max:150",
            "division_id" => "sometimes|required",
            "phone_number" => "sometimes|required|string|max:13",
            "face_data" => "sometimes|nullable",
        ], [
            "name.required" => "Nama tidak boleh kosong",
            "name.max" => "Nama maksimal 150 karakter",
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

        $oldData = $target->toArray();

        $target->update([
            "name" => $validatedData["name"] ?? $target->name,
            'division_id' => $validatedData['division_id'] ?? $target->division_id,
            'phone_number' => $validatedData['phone_number'] ?? $target->phone_number,
            'face_data' => $validatedData['face_data'] ?? $target->face_data,
        ]);

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

    public function deleteAccount(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "username" => "required|string|max:24",
            "email" => "required|email",

        ], [
            "username.required" => "Username tidak boleh kosong!",
            "username.max" => "Username maksimal 24 karakter",
            "email.required" => "Email tidak boleh kosong!",
            "email.email" => "Email tidak valid",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 403);
        }

        $validatedData = $validator->validate();


        $user = User::where("email", $validatedData["email"])->first();
        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Akun tidak ada atau belum terdaftar!",
            ], 403);
        }

        $employee = Employee::where('user_id', $user->id)->first();
        $point = Point::where('employee_id', $employee->id)->first();

        $deletedData = [
            "user" => $user,
            "employee" => $employee,
            "point" => $point,
        ];

        $point->delete();
        $employee->delete();
        $user->delete();

        return response()->json([
            'success' => true,
            'message' => 'Sukses menghapus akun!',
            'deleted_data' => $deletedData,
        ], 200);
    }

    public function updateProfile(Request $request)
    {
        $user = Auth::user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ada!',
            ], 403);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        $validator = Validator::make($request->all(), [
            'name' => 'sometimes|string|max:150',
            'email' => 'sometimes|email',
            "phone_number" => "sometimes|string|max:13|min:12",
            "password" => "sometimes|string|min:8",
            "profile_pic" => "sometimes|image|max:4096",
        ], [
            "name.max" => "Nama maksimal 150 karakter",
            "email.email" => "Email tidak valid",
            "phone_number.max" => "Nomor telepon tidak valid",
            "phone_number.min" => "Nomor telepon tidak valid",
            "password.min" => "Password minimal 8 karakter",
            "profile_pic.image" => "File harus berupa gambar",
            // "profile_pic.mimetypes" => "Format file yang didukung adalah PNG, JPG, dan JPEG",
            "profile_pic.max" => "Ukuran file maksimal 4MB",
        ]);

        // dd($request->file('profile_pic'));

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 422);
        }

        $oldUserData = $user->toArray();
        $oldImage = $employee->profile_pic;
        $oldEmployeeData = $employee->toArray();

        if ($request->hasFile("profile_pic")) {
            $imageFile = $request->file("profile_pic");
            if ($oldImage) {
                Storage::disk("public")->delete("profile_pics/" . $oldImage);
            }
            $path = $imageFile->storeAs("profile_pics", $imageFile->hashName(), "public");
            $employee->profile_pic = $imageFile->hashName();
        }

        $validatedData = $validator->validated();

        // If password is not empty
        if (isset($validatedData['password'])) {
            $user->password = Hash::make($validatedData["password"]);
        }

        // If email is not empty
        if (isset($validatedData['email'])) {
            $user->email = $validatedData["email"];
        }

        // If phone number is not empty
        if (isset($validatedData['phone_number'])) {
            $employee->phone_number = $validatedData["phone_number"];
        }

        // If name is not empty
        if (isset($validatedData['name'])) {
            $employee->name = $validatedData["name"];
        }

        $employee->save();
        $user->save();

        return response()->json([
            'success' => true,
            "data" => [
                "user" => [
                    "old" => $oldUserData,
                    "new" => $user,
                ],
                "employee" => [
                    "old" => $oldEmployeeData,
                    "new" => $employee,
                ]
            ]
        ], 200);
    }

    public function regFace(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!"
            ], 200);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        if (!$employee) {
            return response()->json([
                "success" => false,
                "message" => "Anda bukan karyawan!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "face_data" => "required"
        ], [
            "face_data.required" => "Face data diperlukan!"
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Terjadi kegagalan",
                "error" => $validator->errors(),
            ], 401);
        }

        $validatedData = $validator->validate();

        $employee->face_data = $validatedData["face_data"] ?? $employee->face_data;

        $faceDataEncode = json_encode($validatedData["face_data"]);

        $employee->face_data = $faceDataEncode ?? $employee->face_data;

        $employee->save();  

        return response()->json([
            "success" => true,
            "data" => $employee,
        ], 200);
    }
}

