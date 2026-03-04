<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Em_log_in extends Model
{
    protected $table = "employee_log_in";

    protected $fillable = [
        "employee_id",
        "login_time",
        "status",

    ];

    public $timestamps = true;

    public function employee() {
        return $this->belongsTo(Employee::class);
    }
}