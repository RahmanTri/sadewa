<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Em_log_out extends Model
{
  protected $table = "employee_log_out";

  protected $fillable = [
    "employee_id",
    "logout_time",
    "status",
  ];

  public $timestamps = true;

  public function employee()
  {
    return $this->hasMany(Employee::class);
  }

  public function scopeDay($query, $day, $employee_id)
  {
    return $query->where('created_at', '>=', now()->subDays($day))->where('employee_id', $employee_id)->get();
  }
}