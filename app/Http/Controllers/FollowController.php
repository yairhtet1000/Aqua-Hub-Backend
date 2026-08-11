<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class FollowController extends Controller
{
    public function follow(User $user): JsonResponse
    {
        $authUser = Auth::user();

        if ($user->id === $authUser->id) {
            return response()->json([
                'message' => 'You cannot follow yourself.',
            ], 422);
        }

        $authUser->following()->syncWithoutDetaching([$user->id]);

        return response()->json([
            'message' => 'Followed successfully.',
            'is_following' => true,
            'is_friend' => $user->followers()->where('users.id', $authUser->id)->exists(),
        ], 200);
    }

    public function unfollow(User $user): JsonResponse
    {
        $authUser = Auth::user();

        if ($user->id === $authUser->id) {
            return response()->json([
                'message' => 'You cannot unfollow yourself.',
            ], 422);
        }

        $authUser->following()->detach($user->id);

        return response()->json([
            'message' => 'Unfollowed successfully.',
            'is_following' => false,
            'is_friend' => false,
        ], 200);
    }

    public function followers(User $user)
    {
        $followers = $user->followers()->paginate(20);

        return response()->json($followers, 200);
    }

    public function following(User $user)
    {
        $following = $user->following()->paginate(20);

        return response()->json($following, 200);
    }
}
