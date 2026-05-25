<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\activity_log;
use Carbon\Carbon;

class activityLog_controller extends Controller
{
    public function fetchActivityLog()
    {
        Carbon::setLocale('id');
        $user = Auth::user();
        $data = activity_log::where('user_id', $user->id)->orderByDesc('created_at')->get();

        return response()->json([
            "success" => true,
            "data" => $data,
        ], 200);

    }
}
