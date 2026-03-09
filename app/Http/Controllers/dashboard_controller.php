<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;

class dashboard_controller extends Controller
{
    //
    public function fetch() {
        $user = Auth::user();

        $employee = Employee::where("user_id", $user->id)->first();
        $division = Division::where("user_id", $user->id)->first();
        
    }
}
