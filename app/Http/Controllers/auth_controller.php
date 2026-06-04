<?php

namespace App\Http\Controllers;

use App\Models\Em_log_in;
use App\Models\Employee;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\activity_log;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class auth_controller extends Controller
{
    //
    public function register(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Anda belum login",
            ]);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda bukan admin",
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "username" => "required|string|max:24|unique:users,username",
            "password" => "required|string|min:8",
            "email" => "required|email|unique:users,email",
            "role" => "sometimes|in:admin,employee",
        ], [
            "username.required" => "Username harus diisi!",
            "username.max" => "Username maksimal 24 karakter",
            "username.unique" => "Username sudah terdaftar!",
            "password.required" => "Password harus diisi!",
            "pasword.min" => "Buat password setidaknya 8 karakter",
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid",
            "email.unique" => "Email sudah terdaftar!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal mendaftar!",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        $data = User::create([
            "username" => $validatedData["username"],
            "password" => Hash::make($validatedData["password"]),
            "email" => $validatedData["email"],
            // "role" => $validatedData["role"],
        ]);

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Registrasi Akun',
            'description' => 'Registrasi akun ' . $validatedData["username"],
        ]);

        return response()->json([
            "success" => true,
            "message" => "Sukses membuat akun",
            "data" => $data,
        ], 201);

    }

    public function loginByEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "email" => "required|email",
            "password" => "required|string|min:8",
        ], [
            "email.email" => "Email tidak valid!",
            "email.required" => "Email harus diisi!",
            "password.required" => "Password wajib diisi",
            "password.min" => "Password tidak valid",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal login",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        if (
            Auth::attempt([
                "email" => $validatedData["email"],
                "password" => $validatedData["password"],
            ])
        ) {
            /** @var \App\Models\User $user */
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    "success" => false,
                    "message" => "User tidak ditemukan",
                ], 404);
            }

            if ($user->role == "admin") {
                $token = $user->createToken('token')->plainTextToken;

                activity_log::create([
                    'user_id' => $user->id,
                    'activity_type' => 'Login',
                    'description' => 'Login dengan Username',

                ]);

                return response()->json([
                    "success" => true,
                    "message" => "Sukses login",
                    "token" => $token,
                    "user_data" => $user,
                ], 200);
            }

            $token = $user->createToken('token')->plainTextToken;

            $data = User::where("email", $validatedData["email"])
                ->join('employee', 'employee.user_id', '=', 'users.id')
                ->join('division', 'division.id', '=', 'employee.division_id')
                ->join('point', 'point.employee_id', '=', 'employee.id')
                ->select(
                    'users.id as user_id',
                    'users.username as username',
                    'users.email as email',
                    'users.role as role',
                    'employee.company_id as id_perusahaan',
                    'employee.name as nama_lengkap',
                    'employee.phone_number as no_telp',
                    'employee.division_id as id_divisi',
                    'division.division_name as nama_divisi',
                    'employee.face_data as data_wajah',
                    'employee.profile_pic as foto_profil',
                    'point.point_value as poin',
                    'employee.logged_in as logged_in',
                    'employee.logged_out as logged_out',
                )
                ->get()
                ->map(function ($item) {
                    $item->data_wajah = json_decode($item->data_wajah);
                    return $item;
                })
                ->first()
            ;

            activity_log::create([
                'user_id' => $data->user_id,
                'activity_type' => 'Login',
                'description' => 'Login dengan Email',

            ]);

            return response()->json([
                'success' => true,
                'message' => 'Login berhasil',
                'token' => $token,
                'user_data' => $data,
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Login Gagal',
            ], 401);
        }
    }

    public function loginByUsername(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "username" => "required|max:24",
            "password" => "required|string|min:8",
        ], [
            "username.required" => "Username harus diisi!",
            "username.max" => "Username tidak valid",
            "password.required" => "Password wajib diisi",
            "password.min" => "Password tidak valid",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal login",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        if (
            Auth::attempt([
                "username" => $validatedData["username"],
                "password" => $validatedData["password"],
            ])
        ) {
            /** @var \App\Models\User $user */
            $user = Auth::user();

            if (!$user) {
                return response()->json([
                    "success" => false,
                    "message" => "User tidak ditemukan",
                ], 404);
            }

            if ($user->role == "admin") {
                $token = $user->createToken('token')->plainTextToken;

                activity_log::create([
                    'user_id' => $user->id,
                    'activity_type' => 'Login',
                    'description' => 'Login dengan Username',

                ]);

                return response()->json([
                    "success" => true,
                    "message" => "Sukses login",
                    "token" => $token,
                    "user_data" => $user,
                ], 200);
            }

            $token = $user->createToken('token')->plainTextToken;

            $data = User::where("username", $validatedData["username"])
                ->join('employee', 'employee.user_id', '=', 'users.id')
                ->join('division', 'division.id', '=', 'employee.division_id')
                ->join('point', 'point.employee_id', '=', 'employee.id')
                ->select(
                    'users.id as user_id',
                    'users.username as username',
                    'users.email as email',
                    'users.role as role',
                    'employee.company_id as id_perusahaan',
                    'employee.name as nama_lengkap',
                    'employee.phone_number as no_telp',
                    'employee.division_id as id_divisi',
                    'division.division_name as nama_divisi',
                    'employee.face_data as data_wajah',
                    'employee.profile_pic as foto_profil',
                    'point.point_value as poin',
                    'employee.logged_in as logged_in',
                    'employee.logged_out as logged_out',
                )
                ->get()
                ->map(function ($item) {
                    $item->data_wajah = json_decode($item->data_wajah);
                    return $item;
                })
                ->first()
            ;

            activity_log::create([
                'user_id' => $data->user_id,
                'activity_type' => 'Login',
                'description' => 'Login dengan Username',

            ]);

            return response()->json([
                'success' => true,
                'message' => 'Login berhasil',
                'token' => $token,
                'user_data' => $data,
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Login Gagal',
            ], 401);
        }
    }

    public function createAccount(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "username" => "required|string|max:24",
            "password" => "required|string|min:8",
            "email" => "required|email",
            "role" => "required|in:admin,employee",
        ], [
            "username.required" => "Username harus diisi!",
            "username.max" => "Username maksimal 24 karakter",
            "password.required" => "Password harus diisi!",
            "pasword.min" => "Buat password setidaknya 8 karakter",
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid",
            "role.required" => "Role harus diisi!",
            "role.in" => "Role tidak valid",
        ]);

        $validatedData = $validator->validated();

        $account = User::create([
            "username" => $validatedData["username"],
            "password" => Hash::make($validatedData["password"]),
            "email" => $validatedData["email"],
            "role" => $validatedData["role"],
        ]);

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Registrasi Akun',
            'description' => 'Regsitrasi akun ' . $validatedData["username"],
        ]);

        return response()->json([
            "success" => true,
            "message" => "Akun berhasil dibuat",
            "data" => $account
        ], 201);
    }

    public function editAccount(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!"
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
            "username" => "sometimes|string|max:24",
            "password" => "sometimes|string|min:8",
            "email" => "sometimes|email",
            "role" => "sometimes|in:admin,employee",
        ], [
            "id.required" => "ID harus diisi!",
            "id.exists" => "ID tidak valid!",
            "username.required" => "Username harus diisi!",
            "username.max" => "Username maksimal 24 karakter",
            "password.required" => "Password harus diisi!",
            "pasword.min" => "Buat password setidaknya 8 karakter",
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid",
            "role.required" => "Role harus diisi!",
            "role.in" => "Role tidak valid",
        ]);

        $validatedData = $validator->validated();

        $account = User::find($validatedData["id"]);

        $oldAccount = $account->toArray();

        if (!$account) {
            return response()->json([
                "success" => false,
                "message" => "Akun tidak ditemukan!"
            ], 404);
        }

        if (isset($validatedData["username"])) {
            $account->username = $validatedData["username"];
        }

        if (isset($validatedData["password"])) {
            $account->password = Hash::make($validatedData["password"]);
        }

        if (isset($validatedData["email"])) {
            $account->email = $validatedData["email"];
        }

        if (isset($validatedData["role"])) {
            $account->role = $validatedData["role"];
        }

        $account->save();

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Update Akun',
            'description' => 'Sunting akun untuk ' . $validatedData["username"],
        ]);

        return response()->json([
            "success" => true,
            "message" => "Akun berhasil diubah",
            "data" => $account,
            "old_data" => $oldAccount
        ], 200);

    }
}
