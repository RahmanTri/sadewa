<?php

namespace App\Http\Controllers;

use App\Notifications\SendOtp;
use Auth;
use DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;
use App\Models\Employee;
use App\Models\password_otp;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Point;
use App\Models\activity_log;

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Registrasi Karyawan',
            'description' => 'Registrasi Karyawan ' . $validatedData['name'],
        ]);

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Update Karyawan',
            'description' => 'Membarui data karyawan ' . $validatedData['name'],
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
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!",
            ], 403);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas",
            ], 403);
        }

        $target = Employee::find($id);

        if (!$target) {
            return response()->json([
                "success" => false,
                "message" => "data dengan ID $id tidak ditemukan",
            ], 404);
        }

        $target->delete();

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Hapus Karyawan',
            'description' => 'Menghapus data karyawan ' . $target->name,
        ]);


        return response()->json([
            "success" => true,
            "message" => "sukses menghapus data",
            "data" => $target,
        ], 200);
    }
    public function emregister(Request $request)
    {

        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Anda belum login!",
            ], 403);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!",
            ], 403);
        }

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Membuat Akun Karyawan',
            'description' => 'Membuat akun untuk karyawan ' . $employee->name,
        ]);

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Hapus Akun Karyawan',
            'description' => 'Menghapus akun karyawan ' . $employee->name,
        ]);

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Update Profile',
            'description' => 'Update profile Berhasil',
        ]);

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Registrasi Wajah',
            'description' => 'Registrasi data wajah',
        ]);

        return response()->json([
            "success" => true,
            "data" => $employee,
        ], 200);
    }

    public function fetchEmployeeData()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak punya otoritas disini!"
            ], 403);
        }

        $employeeData = DB::table("employee as em")
            ->join('division as dv', 'dv.id', '=', 'em.division_id')
            ->join('users as user', 'user.id', '=', 'em.user_id')
            ->select(
                'em.id as id_karyawan',
                'user.id as id_user',
                'em.company_id as id_perusahaan',
                'em.name as nama_lengkap',
                'user.email as email',
                'em.phone_number as no_tlp',
                'dv.id as id_divisi',
                'dv.division_name as nama_divisi',
                'em.profile_pic as foto_profil',
                'em.face_data as data_wajah'
            )
            ->orderBy('nama_lengkap', 'asc')
            ->get()
            ->map(function ($item) {
                if ($item->data_wajah != null) {
                    $item->data_wajah = 'Terdaftar';
                } else {
                    $item->data_wajah = 'Belum Terdaftar';
                }
                return $item;

            })
        ;

        return response()->json(
            [
                "success" => true,
                "message" => "Sukses mengambil data",
                "data" => $employeeData
            ]
        );
    }

    public function leaderboard()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        $employee = Employee::where('user_id', $user->id)->first();
        $leaderboardData = Point::join('employee', 'employee.id', '=', 'point.employee_id')
            ->Leftjoin('employee_log_in', 'employee_log_in.employee_id', '=', 'employee.id')
            ->select(
                'employee.id as id_karyawan',
                'employee.name as nama_lengkap',
                'employee.profile_pic as foto_profil',
                'point.point_value as total_poin',
                DB::raw("COUNT(CASE WHEN employee_log_in.status = 'late' THEN 1 END) as total_telat"),
                DB::raw("COUNT(*) as total_absen"),
                DB::raw("SUM(CASE WHEN employee_log_in.status = 'on_time' THEN 1 ELSE 0 END ) as total_ontime"),
                DB::raw("ROUND((SUM(CASE WHEN employee_log_in.status = 'on_time' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) as ontimePercent")
            )
            ->groupBy('employee.id', 'employee.name', 'employee.profile_pic', 'point.point_value')
            ->orderByDesc('point.point_value')
            ->get()
        ;

        $rankedData = $leaderboardData->map(function ($item, $index) {
            $item->rank = $index + 1;
            return $item;
        });

        $userRank = $rankedData->where('id_karyawan', $employee->id)->first();
        return response()->json(
            [
                "success" => true,
                "message" => "Sukses mengambil data",
                "leaderboardData" => $rankedData,
                "userRank" => $userRank

            ]
        );
    }

    public function resetFaceData(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "id" => "required|exists:employee,id",
        ], [
            "id.required" => "ID harus diisi!",
            "id.exists" => "ID tidak valid!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal menghapus data!",
                "error" => $validator->errors(),
            ], 401);
        }

        $validatedData = $validator->validated();

        $target = Employee::where('id', $validatedData["id"])->first();

        if (!$target) {
            return response()->json([
                "success" => false,
                "message" => "Data tidak ditemukan!",
            ], 404);
        }

        $target->face_data = null;

        $target->save();

        return response()->json([
            "success" => true,
            "message" => "Data berhasil dihapus!",
            "data" => $target,
        ], 200);

    }

    public function resetUserPW(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "id" => "required|exists:users,id",
        ], [
            "id.required" => "ID harus diisi!",
            "id.exists" => "ID tidak valid!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal menghapus data!",
                "error" => $validator->errors(),
            ], 401);
        }

        $validatedData = $validator->validated();

        $target = User::where('id', $validatedData["id"])->first();

        if (!$target) {
            return response()->json([
                "success" => false,
                "message" => "Data tidak ditemukan!",
            ], 404);
        }

        $target->password = Hash::make("{$target->username}123");

        $target->save();

        return response()->json([
            "success" => true,
            "message" => "Berhasil!",
            "data" => $target,
        ], 200);

    }

    public function editEmployee(Request $request)
    {
        $user = Auth::user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ada!',
            ], 403);
        }

        if ($user->role != "admin") {
            return response()->json([
                'success' => false,
                'message' => 'Anda tidak memiliki otoritas!',
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            'em_id' => 'required|exists:employee,id',
            'name' => 'sometimes|string|max:150',
            'email' => 'sometimes|email',
            "phone_number" => "sometimes|string|max:13|min:12",
            "division_id" => "sometimes|exists:division,id",
        ], [
            "em_id.required" => "ID harus diisi!",
            "em_id.exists" => "ID tidak valid!",
            "name.max" => "Nama maksimal 150 karakter",
            "email.email" => "Email tidak valid",
            "phone_number.max" => "Nomor telepon tidak valid",
            "phone_number.min" => "Nomor telepon tidak valid",
            "division_id.exists" => "ID divisi tidak valid!",
        ]);

        // dd($request->file('profile_pic'));

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        $targetEmployee = Employee::where('id', $validatedData["em_id"])->first();
        $targetUser = User::where('id', $targetEmployee->user_id)->first();

        $oldUserData = $targetUser->toArray();
        $oldEmployeeData = $targetEmployee->toArray();

        // If email is not empty
        if (isset($validatedData['email'])) {
            $targetUser->email = $validatedData["email"];
        }

        // If phone number is not empty
        if (isset($validatedData['phone_number'])) {
            $targetEmployee->phone_number = $validatedData["phone_number"];
        }

        // If name is not empty
        if (isset($validatedData['name'])) {
            $targetEmployee->name = $validatedData["name"];
        }

        // If division id is not empty
        if (isset($validatedData['division_id'])) {
            $targetEmployee->division_id = $validatedData["division_id"];
        }

        $targetEmployee->save();
        $targetUser->save();

        return response()->json([
            'success' => true,
            "data" => [
                "user" => [
                    "old" => $oldUserData,
                    "new" => $targetUser,
                ],
                "employee" => [
                    "old" => $oldEmployeeData,
                    "new" => $targetEmployee,
                ]
            ]
        ], 200);
    }

    public function clearProfilePics()
    {
        $user = Auth::user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ada!',
            ], 403);
        }

        $targetEmployee = Employee::where('user_id', $user->id)->first();

        if (!$targetEmployee) {
            return response()->json([
                "success" => false,
                "message" => "Data tidak ditemukan!",
            ], 404);
        }

        if ($targetEmployee->profile_pic == null) {
            return response()->json([
                "success" => false,
                "message" => "Foto profil tidak ada!",
            ], 422);
        }

        Storage::disk('public')->delete("profile_pics/" . $targetEmployee->profile_pic);

        $targetEmployee->profile_pic = null;

        $targetEmployee->save();

        return response()->json([
            "success" => true,
            "message" => "Foto profil berhasil dihapus!",
        ], 200);
    }

    public function sendOtpForgotPassword(Request $request)
    {

        $validator = Validator::make($request->all(), [
            "email" => "required|email",
        ], [
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        $user = User::where('email', $validatedData["email"])->first();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Email tidak ditemukan!",
            ], 404);
        }

        $otp = rand(1000, 9999);

        $userOtp = password_otp::where('user_id', $user->id)->first();

        if (!$userOtp) {
            $userOtp = password_otp::create([
                "user_id" => $user->id,
                "otp" => $otp,
                "otp_expired_at" => Carbon::now()->addMinutes(2)
            ]);
        } else {
            $userOtp->otp = $otp;
            $userOtp->otp_expired_at = Carbon::now()->addMinutes(2);
            $userOtp->save();
        }

        // Mail::to($user->email)->send(new SendOtpMail($otp));
        $user->notify(new SendOtp($otp));

        return response()->json([
            "success" => true,
            "message" => "Berhasil mengirimkan OTP!",
            "otp" => $otp,
        ], 200);

    }

    public function verifyOtpPassword(Request $request)
    {

        $validator = Validator::make($request->all(), [
            "email" => "required|email",
            "otp" => "required|numeric|digits:4",
        ], [
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid!",
            "otp.required" => "OTP harus diisi!",
            "otp.numeric" => "OTP harus berupa angka!",
            "otp.digits" => "OTP harus berupa 4 angka!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        $user = User::where('email', $validatedData["email"])->first();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Email tidak ditemukan!",
            ], 404);
        }

        $otpData = password_otp::where("user_id", $user->id)->first();
        //Find OTP based on email

        if (!$otpData) {
            return response()->json([
                "success" => false,
                "message" => "OTP tidak ditemukan!",
            ], 404);
        }

        if (now()->isAfter($otpData->otp_expired_at)) {
            return response()->json([
                "success" => false,
                "message" => "OTP sudah kedaluwarsa!",
            ], 422);
        } else if ($validatedData["otp"] == $otpData->otp) {

            $otpData->validated = true;

            $otpData->save();

            return response()->json([
                "success" => true,
                "message" => "OTP berhasil diverifikasi!",
            ], 200);
        } else {
            return response()->json([
                "success" => false,
                "message" => "Kode OTP salah atau tidak valid!",
            ], status: 422);
        }

        return response()->json([
            "success" => true,
            "message" => "OTP berhasil diverifikasi!",
        ], 200);
    }

    public function verifyPassword(Request $request)
    {

        $validator = Validator::make($request->all(), [
            "email" => "required|email",
            "password" => "required",
        ], [
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid!",
            "password.required" => "Password harus diisi!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();


        //Find User
        $user = User::where('email', $validatedData["email"])->first();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!",
            ], 404);
        }

        //check if OTP has verified
        $userOtp = password_otp::where('user_id', $user->id)->first();

        if (!$userOtp) {
            return response()->json([
                "success" => false,
                "message" => "OTP tidak ditemukan!",
            ], 404);
        }

        if (!$userOtp->validated) {
            return response()->json([
                "success" => false,
                "message" => "OTP belum diverifikasi!",
            ], 422);
        }

        //update password
        $user->password = Hash::make($validatedData["password"]);

        //change OTP to false
        $userOtp->validated = false;

        $user->save();
        $userOtp->save();

        return response()->json([
            "success" => true,
            "message" => "Password berhasil diubah!",
        ], 200);
    }

    public function deleteEmployee(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ada!',
            ], 403);
        }
        if ($user->role != "admin") {
            return response()->json([
                'success' => false,
                'message' => 'Anda tidak memiliki otoritas!',
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "id" => "required|exists:employee,id",
        ], [
            "id.required" => "ID harus diisi!",
            "id.exists" => "ID tidak valid!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal menghapus data!",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        $targetEmployee = Employee::where('id', $validatedData["id"])->first();
        $targetUser = User::where('id', $targetEmployee->user_id)->first();

        if (!$targetEmployee) {
            return response()->json([
                "success" => false,
                "message" => "Data tidak ditemukan!",
            ], 404);
        }

        if (!$targetUser) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!",
            ], 404);
        }

        $targetEmployee->delete();
        $targetUser->delete();

        return response()->json([
            "success" => true,
            "message" => "Data berhasil dihapus!",
            "data" => $targetEmployee
        ], 200);
    }
}

