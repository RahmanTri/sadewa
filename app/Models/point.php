<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Point extends Model
{
    protected $table = 'point';

    protected $fillable =
        [
            'employee_id',
            'checkin_point',
            'early_checkout_point',
            'late_point'
        ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }

    public $timestamps = true;
}
