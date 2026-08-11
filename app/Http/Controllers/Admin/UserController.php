<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class UserController extends Controller
{
    /**
     * Paginated list of all users with roles loaded.
     */
    public function index()
    {
        $users = User::with('role')->paginate(15);

        return response()->json($users, 200);
    }

    /**
     * Update a user's role.
     */
    public function updateRole(User $user, Request $request)
    {
        $validated = $request->validate([
            'role_id' => [
                'required',
                'integer',
                Rule::exists('roles', 'id')->whereNull('deleted_at'),
            ],
        ]);

        $user->update(['role_id' => $validated['role_id']]);

        return response()->json([
            'message' => 'User role updated successfully.',
            'user' => $user->load('role'),
        ], 200);
    }
}
