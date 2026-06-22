<!doctype html>
<html>

<head>
    <meta charset="utf-8" />
    <style>
        body {
            font-family: "DejaVu Sans", sans-serif;
            font-size: 12px;
            margin: 0;
            padding: 0;
        }

        /* ====== KOP ====== */
        .kop {
            padding: 0px 0px 0px 0px;
        }

        .kop table {
            width: 100%;
            height: fit-content;
            border-collapse: collapse;
        }

        .kop td {
            border: none;
        }

        .kop-left {
            width: 30%;
            vertical-align: middle;
        }

        .kop-left img {
            height: 1cm;
            width: auto;
        }

        .kop-right {
            width: 70%;
            vertical-align: top;
        }

        .kop-info {
            width: 68%;
            font-size: 10px;
            line-height: 1.3;
            vertical-align: middle;
            text-align: right;
        }

        .kop-info .title {
            font-weight: bold;
        }

        .vertical-line {
            width: 3px;
            height: 80px;
            border-radius: 2px;
            overflow: hidden;
            margin: auto;
        }

        .vertical-line .orange {
            background-color: #f7941d;
            height: 50%;
        }

        .vertical-line .blue {
            background-color: #545454;
            height: 50%;
        }

        .kop-social {
            width: 30%;
            font-size: 10px;
            line-height: 1.3;
            padding-left: 10px;
            vertical-align: middle !important;
            text-align: center;
        }

        .kop-social-inner {
            display: inline-block;
            vertical-align: middle;
        }

        .kop-social .row {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .kop-social img {
            width: 16px;
            height: 16px;
        }

        /* ====== GARIS BAWAH KOP ====== */
        .kop-line {
            width: 100%;
            border-collapse: collapse;
            margin-top: 5px;
            margin-bottom: 10px;
            padding-right: 20px;
            padding-left: 20px;
        }

        .kop-line td {
            padding: 0;
            line-height: 0;
            height: 1.5px;
            border: none;
        }

        .kop-line .orange-line {
            border-top: 3px solid #f7941d;
            width: 45%;
            height: 0;
        }

        .kop-line .blue-line {
            border-top: 3px solid #545454;
            width: 55%;
            height: 0;
        }

        /* ====== ISI ====== */
        .content {
            margin-top: 8px;
            margin-right: 40px;
            margin-bottom: 20px;
            margin-left: 40px;
        }

        .content .title {
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .content h3 {
            text-align: center;
            font-size: 14px;
            font-weight: bold;
            line-height: 1.5;
        }

        .content th,
        td {
            margin: 20px 40px;
            border: 1px solid #000;
            padding: 8px;
            text-align: left;
        }

        .content table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #f2f2f2;
        }

        /* ====== FOOTER ====== */
        .footer {
            position: fixed;
            left: 0;
            right: 0;
            width: 100%;
            font-size: 10px;
            background-color: #fff;
            text-align: center;
            padding-top: 20px;
            padding-bottom: 5px;
            margin-top: 1024px;
        }

        /* Ganti garis bawah jadi flex container */
        .footer-line {
            position: fixed;
            bottom: 10px;
            left: 0;
            right: 0;
            width: 100%;
            border-collapse: collapse;
            padding: 0 20px;
        }

        .footer-line td {
            padding: 0;
            line-height: 0;
            height: 1.5px;
            border: none;
        }

        .footer-line .orange-line {
            border-top: 3px solid #f7941d;
            width: 45%;
            height: 0;
        }

        .footer-line .blue-line {
            border-top: 3px solid #545454;
            width: 55%;
            height: 0;
        }

        .footer-content table {
            width: auto;
            margin: 0 auto;
            border-collapse: separate;
            border-spacing: 20px 0;
            border: none;
        }

        .footer-content td.footer-item {
            width: 1%;
            padding: 0;
            vertical-align: middle;
            text-align: center;
            white-space: nowrap;
            border: none;
        }

        .footer-content span {
            vertical-align: middle;
            position: relative;
            top: -2px;
        }

        .footer-content img {
            width: 16px;
            height: 16px;
            vertical-align: middle;
            margin-right: 3px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 4px 0;
        }

        .summary-row span:first-child {
            font-weight: bold;
        }
    </style>
</head>

<body>
    <div class="kop">
        <table>
            <tr>
                <!-- Kiri: Logo -->
                <td class="kop-left">
                    <img src="{{ base_path('storage/app/public/images/logo_keraton.png') }}" alt="Logo Keraton" />
                </td>

                <!-- Kanan: Info | Garis | Sosial Media -->
                <td class="kop-right">
                    <table>
                        <tr style="vertical-align: middle">
                            <td class="kop-info">
                                <div class="title">
                                    CV. Keraton Karya Solusi
                                </div>
                                <div>Jl. Tenggilis Utara IX No.8</div>
                                <div>
                                    Tenggilis Mejoyo, Kec. Tenggilis Mejoyo
                                </div>
                                <div>Surabaya, Jawa Timur 60292</div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <!-- Garis bawah kop -->
    <table class="kop-line">
        <tr>
            <td class="orange-line"></td>
            <td class="blue-line"></td>
        </tr>
    </table>

    @foreach ($data as $year => $months)
        <div class="content">
            <div class="title">
                <h3>
                    REKAP KEHADIRAN CV. KERATON KARYA SOLUSI TAHUN : {{ $year }}
                </h3>
            </div>

            @foreach ($months as $month => $datas)
                <h3>Rekapan Bulan : {{ $month }}</h3>
                <div class="summary-row">
                    <span>Nama Divisi :</span>
                    <span>{{ implode(', ', $datas['summary']['divisi']->toArray()) }}</span>
                </div>
                <div class="summary-row">
                    <span>Jumlah Data :</span>
                    <span>{{ $datas['summary']['jumlah_data'] }}</span>
                </div>
                <div class="summary-row">
                    <span>Jumlah Telat :</span>
                    <span>{{ $datas['summary']['jumlah_telat'] }}</span>
                </div>
                <div class="summary-row">
                    <span>Jumlah Tidak Hadir :</span>
                    <span>{{ $datas['summary']['jumlah_tidak_hadir'] }}</span>
                </div>
                <br\>
                    <table>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Tanggal</th>
                                <th>Kode</th>
                                <th>Nama Karyawan</th>
                                <th>Nama Divisi</th>
                                <th>Kehadiran</th>
                                <th>Keterangan</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($datas['records'] as $i => $emp)
                                <tr>
                                    <td>{{ $i + 1 }}</td>
                                    <td>{{ Carbon\Carbon::parse($emp['date'])->translatedFormat('d F Y') }}</td>
                                    <td>{{ $emp['company_id'] }}</td>
                                    <td>{{ $emp['name'] }}</td>
                                    <td>{{ $emp['division_name'] }}</td>
                                    @php
                                        $status = $emp['status'] == 'on_time' || $emp['status'] == 'late' ? 'Hadir' : 'Tidak Hadir'
                                    @endphp
                                    <td>{{ $status }}</td>
                                    <td>{{ $emp['keterangan'] }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                    <div style="page-break-after: always;"></div>
            @endforeach
        </div>
    @endforeach


    <table class="footer-line">
        <tr>
            <td class="orange-line"></td>
            <td class="blue-line"></td>
        </tr>
    </table>

    <div class="footer">
        <div class="footer-content">
            <table>
                <tr>
                    <td class="footer-item">
                        <img src="{{ base_path('storage/app/public/images/website.png') }}" alt="Website" />
                        <span>www.keraton.co.id</span>
                    </td>
                    <td class="footer-item">
                        <img src="{{ base_path('storage/app/public/images/email.png') }}" alt="Email" />
                        <span>info@keraton.co.id</span>
                    </td>
                    <td class="footer-item">
                        <img src="{{ base_path('storage/app/public/images/phone.png') }}" alt="Phone" />
                        <span>(+62) 3191199304</span>
                    </td>
                    <td class="footer-item">
                        <img src="{{ base_path('storage/app/public/images/live-chat.png') }}" alt="Call Center" />
                        <span>(+62) 8123235293</span>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>

</html>