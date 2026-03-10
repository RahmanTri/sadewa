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
    return $this->hasMany(Employee::class);
  }
}