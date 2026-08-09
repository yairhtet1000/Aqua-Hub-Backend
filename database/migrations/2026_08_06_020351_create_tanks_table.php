<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTanksTable extends Migration
{
    public function up()
    {
        Schema::create('tanks', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users');
            $table->string('name');
            $table->decimal('volume_gallons', 10, 2);
            $table->enum('water_type', ['freshwater', 'saltwater', 'brackish']);
            $table->string('aquascape_style')->nullable();
            $table->date('setup_date')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down()
    {
        Schema::dropIfExists('tanks');
    }
}