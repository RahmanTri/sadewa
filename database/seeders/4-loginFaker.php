<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Em_log_in;

class loginFaker extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Em_log_in::factory()->count(50)->create();
    }
}
