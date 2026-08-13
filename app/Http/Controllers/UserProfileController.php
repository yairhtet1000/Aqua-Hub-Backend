<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class UserProfileController extends Controller
{
    public function update(Request $request)
    {
        $user = Auth::user();

        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'nullable|string|max:20',
            'bio' => 'nullable|string|max:1000',
            'avatar' => 'nullable',
            'current_password' => 'nullable|required_with:password|string',
            'password' => 'nullable|string|min:8|confirmed',
        ]);

        if ($request->hasFile('avatar')) {
            $request->validate([
                'avatar' => 'file|image|max:2048',
            ]);

            if ($user->avatar && Storage::disk('public')->exists($user->avatar)) {
                Storage::disk('public')->delete($user->avatar);
            }

            $validatedData['avatar'] = $request->file('avatar')->store('avatars', 'public');
        }

        if ($request->filled('password')) {
            if (! $request->filled('current_password') || ! Hash::check($validatedData['current_password'], $user->password)) {
                return response()->json([
                    'message' => 'The provided current password does not match your current password.',
                ], 422);
            }

            $validatedData['password'] = Hash::make($validatedData['password']);
        } else {
            unset($validatedData['password'], $validatedData['password_confirmation'], $validatedData['current_password']);
        }

        $user->update($validatedData);

        return response()->json([
            'message' => 'Profile updated successfully.',
            'user' => $user->fresh()->load('role'),
        ], 200);
    }

    public function savedPosts(Request $request)
    {
        $user = Auth::user();

        $posts = $user->savedPosts()
            ->with(['user', 'category', 'tags', 'tank', 'images', 'likes', 'savedByUsers' => fn ($q) => $q->where('user_id', $user->id)])
            ->latest()
            ->paginate(10);

        return response()->json($posts, 200);
    }

    public function updatePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required|string',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = Auth::user();

        if (! Hash::check($request->current_password, $user->password)) {
            return response()->json([
                'message' => 'The provided current password does not match your current password.',
            ], 422);
        }

        $user->update([
            'password' => Hash::make($request->password),
        ]);

        return response()->json([
            'message' => 'Password updated successfully.',
            'user' => $user->fresh()->load('role'),
        ], 200);
    }

    public function topContributors()
    {
        $contributors = User::withCount(['posts', 'comments'])
            ->get()
            ->map(function ($user) {
                $user->activity_score = $user->posts_count + $user->comments_count;

                return $user;
            })
            ->sortByDesc('activity_score')
            ->take(5)
            ->values();

        return response()->json($contributors);
    }

    public function show($id)
    {
        $authId = Auth::id();
        $user = User::with('role')->withCount('posts', 'comments', 'followers', 'following')->findOrFail($id);

        $user->is_following = $authId && $authId !== $user->id
            ? $user->followers()->where('follower_id', $authId)->exists()
            : false;

        return response()->json([
            'user' => $user,
        ], 200);
    }
}
