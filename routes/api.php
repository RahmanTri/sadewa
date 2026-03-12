<?php

use App\Http\Controllers\auth_controller;
use App\Http\Controllers\dashboard_controller;
use App\Http\Controllers\division_controller;
use App\Http\Controllers\em_log_in_controller;
use App\Http\Controllers\em_log_out_controller;
use App\Http\Controllers\employee_controller;
use App\Http\Controllers\point_controller;
use App\Http\Controllers\user_controller;
use App\Http\Controllers\history_log_controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

//AUTH
Route::post('/register', [auth_controller::class, 'register']);
Route::post('/login', [auth_controller::class, 'login']);

//LOGIN REQUIRED
Route::middleware("auth:sanctum")->group(function () {

    //CRUD Division
    Route::get('/division', [division_controller::class, 'index']);
    Route::post('/division/store', [division_controller::class, 'store']);
    Route::put('/division/update/{id}', [division_controller::class, 'update']);
    Route::delete('/duri: ivision/delete/{id}', [division_controller::class, 'destroy']);

    //CRUD Em_log_in
    Route::get('/em-log-in', [em_log_in_controller::class, 'index']);
    Route::post('/em-log-in/store', [em_log_in_controller::class, 'store']);
    Route::put('/em-log-in/update/{id}', [em_log_in_controller::class, 'update']);
    Route::delete('/em-log-in/delete/{id}', [em_log_in_controller::class, 'destroy']);

    //CRUD Em_log_out
    Route::get('/em-log-out', [em_log_out_controller::class, 'index']);
    Route::post('/em-log-out/store', [em_log_out_controller::class, 'store']);
    Route::put('/em-log-out/update/{id}', [em_log_out_controller::class, 'update']);
    Route::delete('/em-log-out/delete/{id}', [em_log_out_controller::class, 'delete']);

    //CRUD Employee
    Route::get('/employee', [employee_controller::class, 'index']);
    Route::post('/employee/add', [employee_controller::class, 'store']);
    Route::put('/employee/update', [employee_controller::class, 'update']);
    Route::delete('/employee/delete/{id}', [employee_controller::class, 'destroy']);
    Route::delete('/employee/delete', [employee_controller::class,'deleteAccount']);
    Route::post('/employee/profile',[employee_controller::class,'updateProfile']);

    //CRUD Point
    Route::get('/point', [point_controller::class, 'index']);
    Route::post('/point/store', [point_controller::class, 'store']);
    Route::put('/point/update/{id}', [point_controller::class, 'update']);
    Route::delete('/point/delete/{id}', [point_controller::class, 'delete']);


    //CHECK IN
    Route::post('/em-log/chkin', [em_log_in_controller::class, 'check_in']);

    //CHECK OUT
    Route::post('/em-log/chkout', [em_log_out_controller::class, 'check_out']);

    //USER
    Route::get('/user', [user_controller::class, 'index']);

    //EM REGISTER (ADMIN ONLY)
    Route::post('/employee/register', [employee_controller::class, 'emregister']);

    //DASHBOARD
    Route::get('/dashboard/fetch', [dashboard_controller::class, 'fetch']);
    Route::get('/dashboard/log', [history_log_controller::class, 'index']);
    
    //MONITOR
    Route::post('/monitor/get', [dashboard_controller::class, 'monitorAll']);
    Route::post('/monitor/div', [dashboard_controller::class,'monitorDivision']);
});