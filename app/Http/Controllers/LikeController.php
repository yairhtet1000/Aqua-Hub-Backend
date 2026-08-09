<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class LikeController extends Controller
{
    public function toggleLike(Post $post): JsonResponse
    {
        $user = Auth::user();

        // toggle() handles attaching/detaching pivot records cleanly
        $changes = $user->likedPosts()->toggle($post->id);

        $liked = count($changes['attached']) > 0;

        return response()->json([
            'message' => $liked ? 'Post liked successfully.' : 'Post unliked successfully.',
            'is_liked' => $liked,
        ], 200);
    }
}