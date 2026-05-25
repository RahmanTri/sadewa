<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('division', function (Blueprint $table) {
            $table->id();
            $table->string('division_name');
            $table->string('address')->nullable();
            $table->time('checkin_time');
            $table->time('checkout_time');
            $table->integer('tolerance');
            $table->float('latitude')->nullable();
            $table->float('longitude')->nullable();
            $table->integer('r_tolerance')->default(100);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('division');
    }
};
