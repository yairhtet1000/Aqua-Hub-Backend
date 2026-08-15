<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $authId = $request->user()?->id;

        return [
            'id' => $this->id,
            'title' => $this->title,
            'content' => $this->content,
            'status' => $this->status,
            'category_id' => $this->category_id,
            'user_id' => $this->user_id,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'user' => $this->user ? [
                'id' => $this->user->id,
                'name' => $this->user->name,
                'avatar' => $this->user->avatar ?? null,
            ] : null,
            'category' => $this->category ? [
                'id' => $this->category->id,
                'name' => $this->category->name,
            ] : null,
            'tags' => $this->tags->map(fn($tag) => [
                'id' => $tag->id,
                'name' => $tag->name,
            ]),
            'images' => $this->images->map(fn($image) => [
                'id' => $image->id,
                'image_path' => $image->image_path,
            ]),
            'likes' => $this->likes->map(fn($like) => [
                'id' => $like->id,
            ]),
            'comments' => $this->comments->map(fn($comment) => [
                'id' => $comment->id,
            ]),
            'likes_count' => $this->likes->count(),
            'comments_count' => $this->comments->count(),
            'is_liked' => $this->likes->contains('id', $authId),
            'is_saved' => $this->savedByUsers->isNotEmpty(),
            'is_following' => $this->user && $this->user->relationLoaded('followers')
                ? $this->user->followers->isNotEmpty()
                : false,
        ];
    }
}
