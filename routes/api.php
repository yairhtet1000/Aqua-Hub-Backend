<?php

use App\Http\Controllers\Admin\RoleController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\FollowController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\SavedPostController;
use App\Http\Controllers\TagController;
use App\Http\Controllers\TankController;
use App\Http\Controllers\UserProfileController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Public Routes
|--------------------------------------------------------------------------
| Accessible without authentication.
*/
Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);

Route::get('posts', [PostController::class, 'index']);
Route::get('posts/{post}', [PostController::class, 'show']);

Route::get('categories', [CategoryController::class, 'index']);
Route::get('tags', [TagController::class, 'index']);

/*
|--------------------------------------------------------------------------
| Authenticated Routes
|--------------------------------------------------------------------------
| Require a valid Sanctum token.
*/
Route::middleware(['auth:sanctum'])->group(function () {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::get('me', [AuthController::class, 'me']);
    Route::get('user', [AuthController::class, 'me']);
    Route::post('profile', [UserProfileController::class, 'update']);
    Route::post('user/password', [UserProfileController::class, 'updatePassword']);
    Route::get('user/saved-posts', [UserProfileController::class, 'savedPosts']);
    Route::get('users/{user}', [UserProfileController::class, 'show']);
    Route::get('users/top-contributors', [UserProfileController::class, 'topContributors']);
    Route::post('users/{user}/follow', [FollowController::class, 'follow']);
    Route::delete('users/{user}/unfollow', [FollowController::class, 'unfollow']);
    Route::get('users/{user}/followers', [FollowController::class, 'followers']);
    Route::get('users/{user}/following', [FollowController::class, 'following']);

    Route::apiResource('tanks', TankController::class);

    Route::get('posts', [PostController::class, 'index']);
    Route::get('posts/{post}', [PostController::class, 'show']);
    Route::post('posts', [PostController::class, 'store']);
    Route::put('posts/{post}', [PostController::class, 'update']);
    Route::delete('posts/{post}', [PostController::class, 'destroy']);
    Route::post('posts/{post}/like', [LikeController::class, 'toggleLike']);
    Route::post('posts/{post}/save', [SavedPostController::class, 'save']);
    Route::delete('posts/{post}/save', [SavedPostController::class, 'unsave']);
    Route::get('posts/{post}/comments', [CommentController::class, 'index']);
    Route::post('posts/{post}/comments', [CommentController::class, 'store']);
    Route::put('comments/{comment}', [CommentController::class, 'update']);
    Route::delete('comments/{comment}', [CommentController::class, 'destroy']);
    Route::post('reports', [ReportController::class, 'store']);
    Route::get('notifications', [NotificationController::class, 'index']);
    Route::patch('notifications/{id}/read', [NotificationController::class, 'markAsRead']);
    Route::patch('notifications/read-all', [NotificationController::class, 'markAllAsRead']);

    /*
    |--------------------------------------------------------------------------
    | Admin Routes
    |--------------------------------------------------------------------------
    | Restricted to Admin and Moderator roles via 'admin' middleware.
    */
    Route::prefix('admin')->middleware(['admin'])->group(function () {
        Route::get('reports', [App\Http\Controllers\Admin\ReportController::class, 'index']);
        Route::patch('reports/{report}/status', [App\Http\Controllers\Admin\ReportController::class, 'updateStatus']);
        Route::delete('reports/{report}/resolve', [App\Http\Controllers\Admin\ReportController::class, 'resolveAndDeleteContent']);
        Route::delete('reports/{report}/ban-user', [App\Http\Controllers\Admin\ReportController::class, 'banUser']);

        Route::get('users', [UserController::class, 'index']);
        Route::put('users/{user}', [UserController::class, 'update']);
        Route::patch('users/{user}/role', [UserController::class, 'updateRole']);
        Route::get('roles', [RoleController::class, 'index']);

        Route::apiResource('categories', CategoryController::class);
    });
});
