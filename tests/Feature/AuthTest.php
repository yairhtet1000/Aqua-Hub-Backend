<?php

namespace Tests\Feature;

use App\Models\Role;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    private function getRegisterPayload(array $overrides = []): array
    {
        return array_merge([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => 'password123',
            'password_confirmation' => 'password123',
            'phone' => '0123456789',
            'avatar' => 'https://example.com/avatar.jpg',
        ], $overrides);
    }

    private function getLoginPayload(array $overrides = []): array
    {
        return array_merge([
            'email' => 'test@example.com',
            'password' => 'password123',
        ], $overrides);
    }

    public function test_user_can_register_and_receives_token(): void
    {
        Role::factory()->create(['name' => 'Member']);

        $response = $this->postJson('/api/register', $this->getRegisterPayload());

        $response->assertStatus(201);
        $response->assertJsonStructure([
            'message',
            'user' => ['id', 'name', 'email', 'role'],
            'token',
        ]);
        $this->assertDatabaseHas('users', [
            'email' => 'test@example.com',
            'name' => 'Test User',
        ]);
    }

    public function test_user_can_login_with_valid_credentials_and_receives_token(): void
    {
        Role::factory()->create(['name' => 'Member']);

        $this->postJson('/api/register', $this->getRegisterPayload());

        $response = $this->postJson('/api/login', $this->getLoginPayload());

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'message',
            'user' => ['id', 'name', 'email', 'role'],
            'token',
        ]);
    }

    public function test_user_cannot_login_with_invalid_credentials(): void
    {
        Role::factory()->create(['name' => 'Member']);

        $this->postJson('/api/register', $this->getRegisterPayload());

        $response = $this->postJson('/api/login', [
            'email' => 'test@example.com',
            'password' => 'wrong-password',
        ]);

        $response->assertStatus(401);
        $response->assertJson(['message' => 'Invalid email or password.']);
    }

    public function test_user_cannot_login_with_nonexistent_email(): void
    {
        $response = $this->postJson('/api/login', [
            'email' => 'nonexistent@example.com',
            'password' => 'password123',
        ]);

        $response->assertStatus(401);
        $response->assertJson(['message' => 'Invalid email or password.']);
    }
}
