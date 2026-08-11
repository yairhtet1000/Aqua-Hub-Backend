<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class ExportSeeders extends Command
{
    protected $signature = 'export:seeders';
    protected $description = 'Export database tables to clean native Laravel seeder files';

    protected array $tables = [
        'roles',
        'users',
        'categories',
        'tags',
        'tanks',
        'posts',
        'comments',
    ];

    public function handle(): void
    {
        foreach ($this->tables as $table) {
            if (!DB::getSchemaBuilder()->hasTable($table)) {
                $this->warn("Table '{$table}' does not exist. Skipping...");
                continue;
            }

            $rows = DB::table($table)->get();
            if ($rows->isEmpty()) {
                $this->info("Table '{$table}' is empty. Skipping...");
                continue;
            }

            $className = ucfirst($table) . 'TableSeeder';
            $filePath = database_path("seeders/{$className}.php");

            $exportArray = [];
            foreach ($rows as $row) {
                $rowArray = (array) $row;

                // Special handling for users table: sanitize password and strip literal quotes
                if ($table === 'users') {
                    $rowArray['password'] = 'Password123';
                }

                // Sanitize string attributes (strip literal single quotes)
                foreach ($rowArray as $key => $val) {
                    if (is_string($val)) {
                        $rowArray[$key] = trim($val, "'");
                    }
                }

                $exportArray[] = $rowArray;
            }

            $exportString = var_export($exportArray, true);

            if ($table === 'users') {
                $code = "<?php\n\nnamespace Database\Seeders;\n\nuse Illuminate\Database\Seeder;\nuse Illuminate\Support\Facades\DB;\nuse Illuminate\Support\Facades\Hash;\n\nclass {$className} extends Seeder\n{\n    public function run(): void\n    {\n        \$users = {$exportString};\n\n        foreach (\$users as &\$user) {\n            \$user['password'] = Hash::make(\$user['password']);\n        }\n\n        DB::table('{$table}')->insert(\$users);\n    }\n}\n";
            } else {
                $code = "<?php\n\nnamespace Database\Seeders;\n\nuse Illuminate\Database\Seeder;\nuse Illuminate\Support\Facades\DB;\n\nclass {$className} extends Seeder\n{\n    public function run(): void\n    {\n        DB::table('{$table}')->insert({$exportString});\n    }\n}\n";
            }

            File::put($filePath, $code);
            $this->info("Generated: {$className}.php");
        }

        $this->info('All seeders generated successfully!');
    }
}