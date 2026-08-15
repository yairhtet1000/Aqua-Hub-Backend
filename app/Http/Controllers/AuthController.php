<?php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    /**
     * Register a new user and issue a Sanctum token.
     */
    public function register(Request $request)
    {
        // Validate registration data
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email',
            'password' => 'required|string|min:8|confirmed',
            'phone' => 'nullable|string|max:20',
            'avatar' => 'nullable|string|max:500',
        ]);

        // Assign default 'Member' role (role_id = 3)
        $memberRole = Role::where('name', 'Member')->first();
        $roleId = $memberRole ? $memberRole->id : 3;

        // Create user
        $user = User::create([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => Hash::make($validatedData['password']),
            'phone' => $validatedData['phone'] ?? null,
            'avatar' => $validatedData['avatar'] ?? null,
            'role_id' => $roleId,
        ]);

        // Generate Sanctum token
        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
            'message' => 'User registered successfully.',
            'user' => $user->load('role'),
            'token' => $token,
        ], 201);
    }

    /**
     * Authenticate user and issue a new Sanctum token.
     * Old tokens are invalidated on each login.
     */
    public function login(Request $request)
    {
        $validatedData = $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $validatedData['email'])->first();

        if (!$user || !Hash::check($validatedData['password'], $user->password)) {
            return response()->json([
                'message' => 'Invalid email or password.',
            ], 401);
        }

        // Invalidate all existing tokens before creating a new one
        $user->tokens()->delete();

        // Generate new Sanctum token
        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
            'message' => 'Login successful.',
            'user' => $user->load('role'),
            'token' => $token,
        ], 200);
    }

    /**
     * Revoke the current access token (logout).
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logged out successfully.',
        ], 200);
    }

    /**
     * Return the currently authenticated user with role and tanks loaded.
     */
    public function me(Request $request)
    {
        $user = $request->user()->load('role', 'tanks')->loadCount('posts', 'comments', 'followers', 'following');

        return response()->json([
            'user' => $user,
        ], 200);
    }
}
