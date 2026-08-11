<?php

namespace App\Http\Controllers;

use App\Models\Tag;

class TagController extends Controller
{
    /**
     * List all tags with post counts.
     */
    public function index()
    {
        $tags = Tag::withCount('posts')->get();

        return response()->json($tags, 200);
    }
}
