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
        Schema::create('employee_log_in', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('employee_id');
            $table->time('login_time');
            $table->enum('status', ['on_time', 'late']);
            $table->timestamps();

            $table->foreign('employee_id')
                ->references('id')
                ->on('employee')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employee_log_in');
    }
};
