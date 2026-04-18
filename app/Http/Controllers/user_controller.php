<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use App\Models\User;

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
}
