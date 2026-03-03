<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class em_log_in extends Model
{
    protected $table = "employee_log_in";

    protected $fillable = [
        "karyawan_id",
        "time",
        "status",

    ];

    public $timestamps = true;

    public function employee() {
        return $this->hasMany(Employee::class);
    }
}