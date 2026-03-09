<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Point extends Model
{
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
}
