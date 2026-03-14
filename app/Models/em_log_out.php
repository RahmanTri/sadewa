<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Em_log_out extends Model
{

  use HasFactory;
  protected $table = "employee_log_out";

  protected $fillable = [
    "employee_id",
    "logout_time",
    "status",
  ];

  public $timestamps = true;

  public function employee()
  {
    return $this->belongsTo(Employee::class);
  }

  public function scopeDay($query, $day, $employee_id)
  {
    return $query->where('created_at', '>=', now()->subDays($day))->where('employee_id', $employee_id)->get();
  }

  protected function casts(): array
  {
    return [
      'created_at' => 'date:Y-m-d',
      'updated_at' => 'date:Y-m-d',
    ];
  }
}