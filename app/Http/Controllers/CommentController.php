<?php

namespace App\Http\Controllers;

use App\Http\Requests\CommentRequest;
use App\Models\Comment;
use App\Models\Post;
use App\Notifications\CommentAddedNotification;
use App\Notifications\CommentRepliedNotification;
use App\Models\Image;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    /**
     * Store a new comment with optional images.
     */
    public function index(Request $request, Post $post)
    {
        $comments = $post->comments()
            ->whereNull('parent_comment_id')
            ->with(['user', 'replies.user', 'images'])
            ->latest()
            ->get();

        return response()->json($comments, 200);
    }

    public function store(CommentRequest $request, Post $post)
    {
        $validated = $request->validated();

        $comment = Comment::create([
            'user_id' => Auth::id(),
            'post_id' => $validated['post_id'] ?? $post->id,
            'parent_comment_id' => $validated['parent_comment_id'] ?? null,
            'content' => $validated['content'],
        ]);

        // Handle image uploads
        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $file) {
                $path = $file->store('comments', 'public');
                Image::create([
                    'image_path' => $path,
                    'comment_id' => $comment->id,
                ]);
            }
        }

        $comment->load(['user', 'images']);

        if (empty($validated['parent_comment_id'])) {
            if ($post->user_id !== Auth::id()) {
                $post->user->notify(new CommentAddedNotification($post, Auth::user()));
            }
        } else {
            $parent = Comment::find($validated['parent_comment_id']);
            if ($parent && $parent->user_id !== Auth::id()) {
                $parent->user->notify(new CommentRepliedNotification($post, Auth::user(), $parent));
            }
        }

        return response()->json($comment, 201);
    }

    /**
     * Update comment content. Only the comment owner can update.
     */
    public function update(Request $request, Comment $comment)
    {
        $validated = $request->validate([
            'content' => 'required|string',
        ]);

        if ($comment->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $comment->update($validated);

        return response()->json($comment->load('user'), 200);
    }

    /**
     * Soft delete a comment. Owner or Admin/Moderator can delete.
     */
    public function destroy(Comment $comment)
    {
        $user = Auth::user();

        if ($comment->user_id !== $user->id && ! in_array($user->role->name ?? '', ['Admin', 'Moderator'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $comment->delete();

        return response()->json(null, 204);
    }
}
