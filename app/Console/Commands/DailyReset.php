<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class DailyReset extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'update:daily-reset';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Reset harian';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        DB::table('employee')->update(['logged_in' => 0]);
        DB::table('employee')->update(['logged_out' => 0]);

        $this->info('task scheduller berhasil di jalankan');

        Log::info("scheduler berhasil dijalankan");
    }
}
