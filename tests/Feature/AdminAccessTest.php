<?php

namespace Tests\Feature;

use App\Models\Post;
use App\Models\Report;
use App\Models\Role;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AdminAccessTest extends TestCase
{
    use RefreshDatabase;

    private function createUserWithRole(string $roleName): User
    {
        $role = Role::factory()->create(['name' => $roleName]);

        return User::factory()->create(['role_id' => $role->id]);
    }

    public function test_member_cannot_access_admin_reports(): void
    {
        $member = $this->createUserWithRole('Member');

        $this->actingAs($member);

        $response = $this->getJson('/api/admin/reports');

        $response->assertStatus(403);
        $response->assertJson(['message' => 'Forbidden']);
    }

    public function test_admin_can_access_admin_reports(): void
    {
        $admin = $this->createUserWithRole('Admin');

        $this->actingAs($admin);

        $response = $this->getJson('/api/admin/reports');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [],
            'current_page',
            'per_page',
            'total',
        ]);
    }

    public function test_moderator_can_access_admin_reports(): void
    {
        $moderator = $this->createUserWithRole('Moderator');

        $this->actingAs($moderator);

        $response = $this->getJson('/api/admin/reports');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [],
            'current_page',
            'per_page',
            'total',
        ]);
    }

    public function test_admin_can_resolve_report_and_delete_content(): void
    {
        $reporter = $this->createUserWithRole('Member');
        $admin = $this->createUserWithRole('Admin');
        $post = Post::factory()->create(['user_id' => $reporter->id]);

        $report = Report::create([
            'user_id' => $reporter->id,
            'reportable_type' => Post::class,
            'reportable_id' => $post->id,
            'reason' => 'Inappropriate content',
            'status' => 'pending',
        ]);

        $this->actingAs($admin);

        $response = $this->deleteJson("/api/admin/reports/{$report->id}/resolve");

        $response->assertStatus(200);
        $response->assertJsonFragment([
            'message' => 'Reported content has been deleted and report marked as reviewed.',
        ]);
        $response->assertJsonFragment([
            'status' => 'reviewed',
        ]);

        $this->assertSoftDeleted('posts', ['id' => $post->id]);
        $this->assertDatabaseHas('reports', [
            'id' => $report->id,
            'status' => 'reviewed',
        ]);
    }
}
