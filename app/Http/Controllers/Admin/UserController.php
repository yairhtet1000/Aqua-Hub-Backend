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
    public function index(Request $request)
    {
        $query = User::with('role');

        if ($search = $request->get('search')) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('id', $search);
            });
        }

        $users = $query->paginate(15);

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

    /**
     * Update user account details (role, status, force_email_change).
     */
    public function update(Request $request, User $user)
    {
        $validated = $request->validate([
            'role_id' => [
                'nullable',
                'integer',
                Rule::exists('roles', 'id')->whereNull('deleted_at'),
            ],
            'status' => 'nullable|string|in:active,banned,suspended',
            'force_email_change' => 'nullable|boolean',
        ]);

        if ($request->has('role_id')) {
            $user->update(['role_id' => $validated['role_id']]);
        }

        if ($request->has('status')) {
            if ($validated['status'] === 'banned') {
                $user->delete();
            } else {
                $user->update(['status' => $validated['status']]);
            }
        }

        if ($request->has('force_email_change')) {
            $user->update(['force_email_change' => (bool) $validated['force_email_change']]);
        }

        return response()->json([
            'message' => 'User updated successfully.',
            'user' => $user->load('role'),
        ], 200);
    }
}
