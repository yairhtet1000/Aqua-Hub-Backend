<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tanks', function (Blueprint $table) {
            $table->decimal('temperature', 5, 2)->nullable()->after('water_type');
            $table->decimal('ph_level', 3, 2)->nullable()->after('temperature');
        });
    }

    public function down(): void
    {
        Schema::table('tanks', function (Blueprint $table) {
            $table->dropColumn(['temperature', 'ph_level']);
        });
    }
};
