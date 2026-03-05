<?php

namespace App\Http\Controllers;

use App\Models\division;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class division_controller extends Controller
{
    //
    public function index()
    {
        $divisions = division::all();

        return response()->json([
            "Success" => true,
            "message" => "Sukses menerima data",
            "data" => $divisions,
        ], 200);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "division_name" => "required|string|max:100",
            "checkin_time" => "required|date_format:H:i",
            "checkout_time" => "required|date_format:H:i",
            "tolerance" => "required|int|max:120",
        ], [
            "division_name.required" => "Nama divisi tidak boleh kosong",
            "division_name.max" => "Maksimal 100 karakter",
            "checkin_time.required" => "Waktu checkin tidak boleh kosong",
            "checkout_time.required" => "Waktu checkout tidak boleh kosong",
            "tolerance" => "Toleransi Waktu maksimal 2 jam"

        ]);

        if ($validator->fails()) {
            return response()->json([
                'Success' => false,
                'error' => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        $data = division::create($validatedData);

        return response()->json([
            'success' => true,
            'data' => $data,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $target = division::find($id);

        if (!$target) {
            return response()->json([
                'succes' => false,
                'message' => "data dengan ID $id tidak ditemukan"
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            "division_name" => "sometimes|string|max:100",
            "checkin_time" => "sometimes|date_format:H:i",
            "checkout_time" => "sometimes|date_format:H:i",
            "tolerance" => "sometimes|int|max:120",
        ], [
            "division_name" => "Nama divisi maksimal 100 karakter",
            "tolerance" => "Toleransi Waktu maksimal 2 jam"
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors(),
            ], 422);

        }

        $validatedData = $validator->validate();

        $oldData = $target->toArray();

        $target->update($validatedData);

        return response()->json([
            'success' => true,
            'data' => $target,
            'old_data' => $oldData,
        ], 200);
    }

    public function destroy($id)
    {
        $target = division::find($id);

        if (!$target) {
            return response()->json([
                'success' => false,
                'message' => "ID $id tidak ditemukan",
            ], 404);
        }

        $target->delete();

        return response()->json([
            'success' => true,
            'message' => 'data berhasll dihapus'
        ], 200);
    }
}