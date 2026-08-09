<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // 1. Safely drop all tables regardless of execution order
        Schema::disableForeignKeyConstraints();
        Schema::dropIfExists('reports');
        Schema::dropIfExists('images');
        Schema::dropIfExists('likes');
        Schema::dropIfExists('post_tags');
        Schema::dropIfExists('comments');
        Schema::dropIfExists('posts');
        Schema::dropIfExists('tanks');
        Schema::dropIfExists('users');
        Schema::dropIfExists('categories');
        Schema::dropIfExists('tags');
        Schema::dropIfExists('roles');
        Schema::enableForeignKeyConstraints();

        // 2. Recreate Tables
        Schema::create('roles', function (Blueprint $table) {
            $table->id();
            $table->string('name')->unique();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('categories', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('tags', function (Blueprint $table) {
            $table->id();
            $table->string('name')->unique();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->foreignId('role_id')->nullable()->constrained('roles')->onDelete('set null');
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('phone')->nullable();
            $table->text('avatar')->nullable();
            $table->text('bio')->nullable();
            $table->rememberToken();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('tanks', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->string('name');
            $table->decimal('volume_gallons', 8, 2);
            $table->enum('water_type', ['freshwater', 'saltwater', 'brackish']);
            $table->text('aquascape_style')->nullable();
            $table->date('setup_date')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('category_id')->nullable()->constrained('categories')->onDelete('set null');
            $table->foreignId('tank_id')->nullable()->constrained('tanks')->onDelete('set null');
            $table->string('title');
            $table->text('content');
            $table->enum('status', ['draft', 'published', 'archived'])->default('published');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('comments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('post_id')->constrained('posts')->onDelete('cascade');
            $table->foreignId('parent_comment_id')->nullable()->constrained('comments')->onDelete('cascade');
            $table->text('content');
            $table->timestamps();
            $table->softDeletes();
        });

        // Junction Table: Likes (Composite PK)
        Schema::create('likes', function (Blueprint $table) {
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('post_id')->constrained('posts')->onDelete('cascade');
            $table->primary(['user_id', 'post_id']);
            $table->timestamps();
        });

        // Junction Table: Post Tags (Composite PK)
        Schema::create('post_tags', function (Blueprint $table) {
            $table->foreignId('post_id')->constrained('posts')->onDelete('cascade');
            $table->foreignId('tag_id')->constrained('tags')->onDelete('cascade');
            $table->primary(['post_id', 'tag_id']);
            $table->timestamps();
        });

        // Images (Attached to Post or Comment)
        Schema::create('images', function (Blueprint $table) {
            $table->id();
            $table->string('image_path');
            $table->foreignId('post_id')->nullable()->constrained('posts')->onDelete('cascade');
            $table->foreignId('comment_id')->nullable()->constrained('comments')->onDelete('cascade');
            $table->timestamps();
            $table->softDeletes();
        });

        // Polymorphic Reports
        Schema::create('reports', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->text('reason');
            $table->enum('status', ['pending', 'reviewed', 'dismissed'])->default('pending');
            $table->numericMorphs('reportable'); // Creates reportable_type and reportable_id
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::disableForeignKeyConstraints();
        Schema::dropIfExists('reports');
        Schema::dropIfExists('images');
        Schema::dropIfExists('post_tags');
        Schema::dropIfExists('likes');
        Schema::dropIfExists('comments');
        Schema::dropIfExists('posts');
        Schema::dropIfExists('tanks');
        Schema::dropIfExists('users');
        Schema::dropIfExists('categories');
        Schema::dropIfExists('tags');
        Schema::dropIfExists('roles');
        Schema::enableForeignKeyConstraints();
    }
};