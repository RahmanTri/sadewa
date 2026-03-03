<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class division extends Model
{
    //
    protected $table = "division";
    protected $fillable = [
        "divison_name",
        "checkin_time",
        "checkout_time",
        "tolerance",

    ];
    public $timestamps = true;

    public function division() {
        return $this->belongsTo(Employee::class);
    }

}
