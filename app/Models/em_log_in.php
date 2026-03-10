<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Em_log_in extends Model
{
    use HasFactory;
    protected $table = "employee_log_in";

    protected $fillable = [
        "employee_id",
        "login_time",
        "status",

    ];

    public $timestamps = true;

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }

    public function scopeDay($query, $day, $employee_id)
    {
        return $query->where('created_at', '>=', now()->subDays($day))->where('employee_id',$employee_id)->get();
    }

    public function scopeLateCount($query, $employee_id) {
        return $query->where('created_at','>=', now()->subDays(30))->where('employee_id',$employee_id)->where('status', 'late')->count();
    }
}