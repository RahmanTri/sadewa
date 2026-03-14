<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Models\Division;
use App\Models\Em_log_in;
use App\Models\Em_log_out;
use App\Models\Employee;
use App\Models\Point;
use Psy\CodeCleaner\FunctionContextPass;
use function PHPUnit\Framework\returnArgument;

class export_controller extends Controller
{
    public function allRecap()
    {
        // $user = Auth::user();

        // if ($user->role != 'admin') {
        //     return response()->json([
        //         "success" => false,
        //         "message" => "fitur ini hanya untuk role admin"
        //     ]);
        // }

        $rawData = Em_log_in::leftJoin('employee', 'employee_id', 'employee.id')
            ->join('division', 'employee.division_id', 'division.id')
            ->select(
                [
                    'employee_log_in.created_at as date',
                    'employee.company_id',
                    'employee.name',
                    'division.division_name',
                    'employee_log_in.status'
                ]
            )
            ->orderBy('division_name')
            ->orderBy('date')
            ->get()
            ->map(function ($item) {
                if ($item->status == 'on_time') {
                    $item->keterangan = 'Hadir';
                } elseif ($item->status == 'late') {
                    $item->keterangan = 'Hadir Terlambat';
                } elseif ($item->status == 'alpha') {
                    $item->keterangan = 'Tidak Hadir';
                }
                return $item;
            })
        ;

        $grouppedData = $rawData->groupBy(function ($item) {
            return Carbon::parse($item->date)->format('Y');
        })->map(function ($yearGroup) {
            return $yearGroup->groupBy(function ($item) {
                return Carbon::parse($item->date)->translatedFormat('F');
            });
        });

        $pdf = Pdf::loadView('export.all_report', [
            'data' => $grouppedData
        ])->setPaper('A4', 'portrait');

        $fileName = 'rekap-semua-kehadiran.pdf';

        return response()->streamDownload(
            function () use ($pdf) {
                echo $pdf->output();
                ob_flush();
                flush();
            },
            $fileName,
            ['Content-Type' => "aplication/pdf"]
        );

        // return response()->json([
        //     'data' => $grouppedData
        // ]);
    }
}
