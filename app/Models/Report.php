<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Report extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'reason',
        'status',
        'reportable_id',
        'reportable_type',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function reportable()
    {
        return $this->morphTo();
    }
}