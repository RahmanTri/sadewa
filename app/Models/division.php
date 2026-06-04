<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Division extends Model
{
    protected $table = "division";
    protected $fillable = [
        "division_name",
        "office",
        "address",
        "checkin_time",
        "checkout_time",
        "tolerance",
        "r_tolerance",
        "latitude",
        "longitude",

    ];
    public $timestamps = true;

    public function employee() {
        return $this->hasMany(Employee::class);
    }

    protected function casts(): array
    {
        return [
            'created_at'=> 'date:Y-m-d',
            'updated_at'=> 'date:Y-m-d',
        ];
    }
}
