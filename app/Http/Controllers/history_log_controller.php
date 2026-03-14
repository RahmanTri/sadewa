<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Em_log_in;
use App\Models\Em_log_out;
use App\Models\Employee;
use App\Models\Division;



class history_log_controller extends Controller
{
    public function index()
    {

        $query = Employee::leftJoin(
            'employee_log_in',
            'employee_log_in.employee_id',
            '=',
            'employee.id'
        )
            ->leftJoin('employee_log_out', 'employee_log_out.employee_id', '=', 'employee.id')
            ->join('division', 'employee.division_id', '=', 'division.id')
            ->select(
                'employee_log_in.created_at as date',
                'employee.id',
                'employee.company_id',
                'employee.name as employee_name',
                'division.division_name',
                'employee_log_in.login_time as login',
                'employee_log_in.status as login_status',
                'employee_log_out.logout_time as logout_time',
                'employee_log_out.status as logout_status'
            );


        $data = $query->get()
            ->map(function ($item) {
                $item->date = Carbon::parse($item->date)->toDateString();
                return $item;
            });

        return response()->json([
            "success" => true,
            "message" => "data berhasil di dapatkan",
            "data" => $data
        ]);


    }
}
