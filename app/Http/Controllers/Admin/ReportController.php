<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Report;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    /**
     * Paginated list of reports with filtering by status.
     */
    public function index(Request $request)
    {
        $query = Report::with(['user', 'reportable']);

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        if ($search = $request->get('search')) {
            $query->where(function ($q) use ($search) {
                $q->where('reason', 'like', "%{$search}%")
                  ->orWhereHas('user', function ($q2) use ($search) {
                      $q2->where('name', 'like', "%{$search}%");
                  })
                  ->orWhere('reportable_type', 'like', "%{$search}%");
            });
        }

        $reports = $query->latest()->paginate(15);

        return response()->json($reports, 200);
    }

    /**
     * Update report status to 'reviewed' or 'dismissed'.
     */
    public function updateStatus(Report $report, Request $request)
    {
        $validated = $request->validate([
            'status' => 'required|in:reviewed,dismissed',
        ]);

        $report->update(['status' => $validated['status']]);

        return response()->json($report->load(['user', 'reportable']), 200);
    }

    /**
     * Delete the reported content and mark the report as reviewed.
     */
    public function resolveAndDeleteContent(Report $report)
    {
        $reportable = $report->reportable;

        if ($reportable) {
            $reportable->delete();
        }

        $report->update(['status' => 'reviewed']);

        return response()->json([
            'message' => 'Reported content has been deleted and report marked as reviewed.',
            'report' => $report->load(['user', 'reportable']),
        ], 200);
    }

    /**
     * Ban the user who created the reported content.
     */
    public function banUser(Report $report)
    {
        $reportable = $report->reportable;

        if ($reportable) {
            $userId = $reportable->user_id ?? null;
            if ($userId) {
                \App\Models\User::where('id', $userId)->delete();
            }
        }

        $report->update(['status' => 'reviewed']);

        return response()->json([
            'message' => 'User has been banned and report marked as reviewed.',
            'report' => $report->load(['user', 'reportable']),
        ], 200);
    }
}
