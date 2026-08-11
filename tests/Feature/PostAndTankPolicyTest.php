<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\Role;
use App\Models\Tank;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class PostAndTankPolicyTest extends TestCase
{
    use RefreshDatabase;

    private function createUserWithRole(string $roleName): User
    {
        $role = Role::factory()->create(['name' => $roleName]);

        return User::factory()->create(['role_id' => $role->id]);
    }

    public function test_authenticated_user_can_create_post_with_own_tank(): void
    {
        $user = $this->createUserWithRole('Member');
        $tank = Tank::factory()->create(['user_id' => $user->id]);
        $category = Category::factory()->create();

        $this->actingAs($user);

        $response = $this->postJson('/api/posts', [
            'title' => 'My New Post',
            'content' => 'This is the post content.',
            'status' => 'published',
            'category_id' => $category->id,
            'tank_id' => $tank->id,
        ]);

        $response->assertStatus(201);
        $response->assertJsonFragment([
            'title' => 'My New Post',
            'tank_id' => $tank->id,
        ]);
        $this->assertDatabaseHas('posts', [
            'title' => 'My New Post',
            'user_id' => $user->id,
            'tank_id' => $tank->id,
        ]);
    }

    public function test_user_cannot_update_other_users_tank(): void
    {
        $owner = $this->createUserWithRole('Member');
        $intruder = $this->createUserWithRole('Member');
        $tank = Tank::factory()->create(['user_id' => $owner->id]);

        $this->actingAs($intruder);

        $response = $this->putJson("/api/tanks/{$tank->id}", [
            'name' => 'Hacked Tank',
            'volume_gallons' => 50,
            'water_type' => 'freshwater',
        ]);

        $response->assertStatus(403);
        $response->assertJson(['message' => 'Unauthorized']);
    }

    public function test_user_cannot_delete_other_users_tank(): void
    {
        $owner = $this->createUserWithRole('Member');
        $intruder = $this->createUserWithRole('Member');
        $tank = Tank::factory()->create(['user_id' => $owner->id]);

        $this->actingAs($intruder);

        $response = $this->deleteJson("/api/tanks/{$tank->id}");

        $response->assertStatus(403);
        $response->assertJson(['message' => 'Unauthorized']);
    }
}
