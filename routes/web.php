<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});



Route::get('/dev', function () {
    $json = '{
        "2026": {
            "Januari": {
                "Mobile Devolopment": [
                    {
                        "date": "2026-01-18 19:48:24",
                        "company_id": "KKS59908",
                        "name": "Usyi Puspasari",
                        "division_name": "Mobile Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-01-30 17:55:19",
                        "company_id": "KKS28915",
                        "name": "Lega Dongoran",
                        "division_name": "Mobile Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Mobile Production": [
                    {
                        "date": "2026-01-15 17:09:48",
                        "company_id": "KKS19687",
                        "name": "Ophelia Mardhiyah",
                        "division_name": "Mobile Production",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-01-17 22:54:33",
                        "company_id": "KKS64688",
                        "name": "Janet Purwanti",
                        "division_name": "Mobile Production",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-01-31 10:48:49",
                        "company_id": "KSS1001",
                        "name": "David",
                        "division_name": "Mobile Production",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    }
                ],
                "Network": [
                    {
                        "date": "2026-01-19 01:29:09",
                        "company_id": "KKS40763",
                        "name": "Tami Kusmawati",
                        "division_name": "Network",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-01-19 15:36:15",
                        "company_id": "KKS48997",
                        "name": "Gandi Nugroho",
                        "division_name": "Network",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    }
                ],
                "Security Shift-1": [
                    {
                        "date": "2026-01-14 08:55:38",
                        "company_id": "KKS51350",
                        "name": "Ilsa Winda Usada",
                        "division_name": "Security Shift-1",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Security Shift-3": [
                    {
                        "date": "2026-01-16 23:59:52",
                        "company_id": "KKS37946",
                        "name": "Jasmin Wijayanti",
                        "division_name": "Security Shift-3",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-01-27 21:01:23",
                        "company_id": "KKS85771",
                        "name": "Umi Tina Mardhiyah",
                        "division_name": "Security Shift-3",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    }
                ],
                "WEB Devolopment": [
                    {
                        "date": "2026-01-12 19:11:05",
                        "company_id": "KKS69153",
                        "name": "Paramita Pertiwi",
                        "division_name": "WEB Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-01-14 19:29:40",
                        "company_id": "KKS57030",
                        "name": "Rina Haryanti",
                        "division_name": "WEB Devolopment",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-01-20 06:49:58",
                        "company_id": "KKS42203",
                        "name": "Lintang Farida",
                        "division_name": "WEB Devolopment",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-01-20 08:33:51",
                        "company_id": "KKS61785",
                        "name": "Galih Narpati M.Farm",
                        "division_name": "WEB Devolopment",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    }
                ]
            },
            "Februari": {
                "Mobile Devolopment": [
                    {
                        "date": "2026-02-08 11:48:43",
                        "company_id": "KKS21597",
                        "name": "Wani Farida",
                        "division_name": "Mobile Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-23 03:58:28",
                        "company_id": "KKS55436",
                        "name": "Vinsen Firgantoro",
                        "division_name": "Mobile Devolopment",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-02-24 03:41:17",
                        "company_id": "KKS6791",
                        "name": "Kemal Salahudin S.Pt",
                        "division_name": "Mobile Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Mobile Production": [
                    {
                        "date": "2026-02-02 14:22:20",
                        "company_id": "KKS3341",
                        "name": "Unjani Halimah",
                        "division_name": "Mobile Production",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-02-04 05:07:35",
                        "company_id": "KKS40856",
                        "name": "Yusuf Setiawan S.E.",
                        "division_name": "Mobile Production",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-02-09 01:53:33",
                        "company_id": "KKS84987",
                        "name": "Cakrawala Jaeman Simanjuntak",
                        "division_name": "Mobile Production",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-17 07:07:01",
                        "company_id": "KKS12217",
                        "name": "Sadina Wahyuni",
                        "division_name": "Mobile Production",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-19 22:18:02",
                        "company_id": "KKS16198",
                        "name": "Zelda Wijayanti",
                        "division_name": "Mobile Production",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Network": [
                    {
                        "date": "2026-02-02 22:42:28",
                        "company_id": "KKS66933",
                        "name": "Diah Laksita",
                        "division_name": "Network",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-02-04 07:07:27",
                        "company_id": "KKS24473",
                        "name": "Hafshah Wulandari S.I.Kom",
                        "division_name": "Network",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-02-15 13:56:40",
                        "company_id": "KKS5134",
                        "name": "Puti Zulaikha Lailasari S.Sos",
                        "division_name": "Network",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-17 18:34:15",
                        "company_id": "KKS64421",
                        "name": "Liman Kamidin Suryono",
                        "division_name": "Network",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Security Shift-1": [
                    {
                        "date": "2026-02-04 10:50:05",
                        "company_id": "KKS50652",
                        "name": "Legawa Nyana Najmudin",
                        "division_name": "Security Shift-1",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-02-07 03:37:36",
                        "company_id": "KKS32624",
                        "name": "Bakiadi Prakasa",
                        "division_name": "Security Shift-1",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-07 04:55:21",
                        "company_id": "KKS6511",
                        "name": "Atma Dariati Habibi S.Kom",
                        "division_name": "Security Shift-1",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    }
                ],
                "Security Shift-2": [
                    {
                        "date": "2026-02-05 23:57:07",
                        "company_id": "KKS25756",
                        "name": "Tania Halimah M.TI.",
                        "division_name": "Security Shift-2",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-23 22:10:21",
                        "company_id": "KKS53648",
                        "name": "Lukita Suryono",
                        "division_name": "Security Shift-2",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-02-27 17:33:32",
                        "company_id": "KKS92598",
                        "name": "Zulaikha Kusmawati S.IP",
                        "division_name": "Security Shift-2",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Security Shift-3": [
                    {
                        "date": "2026-02-13 16:16:07",
                        "company_id": "KKS68644",
                        "name": "Damu Adriansyah S.Ked",
                        "division_name": "Security Shift-3",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-13 18:26:23",
                        "company_id": "KKS1111",
                        "name": "Karma Nainggolan M.M.",
                        "division_name": "Security Shift-3",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-14 12:22:11",
                        "company_id": "KKS82606",
                        "name": "Ulya Winarsih",
                        "division_name": "Security Shift-3",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-20 21:30:37",
                        "company_id": "KKS82815",
                        "name": "Lega Rahmat Hidayat S.E.I",
                        "division_name": "Security Shift-3",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    },
                    {
                        "date": "2026-02-21 19:44:33",
                        "company_id": "KKS30118",
                        "name": "Eka Clara Oktaviani",
                        "division_name": "Security Shift-3",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "WEB Devolopment": [
                    {
                        "date": "2026-02-28 13:43:20",
                        "company_id": "KKS71030",
                        "name": "Restu Handayani",
                        "division_name": "WEB Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ]
            },
            "Maret": {
                "Mobile Devolopment": [
                    {
                        "date": "2026-03-02 14:08:11",
                        "company_id": "KKS68779",
                        "name": "Warsita Makara Prasetya S.E.I",
                        "division_name": "Mobile Devolopment",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-03-02 22:46:56",
                        "company_id": "KKS54701",
                        "name": "Calista Dewi Zulaika",
                        "division_name": "Mobile Devolopment",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-03-03 12:33:09",
                        "company_id": "KKS55610",
                        "name": "Leo Widodo S.Kom",
                        "division_name": "Mobile Devolopment",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-03-03 12:35:15",
                        "company_id": "KKS64477",
                        "name": "Baktianto Narpati",
                        "division_name": "Mobile Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Mobile Production": [
                    {
                        "date": "2026-03-07 19:09:22",
                        "company_id": "KKS17650",
                        "name": "Dadi Prayoga",
                        "division_name": "Mobile Production",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-03-08 01:39:03",
                        "company_id": "KKS58655",
                        "name": "Restu Nurul Andriani S.Pt",
                        "division_name": "Mobile Production",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Security Shift-1": [
                    {
                        "date": "2026-03-10 09:04:07",
                        "company_id": "KKS95984",
                        "name": "Kamaria Anggraini",
                        "division_name": "Security Shift-1",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    }
                ],
                "Security Shift-2": [
                    {
                        "date": "2026-03-01 04:08:19",
                        "company_id": "KKS72653",
                        "name": "Gatra Kuswoyo",
                        "division_name": "Security Shift-2",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "Security Shift-3": [
                    {
                        "date": "2026-03-02 01:47:16",
                        "company_id": "KKS72373",
                        "name": "Caturangga Najmudin S.Pt",
                        "division_name": "Security Shift-3",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-03-07 08:45:46",
                        "company_id": "KKS1669",
                        "name": "Zizi Yulianti",
                        "division_name": "Security Shift-3",
                        "status": "late",
                        "keterangan": "Hadir Terlambat"
                    },
                    {
                        "date": "2026-03-09 04:12:10",
                        "company_id": "KKS40579",
                        "name": "Artanto Damar Maheswara S.Pd",
                        "division_name": "Security Shift-3",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ],
                "WEB Devolopment": [
                    {
                        "date": "2026-03-04 09:58:11",
                        "company_id": "KKS98450",
                        "name": "Rahayu Wastuti",
                        "division_name": "WEB Devolopment",
                        "status": "on_time",
                        "keterangan": "Hadir"
                    }
                ]
            }
        }
    }';

    $data = json_decode($json, true);
    return view('export.all_report', compact('data'));
});
