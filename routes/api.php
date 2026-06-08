<?php

use App\Http\Controllers\auth_controller;
use App\Http\Controllers\dashboard_controller;
use App\Http\Controllers\division_controller;
use App\Http\Controllers\em_log_in_controller;
use App\Http\Controllers\em_log_out_controller;
use App\Http\Controllers\employee_controller;
use App\Http\Controllers\notices_controller;
use App\Http\Controllers\point_controller;
use App\Http\Controllers\user_controller;
use App\Http\Controllers\history_log_controller;
use App\Http\Controllers\export_controller;
use App\Http\Controllers\point_log_controller;
use App\Http\Controllers\devLogin_controller;
use App\Http\Controllers\activityLog_controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

//AUTH
Route::post('/register', [auth_controller::class, 'register']);
Route::post('/email-login', [auth_controller::class, 'loginByEmail']);
Route::post('/username-login', [auth_controller::class, 'loginByUsername']);

//Forgot Password
Route::post('/employee/send-otp', [employee_controller::class, 'sendOtpForgotPassword']);
Route::post('/employee/verify-otp', [employee_controller::class, 'verifyOtpPassword']);
Route::post('/employee/verify-pw', [employee_controller::class, 'verifyPassword']);

//LOGIN REQUIRED
Route::middleware("auth:sanctum")->group(function () {

    //CRUD Division
    Route::get('/division', [division_controller::class, 'index']);
    Route::post('/division/store', [division_controller::class, 'store']);
    Route::put('/division/update/{id}', [division_controller::class, 'update']);
    Route::delete('/division/delete/{id}', [division_controller::class, 'destroy']);

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
    Route::delete('/employee/delete', [employee_controller::class, 'deleteAccount']);
    Route::post('/employee/profile', [employee_controller::class, 'updateProfile']);
    Route::post('/employee/regface', [employee_controller::class, 'regFace']);
    Route::get('/employee/leaderboard', [employee_controller::class, 'leaderboard']);

    //CRUD Point
    Route::get('/point', [point_controller::class, 'index']);
    Route::post('/point/store', [point_controller::class, 'store']);
    Route::put('/point/update/{id}', [point_controller::class, 'update']);
    Route::delete('/point/delete/{id}', [point_controller::class, 'delete']);
    Route::get('/point/under-point', [point_controller::class, 'getUnderPoint']);


    //CHECK IN
    Route::post('/em-log/chkin', [em_log_in_controller::class, 'check_in']);

    //CHECK OUT
    Route::post('/em-log/chkout', [em_log_out_controller::class, 'check_out']);

    //USER
    Route::get('/user', [user_controller::class, 'index']);
    Route::get('/user/get-latest', [user_controller::class, 'getLatestLogin']);
    Route::get('/user/get-division', [user_controller::class, 'getUserDivision']);
    Route::get('/user/fetch', [user_controller::class, 'fetchUser']);

    //EM REGISTER (ADMIN ONLY)
    Route::post('/employee/register', [employee_controller::class, 'emregister']);

    //DASHBOARD
    Route::get('/dashboard/fetch', [dashboard_controller::class, 'fetch']);
    Route::get('/dashboard/log', [history_log_controller::class, 'index']);

    //MONITOR
    Route::post('/monitor/get', [dashboard_controller::class, 'monitorAll']);
    Route::post('/monitor/div', [dashboard_controller::class, 'monitorDivision']);

    //EXPORT
    Route::get('/export/all', [export_controller::class, 'allRecap']);
    Route::post('/export/custom', [export_controller::class, 'customRecap']);

    // Fetch History
    Route::get('/fetch-history', [history_log_controller::class, 'fetch_histories']);
    // Fetch Employee Data
    Route::get('/employee/get-data', [employee_controller::class, 'fetchEmployeeData']);

    //Account (Admin Only)
    Route::post('/create-account', [auth_controller::class, 'createAccount']);
    Route::post('/edit-account', [auth_controller::class, 'editAccount']);

    //Division (Edit is Admin only)
    Route::get('division/get-data', [division_controller::class, 'getDivision']);
    Route::post('division/edit', [division_controller::class, 'editDivision']);
    Route::post('division/get-id', [division_controller::class, 'getDivisionById']);
    Route::post('division/create', [division_controller::class, 'addNewDivision']);
    Route::post('division/delete', [division_controller::class, 'deleteDivision']);

    //Employee Data (Admin)
    Route::post('/employee/reset-faces', [employee_controller::class, 'resetFaceData']);
    Route::post('/employee/reset-pw', [employee_controller::class, 'resetUserPW']);
    Route::post('/employee/edit', [employee_controller::class, 'editEmployee']);
    Route::post('/employee/clear-profile', [employee_controller::class, 'clearProfilePics']);
    Route::post('/employee/delete', [employee_controller::class, 'deleteEmployee']);
    Route::post('/employee/get-div', [employee_controller::class, 'getEmByDiv']);

    //User Data (Admin)
    Route::get('/user/get-data', [user_controller::class, 'getUsers']);
    Route::post('/user/edit-data', [user_controller::class, 'editUserData']);
    Route::post('/user/create', [user_controller::class, 'createNewAccount']);
    Route::post('/user/delete', [user_controller::class, 'deleteAccount']);

    //User Change PW
    Route::post('/user/change-pw', [user_controller::class, 'changeUserPassword']);

    //Notices
    Route::get('/notices/get-data', [notices_controller::class, 'getNotices']);
    Route::post('/notices/read', [notices_controller::class, 'readNotice']);

    //Fetch Pont History
    Route::get('/point/get-history', [point_log_controller::class, 'getData']);
    Route::get('/profile', [user_controller::class, 'profile']);

    //Activity Log
    Route::get('/activity-log', [activityLog_controller::class, 'fetchActivityLog']);
});