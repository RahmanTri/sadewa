<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Employee extends Model {

  protected $table = "employee";

  protected $fillable = [
    "user_id",
    "name",
    "division_id",
    "phone_number",
    "face_data",
  ];

  public $timestamp = true;

  public function division() {
    return $this->hasMany(division::class);
  }

  public function user() {
    return $this->belongsTo(user::class);
  }

  public function point() {
    return $this->belongsTo(point::class);
  }

  public function em_log_in() {
    return $this->belongsTo(em_log_in::class);
  }

  public function em_log_out() {
    return $this->belongsTo(em_log_out::class);
  }
}