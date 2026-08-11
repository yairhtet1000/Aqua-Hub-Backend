<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class SavedPostController extends Controller
{
    public function save(Post $post): JsonResponse
    {
        $user = Auth::user();

        $user->savedPosts()->attach($post->id);

        return response()->json([
            'message' => 'Post saved successfully.',
            'is_saved' => true,
        ], 200);
    }

    public function unsave(Post $post): JsonResponse
    {
        $user = Auth::user();

        $user->savedPosts()->detach($post->id);

        return response()->json([
            'message' => 'Post unsaved successfully.',
            'is_saved' => false,
        ], 200);
    }
}
