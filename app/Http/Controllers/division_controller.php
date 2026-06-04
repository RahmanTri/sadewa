<?php

namespace App\Http\Controllers;

use App\Models\division;
use App\Models\activity_log;
use App\Models\Employee;
use Carbon\Carbon;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;


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
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Anda belum login"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas"
            ], 403);
        }

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Registrasi Divisi',
            'description' => 'Menambahkan divisi ' . $data->division_name,
        ]);

        return response()->json([
            'success' => true,
            'data' => $data,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Anda belum login"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas"
            ], 403);
        }

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

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Update Divisi',
            'description' => 'Mengubah data divisi ' . $target->division_name,
        ]);

        return response()->json([
            'success' => true,
            'data' => $target,
            'old_data' => $oldData,
        ], 200);
    }

    public function destroy($id)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "Anda belum login"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas"
            ], 403);
        }

        $target = division::find($id);

        if (!$target) {
            return response()->json([
                'success' => false,
                'message' => "ID $id tidak ditemukan",
            ], 404);
        }

        $target->delete();

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Hapus Divisi',
            'description' => 'Menghapus divisi ' . $target->division_name,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'data berhasll dihapus'
        ], 200);
    }

    public function getDivision()
    {

        $divisions = DB::table("division")
            ->select(
                'id as id_divisi',
                'division_name as nama_divisi',
                'office as kantor',
                'address as alamat',
                'checkin_time as waktu_checkin',
                'checkout_time as waktu_checkout',
                'tolerance as toleransi_waktu',
                'latitude',
                'longitude',
                'r_tolerance as toleransi_radius'
            )
            ->get()
            ->map(function ($item) {

                if ($item->kantor == 'head') {
                    $item->kantor = 'Kantor Utama';
                } elseif ($item->kantor == 'branch') {
                    $item->kantor = 'Kantor Cabang';
                } else {
                    $item->kantor = 'Kantor Cabang';
                }

                return [
                    "id_divisi" => $item->id_divisi,
                    "nama_divisi" => $item->nama_divisi,
                    "kantor" => $item->kantor,
                    "alamat_kantor" => $item->alamat,
                    "waktu_checkin" => Carbon::parse($item->waktu_checkin)->format('H:i'),
                    "waktu_checkout" => Carbon::parse($item->waktu_checkout)->format('H:i'),
                    "toleransi_waktu" => $item->toleransi_waktu,
                    "latitude" => $item->latitude,
                    "longitude" => $item->longitude,
                    "toleransi_radius" => $item->toleransi_radius,
                ];
            })
        ;

        return response()->json([
            "Success" => true,
            "message" => "Sukses mengambil data",
            "data" => $divisions,
        ], 200);
    }

    public function getDivisionById(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "id" => "required|exists:division,id",
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

        $validatedData = $validator->validated();

        $division = DB::table("division")
            ->where("id", $validatedData["id"])
            ->select(
                'id as id_divisi',
                'division_name as nama_divisi',
                'office as kantor',
                'address as alamat',
                'checkin_time as waktu_checkin',
                'checkout_time as waktu_checkout',
                'tolerance as toleransi_waktu',
                'latitude',
                'longitude',
                'r_tolerance as toleransi_radius'
            )
            ->get()
            ->map(function ($item) {

                if ($item->kantor == 'head') {
                    $item->kantor = 'Kantor Utama';
                } elseif ($item->kantor == 'branch') {
                    $item->kantor = 'Kantor Cabang';
                } else {
                    $item->kantor = 'Kantor Cabang';
                }

                return [
                    "id_divisi" => $item->id_divisi,
                    "nama_divisi" => $item->nama_divisi,
                    "kantor" => $item->kantor,
                    "alamat_kantor" => $item->alamat,
                    "waktu_checkin" => Carbon::parse($item->waktu_checkin)->format('H:i'),
                    "waktu_checkout" => Carbon::parse($item->waktu_checkout)->format('H:i'),
                    "toleransi_waktu" => $item->toleransi_waktu,
                    "latitude" => $item->latitude,
                    "longitude" => $item->longitude,
                    "toleransi_radius" => $item->toleransi_radius,
                ];
            })
            ->first()
        ;

        return response()->json([
            "success" => true,
            "message" => "Sukses mengambil data",
            "data" => $division,
        ], 200);

    }

    public function editDivision(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "id" => "required|exists:division,id",
            "division_name" => "sometimes|string|max:255",
            "address" => "sometimes|string|max:1000",
            "office" => "sometimes|in:head,branch",
            "checkin_time" => "sometimes|date_format:H:i",
            "checkout_time" => "sometimes|date_format:H:i",
            "tolerance" => "sometimes|int|max:120",
            "latitude" => "sometimes|numeric",
            "longitude" => "sometimes|numeric",
            "r_tolerance" => "sometimes|int",
        ], [
            "id.required" => "ID harus diisi!",
            "id.exists" => "ID tidak valid!",
            "division_name.required" => "Nama divisi tidak boleh kosong",
            "division_name.max" => "Maksimal 100 karakter",
            "address.max" => "Maksimal 1000 karakter",
            "office.in" => "Kantor tidak valid",
            "checkin_time.required" => "Waktu checkin tidak boleh kosong",
            "checkout_time.required" => "Waktu checkout tidak boleh kosong",
            "tolerance" => "Toleransi Waktu maksimal 2 jam",
            "latitude.numeric" => "nilai Latitude tidak valid",
            "longitude.numeric" => "nilai Longitude tidak valid",
            "r_tolerance" => "nilai toleransi radius tidak valid",
        ]);

        if ($validator->fails()) {
            return response()->json([
                'Success' => false,
                'error' => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validate();

        $target = division::where('id', $validatedData['id'])->first();

        if (!$target) {
            return response()->json([
                'success' => false,
                'message' => "ID $validatedData[id] tidak ditemukan",
            ], 404);
        }

        $oldData = $target->toArray();

        if (isset($validatedData['division_name'])) {
            $target->division_name = $validatedData['division_name'];
        }

        if (isset($validatedData['office'])) {
            $target->office = $validatedData['office'];
        }

        if (isset($validatedData['address'])) {
            $target->address = $validatedData['address'];
        }

        if (isset($validatedData['checkin_time'])) {
            $target->checkin_time = $validatedData['checkin_time'];
        }

        if (isset($validatedData['checkout_time'])) {
            $target->checkout_time = $validatedData['checkout_time'];
        }

        if (isset($validatedData['tolerance'])) {
            $target->tolerance = $validatedData['tolerance'];
        }

        if (isset($validatedData['latitude'])) {
            $target->latitude = $validatedData['latitude'];
        }

        if (isset($validatedData['longitude'])) {
            $target->longitude = $validatedData['longitude'];
        }

        if (isset($validatedData['r_tolerance'])) {
            $target->r_tolerance = $validatedData['r_tolerance'];
        }

        $target->save();

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Update Divisi',
            'description' => 'Mengubah data divisi ' . $target->division_name,
        ]);

        return response()->json([
            'success' => true,
            'data' => $target,
            'old_data' => $oldData,
        ], 200);
    }

    public function addNewDivision(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "division_name" => "required|string|max:255",
            "address" => "required|string|max:1000",
            "office" => "required|in:head,branch",
            "checkin_time" => "required|date_format:H:i",
            "checkout_time" => "required|date_format:H:i",
            "latitude" => "required|numeric",
            "longitude" => "required|numeric",
            "tolerance" => "required|int|max:120",
            "r_tolerance" => "required|int",
        ], [
            "division_name.required" => "Nama divisi tidak boleh kosong",
            "division_name.max" => "Maksimal 100 karakter",
            "address.max" => "Maksimal 1000 karakter",
            "office.in" => "Kantor tidak valid",
            "checkin_time.required" => "Waktu checkin tidak boleh kosong",
            "checkout_time.required" => "Waktu checkout tidak boleh kosong",
            "tolerance" => "Toleransi Waktu maksimal 2 jam",
            "r_tolerance" => "nilai toleransi radius tidak valid",
            "latitude.numeric" => "nilai Latitude tidak valid",
            "longitude.numeric" => "nilai Longitude tidak valid",
        ]);

        if ($validator->fails()) {
            return response()->json([
                'Success' => false,
                'error' => $validator->errors(),
            ], 422);
        }

        $validatedData = $validator->validated();

        $target = division::create([
            "division_name" => $validatedData["division_name"],
            "office" => $validatedData["office"],
            "address" => $validatedData["address"],
            "checkin_time" => $validatedData["checkin_time"],
            "checkout_time" => $validatedData["checkout_time"],
            "latitude" => $validatedData["latitude"],
            "longitude" => $validatedData["longitude"],
            "tolerance" => $validatedData["tolerance"],
            "r_tolerance" => $validatedData["r_tolerance"],
        ]);

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Tambah Divisi',
            'description' => 'Menambahkan data divisi ' . $target->division_name,
        ]);

        match ($target->office) {
            "head" => $dataOffice = "Kantor Utama",
            "branch" => $dataOffice = "Kantor Cabang",
        };

        $newData = [
            'id_divisi' => $target->id,
            'nama_divisi' => $target->division_name,
            'kantor' => $dataOffice,
            'alamat_kantor' => $target->address,
            'waktu_checkin' => $target->checkin_time,
            'waktu_checkout' => $target->checkout_time,
            'latitude' => $target->latitude,
            'longitude' => $target->longitude,
            'toleransi_waktu' => $target->tolerance,
            'toleransi_radius' => $target->r_tolerance
        ];

        return response()->json([
            'success' => true,
            'data' => $newData,
        ], 200);
    }

    public function deleteDivision(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                "success" => false,
                "message" => "User tidak ditemukan!"
            ], 404);
        }

        if ($user->role != "admin") {
            return response()->json([
                "success" => false,
                "message" => "Anda tidak memiliki otoritas!"
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            "id" => "required|exists:division,id",
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

        $validatedData = $validator->validated();

        $target = division::find($validatedData["id"]);

        if (!$target) {
            return response()->json([
                "success" => false,
                "message" => "ID tidak ditemukan!",
            ], 404);
        }

        $employee = Employee::where('division_id', $target->id)->get();

        if ($employee->count() > 0) {
            return response()->json([
                "success" => false,
                "has_employee" => true,
                "message" => "Tidak dapat menghapus divisi yang masih memiliki karyawan!",
            ], 423);
        }

        $deletedData = $target->toArray();

        $target->delete();

        activity_log::create([
            'user_id' => $user->id,
            'activity_type' => 'Hapus Divisi',
            'description' => 'Menghapus data divisi ' . $target->division_name,
        ]);

        return response()->json([
            "success" => true,
            "message" => "Berhasil menghapus data!",
            "data" => $deletedData
        ], 200);
    }

}