<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Post;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class StatsController extends Controller
{
    public function pulse(): JsonResponse
    {
        return response()->json([
            'active_today' => User::whereHas('posts', fn($q) => $q->where('created_at', '>=', now()->subDay()))
                ->orWhereHas('comments', fn($q) => $q->where('created_at', '>=', now()->subDay()))
                ->count(),
            'posts_today' => Post::where('created_at', '>=', now()->subDay())->count(),
            'total_posts' => Post::count(),
            'total_members' => User::count(),
            'top_category' => Category::withCount('posts')
                ->orderByDesc('posts_count')
                ->first()?->name ?? 'General',
        ]);
    }
}
