<?php

namespace App\Http\Controllers;

use App\Http\Requests\PostRequest;
use App\Models\Post;
use App\Models\Image;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class PostController extends Controller
{
    public function index()
    {
        $posts = Post::with(['user', 'category', 'tags', 'tank', 'images'])
            ->latest()
            ->paginate(10);

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

        if (!empty($validated['tag_ids'])) {
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
        // Fixed relation name from 'parentComment' to 'parent'
        $post->load(['user', 'category', 'tags', 'tank', 'images', 'comments.parent', 'comments.user']);

        return response()->json($post, 200);
    }
}