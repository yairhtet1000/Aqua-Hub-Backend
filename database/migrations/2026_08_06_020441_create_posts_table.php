<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePostsTable extends Migration
{
    public function up()
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('category_id')->constrained('categories');
            $table->foreignId('tank_id')->nullable()->constrained('tanks');
            $table->string('title');
            $table->text('content');
            $table->enum('status', ['draft', 'published', 'archived']);
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down()
    {
        Schema::dropIfExists('posts');
    }
}