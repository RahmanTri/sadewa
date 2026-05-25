<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class activity_log extends Model
{
    protected $table = 'activity_log';

    protected $fillable = [
        'user_id',
        'activity_type',
        'description',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
