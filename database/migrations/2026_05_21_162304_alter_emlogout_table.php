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
        DB::statement("ALTER TABLE employee_log_out MODIFY COLUMN status ENUM('on_time', 'early', 'late', 'absent') NOT NULL");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement("ALTER TABLE employee_log_out MODIFY COLUMN status ENUM('on_time', 'early') NOT NULL");
    }
};
