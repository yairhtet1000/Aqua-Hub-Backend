<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TagsTableSeeder extends Seeder
{
  public function run(): void
  {
    DB::table('tags')->insert(array(
      0 =>
        array(
          'id' => 1,
          'name' => 'nobis',
          'slug' => 'nobis',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      1 =>
        array(
          'id' => 2,
          'name' => 'animi',
          'slug' => 'animi',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      2 =>
        array(
          'id' => 3,
          'name' => 'ut',
          'slug' => 'ut',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      3 =>
        array(
          'id' => 4,
          'name' => 'esse',
          'slug' => 'esse',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      4 =>
        array(
          'id' => 5,
          'name' => 'excepturi',
          'slug' => 'excepturi',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      5 =>
        array(
          'id' => 6,
          'name' => 'quos',
          'slug' => 'quos',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      6 =>
        array(
          'id' => 7,
          'name' => 'et',
          'slug' => 'et',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      7 =>
        array(
          'id' => 8,
          'name' => 'laudantium',
          'slug' => 'laudantium',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      8 =>
        array(
          'id' => 9,
          'name' => 'maxime',
          'slug' => 'maxime',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
      9 =>
        array(
          'id' => 10,
          'name' => 'corporis',
          'slug' => 'corporis',
          'created_at' => '2026-08-11 10:48:50',
          'updated_at' => '2026-08-11 10:48:50',
          'deleted_at' => NULL,
        ),
    ));
  }
}
