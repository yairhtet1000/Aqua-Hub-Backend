<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RolesTableSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('roles')->insert(array (
  0 => 
  array (
    'id' => 1,
    'name' => 'Admin',
    'created_at' => '2026-08-11 10:48:20',
    'updated_at' => '2026-08-11 10:48:20',
    'deleted_at' => NULL,
  ),
  1 => 
  array (
    'id' => 2,
    'name' => 'Moderator',
    'created_at' => '2026-08-11 10:48:20',
    'updated_at' => '2026-08-11 10:48:20',
    'deleted_at' => NULL,
  ),
  2 => 
  array (
    'id' => 3,
    'name' => 'Member',
    'created_at' => '2026-08-11 10:48:20',
    'updated_at' => '2026-08-11 10:48:20',
    'deleted_at' => NULL,
  ),
));
    }
}
