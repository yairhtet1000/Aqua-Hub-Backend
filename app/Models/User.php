<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory; // 1. Import trait
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, SoftDeletes; // 2. Add trait here

    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'avatar',
        'bio',
        'role_id',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    // Relationships
    public function role()
    {
        return $this->belongsTo(Role::class);
    }

    public function tanks()
    {
        return $this->hasMany(Tank::class);
    }

    public function posts()
    {
        return $this->hasMany(Post::class);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    public function likedPosts()
    {
        return $this->belongsToMany(Post::class, 'likes');
    }

    public function savedPosts()
    {
        return $this->belongsToMany(Post::class, 'saved_posts');
    }

    public function bookmarkedPosts()
    {
        return $this->savedPosts();
    }

    public function followers()
    {
        return $this->belongsToMany(User::class, 'follows', 'following_id', 'follower_id');
    }

    public function following()
    {
        return $this->belongsToMany(User::class, 'follows', 'follower_id', 'following_id');
    }

    public function isFollowing(User $user): bool
    {
        return $this->following()->where('users.id', $user->id)->exists();
    }

    public function getAvatarAttribute($value)
    {
        return $value ? asset('storage/' . ltrim($value, '/')) : null;
    }
}