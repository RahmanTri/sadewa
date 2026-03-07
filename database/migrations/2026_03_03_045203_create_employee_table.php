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
        Schema::create('employee', function (Blueprint $table) {
            $table->id();
            $table->string('company_id')->unique();
            $table->unsignedBigInteger('user_id');
            $table->string('name');
            $table->unsignedBigInteger('division_id');
            $table->string('phone_number', 13)->unique();
            $table->string('face_data')->nullable();
            $table->boolean('logged_in')->default(false);
            $table->boolean('logged_out')->default(false);
            $table->timestamps();

            $table->foreign('user_id')
                ->references('id')
                ->on('users')
                ->onDelete('cascade');

            $table->foreign('division_id')
                ->references('id')
                ->on('division')
                ->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employee');
    }
};
