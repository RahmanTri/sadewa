<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Point extends Model
{

    use HasFactory;
    protected $table = 'point';

    protected $fillable =
        [
            'employee_id',
            'point_value',
            'psitive_streak',
            'negative_streak'
        ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }

    public $timestamps = true;

    protected function casts(): array
    {
        return [
            'created_at' => 'date:Y-m-d',
            'updated_at' => 'date:Y-m-d',
        ];
    }
}
