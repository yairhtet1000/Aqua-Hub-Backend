<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Str;

class CategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('name') && empty($this->input('slug'))) {
            $this->merge([
                'slug' => Str::slug($this->input('name')),
            ]);
        }
    }

    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255|unique:categories,name,'.$this->route('category'),
            'slug' => 'nullable|string|max:255|unique:categories,slug,'.$this->route('category'),
            'description' => 'nullable|string|max:1000',
        ];
    }
}
