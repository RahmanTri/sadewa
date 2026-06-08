<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class MakeNotice extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:make-notice';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send Notifications to all employees';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        //
    }
}
