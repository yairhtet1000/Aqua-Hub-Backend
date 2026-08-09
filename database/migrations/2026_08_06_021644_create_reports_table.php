<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportsTable extends Migration
{
    public function up()
    {
        Schema::create('reports', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained();
            $table->text('reason');
            $table->enum('status', ['pending', 'reviewed', 'dismissed']);

            // This creates BOTH 'reportable_type' and 'reportable_id' automatically
            $table->morphs('reportable');

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down()
    {
        Schema::dropIfExists('reports');
    }
}