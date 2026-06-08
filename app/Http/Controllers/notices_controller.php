<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\notices;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class notices_controller extends Controller
{
    //
    public function getNotices()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        if (!$employee) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $notices = notices::where('employee_id', $employee->id)
            ->get()
            ->map(function ($item) {
                $item->created_at = Carbon::parse($item->created_at);
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'content' => $item->content,
                    'date' => $item->created_at->format('Y-m-d'),
                    'is_read' => $item->is_read
                ];
            })
        ;

        return response()->json([
            "success" => true,
            "message" => "Sukses mengambil data",
            "data" => $notices
        ], 200);
    }

    public function readNotice(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $employee = Employee::where('user_id', $user->id)->first();

        if (!$employee) {
            return response()->json([
                "success" => false,
                "message" => "Unauthorized"
            ], 401);
        }

        $validator = Validator::make($request->all(), [
            'id' => 'required|exists:notices,id',
        ], [
            "id.required" => "ID harus diisi!",
            "id.exists" => "ID tidak valid!",
        ]);

        if ($validator->fails()) {
            return response()->json([
                "success" => false,
                "message" => "Gagal menghapus data!",
                "error" => $validator->errors(),
            ], 422);
        }

        $target = notices::where('id', $request->id)->first();

        if (!$target) {
            return response()->json([
                "success" => false,
                "message" => "Data tidak ditemukan!",
            ], 404);
        }

        $target->is_read = true;
        $target->save();

        return response()->json([
            "success" => true,
            "message" => "Data berhasil diubah!",
            "data" => $target
        ], 200);
    }
}
