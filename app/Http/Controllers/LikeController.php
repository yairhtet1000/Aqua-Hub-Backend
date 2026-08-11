<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Notifications\PostLikedNotification;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class LikeController extends Controller
{
    public function toggleLike(Post $post): JsonResponse
    {
        $user = Auth::user();

        $changes = $user->likedPosts()->toggle($post->id);
        $liked = count($changes['attached']) > 0;

        if ($liked && $post->user_id !== $user->id) {
            $post->user->notify(new PostLikedNotification($post, $user));
        }

        return response()->json([
            'message' => $liked ? 'Post liked successfully.' : 'Post unliked successfully.',
            'is_liked' => $liked,
        ], 200);
    }
}