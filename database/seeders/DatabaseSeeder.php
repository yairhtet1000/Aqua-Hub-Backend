<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Role;
use App\Models\Tank;
use App\Models\Category;
use App\Models\Post;
use App\Models\Comment;
use App\Models\Tag;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call(RoleSeeder::class);

        $memberRole = Role::where('name', 'Member')->first();

        // Create 10 Users attached to Member role
        $users = User::factory(10)->create([
            'role_id' => $memberRole ? $memberRole->id : 3,
        ]);

        // Create 5 Categories and 10 Tags
        $categories = Category::factory(5)->create();
        $tags = Tag::factory(10)->create();

        // Attach 1-2 Tanks to each User
        foreach ($users as $user) {
            Tank::factory(rand(1, 2))->create(['user_id' => $user->id]);
        }

        // Create 20 Posts attached to existing Users, Categories, and optional Tanks
        $posts = Post::factory(20)->make()->each(function ($post) use ($users, $categories, $tags) {
            $user = $users->random();
            $userTank = $user->tanks()->inRandomOrder()->first();

            $post->user_id = $user->id;
            $post->category_id = $categories->random()->id;
            $post->tank_id = fake()->boolean(60) ? $userTank?->id : null;
            $post->save();

            // Attach 1 to 3 random tags
            $post->tags()->attach($tags->random(rand(1, 3))->pluck('id'));
        });

        // Seed 30 Top-level Comments
        $topLevelComments = Comment::factory(30)->make()->each(function ($comment) use ($users, $posts) {
            $comment->user_id = $users->random()->id;
            $comment->post_id = $posts->random()->id;
            $comment->parent_comment_id = null;
            $comment->save();
        });

        // Seed 10 Nested Reply Comments
        Comment::factory(10)->make()->each(function ($comment) use ($users, $topLevelComments) {
            $parent = $topLevelComments->random();
            $comment->user_id = $users->random()->id;
            $comment->post_id = $parent->post_id;
            $comment->parent_comment_id = $parent->id;
            $comment->save();
        });

        // Seed Likes using sync to prevent duplicates
        foreach ($users as $user) {
            $likedPosts = $posts->random(rand(1, 5))->pluck('id');
            $user->likedPosts()->sync($likedPosts);
        }
    }
}