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
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Run core fixed data seeders
        $this->call(RoleSeeder::class);
        $this->call(UsersTableSeeder::class);

        $memberRole = Role::where('name', 'Member')->first();

        // 2. Create extra factory users attached to Member role
        User::factory(10)->create([
            'role_id' => $memberRole ? $memberRole->id : 3,
        ]);

        // 3. Grab ALL users (both fixed table users and factory users)
        $allUsers = User::all();

        // 4. Ensure User ID 1 exists and explicitly hash its password
        $adminUser = User::find(1);
        if ($adminUser) {
            $adminUser->update([
                'password' => Hash::make('Password123'),
            ]);
        } else {
            // Fallback: Create Admin if ID 1 doesn't exist
            $adminUser = User::create([
                'id' => 1,
                'name' => 'Admin User',
                'email' => 'admin@example.com',
                'password' => Hash::make('Password123'),
                'role_id' => 1,
            ]);
            $allUsers->push($adminUser);
        }

        // 5. Create Categories and Tags
        $categories = Category::factory(5)->create();
        $tags = Tag::factory(10)->create();

        // 6. Attach 1-2 Tanks to each User
        foreach ($allUsers as $user) {
            Tank::factory(rand(1, 2))->create(['user_id' => $user->id]);
        }

        // 7. Create 20 Posts attached to existing Users, Categories, and optional Tanks
        $posts = Post::factory(20)->make()->each(function ($post) use ($allUsers, $categories, $tags) {
            $user = $allUsers->random();
            $userTank = $user->tanks()->inRandomOrder()->first();

            $post->user_id = $user->id;
            $post->category_id = $categories->random()->id;
            $post->tank_id = fake()->boolean(60) ? $userTank?->id : null;
            $post->save();

            // Attach 1 to 3 random tags
            $post->tags()->attach($tags->random(rand(1, 3))->pluck('id'));
        });

        // 8. Seed 30 Top-level Comments
        $topLevelComments = Comment::factory(30)->make()->each(function ($comment) use ($allUsers, $posts) {
            $comment->user_id = $allUsers->random()->id;
            $comment->post_id = $posts->random()->id;
            $comment->parent_comment_id = null;
            $comment->save();
        });

        // 9. Seed 10 Nested Reply Comments
        Comment::factory(10)->make()->each(function ($comment) use ($allUsers, $topLevelComments) {
            $parent = $topLevelComments->random();
            $comment->user_id = $allUsers->random()->id;
            $comment->post_id = $parent->post_id;
            $comment->parent_comment_id = $parent->id;
            $comment->save();
        });

        // 10. Seed Likes using sync to prevent duplicates
        foreach ($allUsers as $user) {
            $likedPosts = $posts->random(rand(1, 5))->pluck('id');
            $user->likedPosts()->sync($likedPosts);
        }
    }
}