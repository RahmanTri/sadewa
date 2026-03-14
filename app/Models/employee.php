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
    return $this->hasMany(em_log_in::class, 'employee_id', 'id');
  }

  public function em_log_out()
  {
    return $this->hasMany(em_log_out::class, 'employee_id', 'id');
  }

  protected function casts(): array
  {
    return [
      'created_at' => 'date:Y-m-d',
      'updated_at' => 'date:Y-m-d',
    ];
  }

  public function scopeGetByDiv($query, $div_id, $day)
  {
    $query->where('division_id', '=', $div_id)
      ->leftJoin('employee_log_in', 'employee_log_in.employee_id', '=', 'employee.id')
      ->where('employee_log_in.created_at', '>=', now()->subDays($day))
      ->leftJoin('employee_log_out', 'employee_log_out.employee_id', '=', 'employee.id')
      ->where('employee_log_out.created_at', '>=', now()->subDays($day))
      ->join('division', 'division.id', '=', 'employee.division_id')
      ->selectRaw('DATE(employee_log_in.created_at) as date')
      ->addSelect(
        'employee.name as employee_name',
        'employee.id as employee_id',
        'division.division_name as division',
        'employee.company_id as company_id',
        'employee_log_in.login_time as login',
        'employee_log_in.status as login_status',
        'employee_log_out.logout_time as logout',
        'employee_log_out.status as logout_status',
      );
  }

  public function scopeGetAll($query, $day)
  {
    $query
      ->leftJoin('employee_log_in', 'employee_log_in.employee_id', '=', 'employee.id')
      ->where('employee_log_in.created_at', '>=', now()->subDays($day))
      ->leftJoin('employee_log_out', 'employee_log_out.employee_id', '=', 'employee.id')
      ->where('employee_log_out.created_at', '>=', now()->subDays($day))
      ->join('division', 'division.id', '=', 'employee.division_id')
      ->selectRaw('DATE(employee_log_in.created_at) as date')
      ->addSelect(
        'employee.name as employee_name',
        'employee.id as employee_id',
        'division.division_name as division',
        'employee.company_id as company_id',
        'employee_log_in.login_time as login',
        'employee_log_in.status as login_status',
        'employee_log_out.logout_time as logout',
        'employee_log_out.status as logout_status',
      );
  }
}