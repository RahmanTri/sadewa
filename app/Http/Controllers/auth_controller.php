<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class auth_controller extends Controller
{
    //
    public function register(Request $request)
    {
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

        return response()->json([
            "success" => true,
            "message" => "Sukses membuat akun",
            "data" => $data,
        ], 201);
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "email" => "required|email",
            "username" => "required|max:24",
            "password" => "required|string|min:8",
        ], [
            "email.email" => "Email tidak valid!",
            "email.required" => "Email harus diisi!",
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
                "email" => $validatedData["email"],
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
            $token = $user->createToken('token')->plainTextToken;

            return response()->json([
                'success' => true,
                'message' => 'Login berhasil',
                'token' => $token,
                'user' => $user,
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Login Gagal',
            ], 401);
        }
    }
}
