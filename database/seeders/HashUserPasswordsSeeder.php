<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class HashUserPasswordsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * This seeder should be executed AFTER any raw SQL imports or table dumps
     * to ensure all user passwords are properly hashed for Laravel authentication.
     */
    public function run(): void
    {
        // Iterate through all users and hash any plain-text or outdated passwords
        User::all()->each(function ($user) {
            // Bcrypt hashes start with $2y$ or $2b$, Argon hashes start with $argon2id$ or $argon2i$
            $isHashed = str_starts_with($user->password, '$2y$')
                || str_starts_with($user->password, '$2b$')
                || str_starts_with($user->password, '$argon2');

            if (!$isHashed) {
                // Preserve the original plain-text value and hash it
                $user->password = Hash::make($user->password);
                $user->save();
            }
        });

        // Explicitly ensure the admin user (id = 1) has the known default test password
        User::where('id', 1)->update(['password' => Hash::make('password')]);

        // Also ensure any user with role_id = 1 (Admin) has the default password
        User::where('role_id', 1)->update(['password' => Hash::make('password')]);
    }
}
