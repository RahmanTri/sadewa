<?php

namespace App\Models;

use Carbon\Traits\Timestamp;
use Illuminate\Database\Eloquent\Model;

class point_log extends Model
{
    //
    protected $table = 'point_log';

    protected $fillable = [
        'employee_id',
        'previous_value',
        'added_value',
        'source'
    ];

    public $timestamp = true;

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
}
