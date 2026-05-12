<?php

namespace App\Http\Controllers;

use App\Models\Division;
use App\Models\Em_log_in;
use Auth;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

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

    public function getUsers()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!",
            ], 200);
        }

        $users = DB::table('users')
            ->select(
                'id',
                'username',
                'email',
                'role',
            )
            ->orderBy('username', 'asc')
            ->get()
        ;

        return response()->json([
            "success" => true,
            "data" => $users,
        ], 200);

    }

    public function editUserData(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!",
            ], 200);
        }

        $validator = Validator::make($request->all(), [
            'user_id' => 'required|exists:users,id',
            'username' => 'sometimes|string|max:24',
            'password' => 'sometimes|string|min:8',
            'email' => 'sometimes|email',
            'role' => 'sometimes|in:admin,employee',
        ], [
            "username.required" => "Username harus diisi!",
            "username.max" => "Username maksimal 24 karakter",
            "password.required" => "Password harus diisi!",
            "pasword.min" => "Buat password setidaknya 8 karakter",
            "email.required" => "Email harus diisi!",
            "email.email" => "Email tidak valid",
            "role.in" => "Role tidak valid!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal mengubah data!",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        $targetuser = User::find($validatedData['user_id']);

        if (!$targetuser) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!",
            ], 422);
        }

        if (isset($validatedData['username'])) {
            $targetuser->username = $validatedData['username'];
        }

        if (isset($validatedData['password'])) {
            $targetuser->password = Hash::make($validatedData['password']);
        }

        if (isset($validatedData['email'])) {
            $targetuser->email = $validatedData['email'];
        }

        if (isset($validatedData['role'])) {
            $targetuser->role = $validatedData['role'];
        }

        $targetuser->save();

        return response()->json([
            "success" => true,
            "message" => "Berhasil mengubah data!",
        ], 200);

    }

    public function changeUserPassword(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $validator = Validator::make($request->all(), [
            'old_password' => 'required|string|min:8',
            'password' => 'required|string|min:8',
        ], [
            "old_password.required" => "Password lama harus diisi!",
            "password.required" => "Password harus diisi!",
            "password.min" => "Buat password setidaknya 8 karakter",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal mengubah password!",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        if (!Hash::check($validatedData['old_password'], $user->password)) {
            return response()->json([
                "success" => false,
                "message" => "Password tidak valid / Password lama tidak sesuai!",
            ], 422);
        }

        $user->password = Hash::make($validatedData['password']);
        $user->save();

        return response()->json([
            "success" => true,
            "message" => "Berhasil mengubah password!",
        ], 200);
    }

    public function createNewAccount(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!",
            ], 200);
        }

        $validator = Validator::make($request->all(), [
            'username' => 'required|string|max:24',
            'password' => 'required|string|min:8',
            'email' => 'required|email',
            'role' => 'required|in:admin,employee',
        ], [
            'username.required' => 'Username harus diisi!',
            'username.max' => 'Username maksimal 24 karakter',
            'password.required' => 'Password harus diisi!',
            'pasword.min' => 'Buat password setidaknya 8 karakter',
            'email.required' => 'Email harus diisi!',
            'email.email' => 'Email tidak valid',
            'role.in' => 'Role tidak valid!',
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal mendaftar!",
                "error" => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        $newUser = User::create([
            'username' => $validatedData['username'],
            'password' => Hash::make($validatedData['password']),
            'email' => $validatedData['email'],
            'role' => $validatedData['role'],
        ]);
        
        return response()->json([
            "success" => true,
            "message" => "Berhasil mendaftar!",
            "data" => $newUser,
        ], 200);
    }
}
