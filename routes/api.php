<?php

use App\Http\Controllers\auth_controller;
use App\Http\Controllers\division_controller;
use App\Http\Controllers\em_log_in_controller;
use App\Http\Controllers\employee_controller;
use App\Models\Division;
use App\Models\Em_log_in;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

//AUTH
Route::post('/register', [auth_controller::class, 'register']);
Route::post('/login', [auth_controller::class, 'login']);

//CRUD Division
Route::get('/division', [division_controller::class, 'index']);
Route::post('/division/store', [division_controller::class, 'store']);
Route::post('/division/update/{id}', [division_controller::class, 'update']);
Route::post('/division/delete/{id}', [division_controller::class, 'destroy']);

//CRUD Em_log_in
Route::get('/em-log-in', [em_log_in_controller::class, 'index']);
Route::post('/em-log-in/store', [em_log_in_controller::class, 'store']);
Route::post('/em-log-in/update/{id}', [em_log_in_controller::class, 'update']);
Route::post('/em-log-in/delete/{id}', [em_log_in_controller::class, 'destroy']);

Route::middleware("auth:sanctum")->group(function () {
    Route::post('/em-login/chkin', [em_log_in_controller::class, 'check_in']);
});

//CRUD Employee
Route::get('/employee', [employee_controller::class, 'index']);
Route::post('/employee/add', [employee_controller::class, 'store']);
Route::post('/employee/update/{id}', [employee_controller::class, 'update']);
Route::post('/employee/delete/{id}', [employee_controller::class, 'destroy']);

//DST