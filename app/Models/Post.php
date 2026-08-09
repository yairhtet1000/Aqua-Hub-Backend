<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Post extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'category_id',
        'tank_id',
        'title',
        'content',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function tank()
    {
        return $this->belongsTo(Tank::class);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    public function tags()
    {
        return $this->belongsToMany(Tag::class, 'post_tags');
    }

    public function likes()
    {
        return $this->belongsToMany(User::class, 'likes');
    }

    public function images()
    {
        return $this->hasMany(Image::class);
    }

    public function reports()
    {
        return $this->morphMany(Report::class, 'reportable');
    }
}