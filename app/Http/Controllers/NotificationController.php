<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class NotificationController extends Controller
{
    public function index()
    {
        $notifications = Auth::user()
            ->notifications()
            ->latest()
            ->paginate(20);

        return response()->json($notifications, 200);
    }

    public function markAsRead($id)
    {
        $notification = Auth::user()
            ->notifications()
            ->findOrFail($id);

        $notification->update(['read_at' => now()]);

        return response()->json([
            'message' => 'Notification marked as read.',
            'notification' => $notification,
        ], 200);
    }

    public function markAllAsRead()
    {
        Auth::user()
            ->unreadNotifications
            ->each->markAsRead();

        return response()->json([
            'message' => 'All notifications marked as read.',
        ], 200);
    }
}
