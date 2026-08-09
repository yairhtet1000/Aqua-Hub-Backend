<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TankController;
use App\Http\Controllers\PostController;

Route::middleware(['auth:sanctum'])->group(function () {
    Route::apiResource('tanks', TankController::class);
    Route::apiResource('posts', PostController::class)->except(['update', 'destroy']);
});


use App\Http\Controllers\LikeController;
use App\Http\Controllers\ReportController;

Route::middleware(['auth:sanctum'])->group(function () {
    Route::post('posts/{post}/like', [LikeController::class, 'toggleLike']);
    Route::post('reports', [ReportController::class, 'store']);
});