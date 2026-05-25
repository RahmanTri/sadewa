<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class password_otp extends Model
{
    use HasFactory;

    protected $table = 'password_otps';

    protected $fillable = [
        'user_id',
        'otp', 
        'otp_expired_at',
        'validated',
    ];

    public $timestamps = true;

    public function employee() {
        return $this->belongsTo(Employee::class);
    }

    protected $casts = [
        'otp_expired_at' => 'datetime',
    ];
    //
}
