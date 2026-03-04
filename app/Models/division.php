<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Division extends Model
{
    protected $table = "division";
    protected $fillable = [
        "division_name",
        "checkin_time",
        "checkout_time",
        "tolerance",

    ];
    public $timestamps = true;

    public function employee() {
        return $this->hasMany(Employee::class);
    }

}
