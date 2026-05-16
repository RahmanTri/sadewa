<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SendOtp extends Notification
{
    use Queueable;
    public $otp;

    /**
     * Create a new notification instance.
     */
    public function __construct($otp)
    {
        //
        $this->otp = $otp;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->line('Makane Tala Password ojok lali-lali COK')
            ->line('Kontol ngerepoti wong tok ae isomu')
            ->line('Kilo kodemu COK')
            ->line('OTP: ' . $this->otp)
            ->line('Iki mek valid 10 menit tok COk gek ndang')
            ->line('Nk guguk koen seng jalok iki Gausah direken COK');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
