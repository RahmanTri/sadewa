<?php

use App\Http\Controllers\division_controller;
use App\Http\Controllers\em_log_in_controller;
use App\Models\Division;
use App\Models\Em_log_in;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

//CRUD Division
Route::get('/division', [division_controller::class, 'index']);
Route::post('/division/store', [division_controller::class, 'store']);
Route::post('/division/update/{$id}', [division_controller::class, 'update']);
Route::post('/division/delete/{$id}', [division_controller::class, 'destroy']);

//CRUD Em_log_in
Route::get('/em-log-in', [em_log_in_controller::class, 'index']);
Route::post('/em-log-in/store', [em_log_in_controller::class, 'store']);
Route::post('/em-log-in/update/{$id}', [em_log_in_controller::class, 'update']);
Route::post('/em-log-in/delete/{$id}', [em_log_in_controller::class, 'destroy']);