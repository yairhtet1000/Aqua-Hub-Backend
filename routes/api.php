<?php

use App\Http\Controllers\Admin\RoleController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ReportController;
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

    Route::apiResource('tanks', TankController::class);

    Route::get('posts', [PostController::class, 'index']);
    Route::get('posts/{post}', [PostController::class, 'show']);
    Route::post('posts', [PostController::class, 'store']);
    Route::put('posts/{post}', [PostController::class, 'update']);
    Route::delete('posts/{post}', [PostController::class, 'destroy']);
    Route::post('posts/{post}/like', [LikeController::class, 'toggleLike']);

    Route::apiResource('comments', CommentController::class)->except(['index', 'show']);
    Route::post('reports', [ReportController::class, 'store']);

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

        Route::get('users', [UserController::class, 'index']);
        Route::patch('users/{user}/role', [UserController::class, 'updateRole']);
        Route::get('roles', [RoleController::class, 'index']);

        Route::apiResource('categories', CategoryController::class);
    });
});
