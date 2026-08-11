<?php

namespace App\Http\Controllers;

use App\Http\Requests\PostRequest;
use App\Models\Image;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class PostController extends Controller
{
    public function index(Request $request)
    {
        $query = Post::with(['user', 'category', 'tags', 'tank', 'images', 'likes']);

        if ($request->has('user_id')) {
            $query->where('user_id', $request->user_id);
        }

        if ($search = $request->get('q')) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('content', 'like', "%{$search}%")
                  ->orWhereHas('user', function ($q2) use ($search) {
                      $q2->where('name', 'like', "%{$search}%");
                  })
                  ->orWhereHas('category', function ($q2) use ($search) {
                      $q2->where('name', 'like', "%{$search}%");
                  })
                  ->orWhereHas('tags', function ($q2) use ($search) {
                      $q2->where('name', 'like', "%{$search}%");
                  });
            });
        }

        $posts = $query->latest()->paginate(10);

        return response()->json($posts, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'status' => 'required|in:draft,published,archived',
            'category_id' => 'required|exists:categories,id',
            'tank_id' => 'nullable|exists:tanks,id',
            'tag_ids' => 'nullable|array',
            'tag_ids.*' => 'exists:tags,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048',
            'images' => 'nullable|array',
            'images.*' => 'image|mimes:jpeg,png,jpg,gif,webp|max:5120',
        ]);

        $post = Post::create([
            'title' => $request->title,
            'content' => $request->content,
            'status' => $request->status,
            'category_id' => $request->category_id,
            'tank_id' => $request->tank_id ?? null,
            'user_id' => Auth::id(),
        ]);

        if (! empty($request->tag_ids)) {
            $post->tags()->sync($request->tag_ids);
        }

        $imagePaths = [];

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('posts', 'public');
            $imagePaths[] = $path;
        }

        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $file) {
                $imagePaths[] = $file->store('posts', 'public');
            }
        }

        foreach ($imagePaths as $path) {
            Image::create([
                'image_path' => $path,
                'post_id' => $post->id,
            ]);
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
