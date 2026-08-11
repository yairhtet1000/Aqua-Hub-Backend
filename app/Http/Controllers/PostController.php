<?php

namespace App\Http\Controllers;

use App\Http\Requests\PostRequest;
use App\Models\Image;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PostController extends Controller
{
    public function index(Request $request)
    {
        $query = Post::with(['user', 'category', 'tags', 'tank', 'images', 'likes']);

        if ($request->has('user_id')) {
            $query->where('user_id', $request->user_id);
        }

        $posts = $query->latest()->paginate(10);

        return response()->json($posts, 200);
    }

    public function store(PostRequest $request)
    {
        $validated = $request->validated();

        $post = Post::create([
            'title' => $validated['title'],
            'content' => $validated['content'],
            'status' => $validated['status'],
            'category_id' => $validated['category_id'],
            'tank_id' => $validated['tank_id'] ?? null,
            'user_id' => Auth::id(),
        ]);

        if (! empty($validated['tag_ids'])) {
            $post->tags()->sync($validated['tag_ids']);
        }

        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $file) {
                $path = $file->store('posts', 'public');
                Image::create([
                    'image_path' => $path, // Fixed column name
                    'post_id' => $post->id,
                ]);
            }
        }

        return response()->json($post->load(['tags', 'images', 'tank', 'category']), 201);
    }

    public function show(Post $post)
    {
        $post->load(['user', 'category', 'tags', 'tank', 'images', 'comments.parent', 'comments.user']);

        return response()->json($post, 200);
    }

    public function update(PostRequest $request, Post $post)
    {
        if ($post->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validated();

        $post->update($validated);

        if (! empty($validated['tag_ids'])) {
            $post->tags()->sync($validated['tag_ids']);
        }

        return response()->json($post->load(['tags', 'images', 'tank', 'category']), 200);
    }

    public function destroy(Post $post)
    {
        if ($post->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $post->delete();

        return response()->json(null, 204);
    }
}
