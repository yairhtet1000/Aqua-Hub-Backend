<?php

namespace App\Http\Controllers;

use App\Http\Resources\PostResource;
use App\Models\Image;
use App\Models\Post;
use App\Models\Tag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Storage;

class PostController extends Controller
{
    public function index(Request $request)
    {
        $authId = Auth::id();

        $query = Post::with([
            'user',
            'category',
            'tags',
            'tank',
            'images',
            'likes',
            'comments',
            'savedByUsers' => $authId ? fn ($q) => $q->where('user_id', $authId) : fn ($q) => $q->whereRaw('0 = 1'),
            'user.followers' => $authId ? fn ($q) => $q->where('follower_id', $authId) : fn ($q) => $q->whereRaw('0 = 1'),
        ]);

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

        return PostResource::collection($posts);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'status' => 'required|in:draft,published,archived',
            'category_id' => 'required|exists:categories,id',
            'tag_ids' => 'nullable|array',
            'tag_ids.*' => 'exists:tags,id',
            'tag_names' => 'nullable|array',
            'tag_names.*' => 'string|max:255',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048',
            'images' => 'nullable|array',
            'images.*' => 'image|mimes:jpeg,png,jpg,gif,webp|max:5120',
        ]);

        $post = Post::create([
            'title' => $request->title,
            'content' => $request->content,
            'status' => $request->status,
            'category_id' => $request->category_id,
            'user_id' => Auth::id(),
        ]);

        if (! empty($request->tag_ids)) {
            $post->tags()->sync($request->tag_ids);
        } elseif (! empty($request->tag_names)) {
            $tagIds = [];
            foreach ($request->tag_names as $tagName) {
                $tag = Tag::firstOrCreate(
                    ['name' => trim($tagName)],
                    ['slug' => \Illuminate\Support\Str::slug(trim($tagName))]
                );
                $tagIds[] = $tag->id;
            }
            $post->tags()->sync($tagIds);
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

        $post->load([
            'user',
            'category',
            'tags',
            'tank',
            'images',
            'comments',
            'likes',
            'savedByUsers' => fn ($q) => $q->where('user_id', Auth::id()),
            'user.followers' => fn ($q) => $q->where('follower_id', Auth::id()),
        ]);

        return response()->json(new PostResource($post), 201);
    }

    public function show(Post $post)
    {
        $authId = Auth::id();

        $post->load([
            'user',
            'category',
            'tags',
            'tank',
            'images',
            'comments',
            'likes',
            'savedByUsers' => $authId ? fn ($q) => $q->where('user_id', $authId) : fn ($q) => $q->whereRaw('0 = 1'),
            'user.followers' => $authId ? fn ($q) => $q->where('follower_id', $authId) : fn ($q) => $q->whereRaw('0 = 1'),
        ]);

        return response()->json(new PostResource($post));
    }

    public function update(Request $request, Post $post)
    {
        if ($post->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'status' => 'required|in:draft,published,archived',
            'category_id' => 'required|exists:categories,id',
            'tag_ids' => 'nullable|array',
            'tag_ids.*' => 'exists:tags,id',
            'tag_names' => 'nullable|array',
            'tag_names.*' => 'string|max:255',
        ]);

        $post->update([
            'title' => $request->title,
            'content' => $request->content,
            'status' => $request->status,
            'category_id' => $request->category_id,
        ]);

        if (! empty($request->tag_ids)) {
            $post->tags()->sync($request->tag_ids);
        } elseif (! empty($request->tag_names)) {
            $tagIds = [];
            foreach ($request->tag_names as $tagName) {
                $tag = Tag::firstOrCreate(
                    ['name' => trim($tagName)],
                    ['slug' => \Illuminate\Support\Str::slug(trim($tagName))]
                );
                $tagIds[] = $tag->id;
            }
            $post->tags()->sync($tagIds);
        }

        $post->load([
            'user',
            'category',
            'tags',
            'tank',
            'images',
            'comments',
            'likes',
            'savedByUsers' => fn ($q) => $q->where('user_id', Auth::id()),
            'user.followers' => fn ($q) => $q->where('follower_id', Auth::id()),
        ]);

        return response()->json(new PostResource($post));
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
