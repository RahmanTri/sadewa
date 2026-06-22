<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Models\Division;
use App\Models\activity_log;
use App\Models\Em_log_in;
use App\Models\Em_log_out;
use App\Models\Employee;
use App\Models\Point;
use Psy\CodeCleaner\FunctionContextPass;
use function PHPUnit\Framework\returnArgument;
use Illuminate\Support\Facades\Validator;


class export_controller extends Controller
{
    public function allRecap()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!"
            ]);
        }

        if ($user->role != 'admin') {
            return response()->json([
                "success" => false,
                "message" => "fitur ini hanya untuk role admin"
            ]);
        }

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
                } elseif ($item->status == 'absent') {
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
            })->map(function ($monthGroup) {
                $jumlahData = $monthGroup->count();
                $jumlahTelat = $monthGroup->where('status', 'late')->count();
                $jumlahTidakHadir = $monthGroup->where('status', 'absent')->count();
                $divisi = $monthGroup->pluck('division_name')->unique()->values();
                return [
                    'summary' => [
                        'jumlah_data' => $jumlahData,
                        'jumlah_telat' => $jumlahTelat,
                        'jumlah_tidak_hadir' => $jumlahTidakHadir,
                        'divisi' => $divisi
                    ],
                    'records' => $monthGroup->values()
                ];
            });
        });

        $pdf = Pdf::loadView('export.all_report', [
            'data' => $grouppedData
        ])->setPaper('A4', 'portrait');

        $fileName = 'rekap-semua-kehadiran.pdf';

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Export',
            'description' => 'Cetak rekap kehadiran',
        ]);

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

    public function customRecap(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ada!"
            ]);
        }

        if ($user->role != 'admin') {
            return response()->json([
                "success" => false,
                "message" => "fitur ini hanya untuk role admin"
            ]);
        }


        $validator = Validator::make($request->all(), [
            "month" => "sometimes|string|max:50",
            "division" => "sometimes|string|max:255"
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'inputan tidak sesuai',
                'error' => $validator->errors()
            ], 422);
        }

        $validateData = $validator->validate();

        $months = [
            'Periode' => "all",
            'Januari' => 1,
            'Februari' => 2,
            'Maret' => 3,
            'April' => 4,
            'Mei' => 5,
            'Juni' => 6,
            'Juli' => 7,
            'Agustus' => 8,
            'September' => 9,
            'Oktober' => 10,
            'November' => 11,
            'Desember' => 12,
        ];

        $monthName = $validateData['month'];
        $divisionName = $validateData['division'];
        $monthNumber = $months[$monthName];
        $rawData = [];
        if ($monthName == 'all') {
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
                ->where('division_name', '=', $divisionName)
                ->orderBy('division_name')
                ->orderBy('date')
                ->get()
                ->map(function ($item) {
                    if ($item->status == 'on_time') {
                        $item->keterangan = 'Hadir';
                    } elseif ($item->status == 'late') {
                        $item->keterangan = 'Hadir Terlambat';
                    } elseif ($item->status == 'absent') {
                        $item->keterangan = 'Tidak Hadir';
                    }
                    return $item;
                });
        }
        if ($divisionName == 'Divisi') {
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
                ->whereMonth('employee_log_in.created_at', $monthNumber)
                ->orderBy('division_name')
                ->orderBy('date')
                ->get()
                ->map(function ($item) {
                    if ($item->status == 'on_time') {
                        $item->keterangan = 'Hadir';
                    } elseif ($item->status == 'late') {
                        $item->keterangan = 'Hadir Terlambat';
                    } elseif ($item->status == 'absent') {
                        $item->keterangan = 'Tidak Hadir';
                    }
                    return $item;
                });
        } else {
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
                ->where('division_name', '=', $divisionName)
                ->whereMonth('employee_log_in.created_at', $monthNumber)
                ->orderBy('division_name')
                ->orderBy('date')
                ->get()
                ->map(function ($item) {
                    if ($item->status == 'on_time') {
                        $item->keterangan = 'Hadir';
                    } elseif ($item->status == 'late') {
                        $item->keterangan = 'Hadir Terlambat';
                    } elseif ($item->status == 'absent') {
                        $item->keterangan = 'Tidak Hadir';
                    }
                    return $item;
                });
        }



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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Export',
            'description' => 'Cetak rekap kehadiran untuk: ' . $divisionName . 'Bulan: ' . $monthName,
        ]);

        return response()->streamDownload(
            function () use ($pdf) {
                echo $pdf->output();
                ob_flush();
                flush();
            },
            $fileName,
            ['Content-Type' => "aplication/pdf"]
        );
    }
}
