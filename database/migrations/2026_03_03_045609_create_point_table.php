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
        Schema::create('point', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('employee_id');
            $table->integer('checkin_point');
            $table->integer('early_checkout_point');
            $table->integer('late_point');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('point');
    }
};
