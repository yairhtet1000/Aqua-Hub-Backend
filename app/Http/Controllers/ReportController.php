<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\Post;
use App\Models\Report;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

class ReportController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        // 1. Validate the reportable type first
        $validated = $request->validate([
            'reportable_type' => [
                'required',
                'string',
                Rule::in([Post::class, Comment::class]),
            ],
            'reportable_id' => 'required|integer',
            'reason' => 'required|string|max:1000',
        ]);

        // 2. Dynamic validation based on reportable_type
        $table = $validated['reportable_type'] === Post::class ? 'posts' : 'comments';

        $request->validate([
            'reportable_id' => "exists:{$table},id",
        ]);

        // 3. Create the report
        $report = Report::create([
            'user_id' => Auth::id(),
            'reportable_type' => $validated['reportable_type'],
            'reportable_id' => $validated['reportable_id'],
            'reason' => $validated['reason'],
            'status' => 'pending',
        ]);

        return response()->json([
            'message' => 'Report submitted successfully.',
            'report' => $report,
        ], 201);
    }
}