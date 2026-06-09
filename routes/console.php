<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');


Schedule::command('update:daily-reset')->dailyAt('15:00')->timezone('Asia/Jakarta');

Schedule::command('create:autoAbsen')->everyMinute()->timezone('Asia/Jakarta');

Schedule::command('create:createNotice')->dailyAt('14:39')->timezone('Asia/Jakarta');