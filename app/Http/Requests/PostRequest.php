<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PostRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'status' => 'required|in:draft,published,archived',
            'category_id' => 'required|exists:categories,id',
            'tank_id' => 'nullable|exists:tanks,id',
            'tag_ids' => 'nullable|array',
            'tag_ids.*' => 'exists:tags,id',
            'images' => 'nullable|array',
            'images.*' => 'image|mimes:jpeg,png,jpg,gif,webp|max:5120',
        ];
    }
}