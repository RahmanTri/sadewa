<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Employee extends Model
{

  use HasFactory;
  protected $table = "employee";

  protected $fillable = [
    "user_id",
    "name",
    "company_id",
    "division_id",
    "phone_number",
    "face_data",
    "logged_in",
    "logged_out"
  ];

  public $timestamp = true;

  public function division()
  {
    return $this->belongsTo(division::class, 'division_id', 'id');
  }

  public function user()
  {
    return $this->belongsTo(user::class);
  }

  public function point()
  {
    return $this->belongsTo(point::class);
  }

  public function em_log_in()
  {
    return $this->belongsTo(em_log_in::class);
  }

  public function em_log_out()
  {
    return $this->belongsTo(em_log_out::class);
  }
}