<?php

namespace App\Models;

use Carbon\Traits\Timestamp;
use Illuminate\Database\Eloquent\Model;

class notices extends Model
{
    //
    protected $table = 'notices';

    protected $fillable = [
        'title',
        'content',
        'employee_id',
        'is_read'
    ];

    public $timestamps = true;

    public function employee()
    {
        return $this->belongsTo(employee::class);
    }

}
