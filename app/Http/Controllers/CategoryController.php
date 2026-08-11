<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoryRequest;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CategoryController extends Controller
{
    /**
     * List all categories with post counts.
     */
    public function index(Request $request)
    {
        $perPage = (int) $request->query('per_page', 10);
        $categories = Category::withCount('posts')->paginate($perPage);

        return response()->json($categories, 200);
    }

    /**
     * Store a new category. Restricted to Admin/Moderator.
     */
    public function store(CategoryRequest $request)
    {
        $this->authorizeRole();

        $validated = $request->validated();

        $category = Category::create($validated);

        return response()->json($category, 201);
    }

    /**
     * Update an existing category. Restricted to Admin/Moderator.
     */
    public function update(CategoryRequest $request, Category $category)
    {
        $this->authorizeRole();

        $validated = $request->validated();

        $category->update($validated);

        return response()->json($category, 200);
    }

    /**
     * Soft delete a category. Restricted to Admin/Moderator.
     */
    public function destroy(Category $category)
    {
        $this->authorizeRole();

        if ($category->posts_count > 0 || $category->posts()->exists()) {
            return response()->json([
                'message' => 'Cannot delete category with assigned posts. Please reassign or remove posts first.',
            ], 422);
        }

        $category->delete();

        return response()->json(null, 204);
    }

    /**
     * Ensure the authenticated user is Admin or Moderator.
     */
    private function authorizeRole(): void
    {
        $user = Auth::user();

        if (! $user->role || ! in_array($user->role->name, ['Admin', 'Moderator'])) {
            abort(403, 'Only Admin or Moderator can perform this action.');
        }
    }
}
