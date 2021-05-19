<?php

namespace App\Controllers;

use App\Models\Barang_Model;
use App\Models\Admin_Model;
use App\Models\userModel;
use App\Models\Pengumuman_Model;
use App\Models\Komplain_Model;
use App\Models\ArsipKomp_Model;
use App\Models\Log_Model;
use App\Models\Absensi_Model;
use Dompdf\Dompdf;


class Exlapor extends BaseController
{
	/**
	 * Instance of the main Request object.
	 *
	 * @var HTTP\IncomingRequest
	 */
	protected $request; // Menghilangkan alert getPost()
	protected $session;
	protected $adminModel;
	protected $userModel;
	protected $barangModel;
	protected $newsModel;
	protected $komplainModel;
	protected $arsipKompModel;
	protected $Log_Model;
	protected $absensiModel;

	public function __construct()
	{
		$this->session = \Config\Services::session();
		$this->session->start();

		$this->adminModel = new Admin_Model();
		$this->userModel = new userModel();
		$this->barangModel = new Barang_Model();
		$this->newsModel = new Pengumuman_Model();
		$this->komplainModel = new Komplain_Model();
		$this->arsipKompModel = new ArsipKomp_Model();
		$this->LogModel = new Log_Model();
		$this->absensiModel = new Absensi_Model();
	}

  
  
  // =========================================================================================================
	// ======================================== Export & Print Data Admin ======================================
  // =========================================================================================================

	public function exceluser()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "EXCEL USER | INVENBAR",
					"user" => $this->adminModel->getUser(),
					"us" => $this->adminModel->countUser()
				];

				return view('admin/export/exxlsUser', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function docuser()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "DOC USER | INVENBAR",
					"user" => $this->adminModel->getUser(),
					"us" => $this->adminModel->countUser()
				];

				return view('admin/export/exdocUser', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfuser()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF USER | INVENBAR",
					"user" => $this->adminModel->getUser(),
					"us" => $this->adminModel->countUser()
				];

				$html = view('admin/export/expdfUser', $data);

				$dompdf = new Dompdf();
				$dompdf->loadHtml($html);
				$dompdf->setPaper('A4', 'potrait');
				$dompdf->render();
				$dompdf->stream('Data-User.pdf');
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function excelkomplain()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "EXCEL KOMPLAIN | INVENBAR",
					"user" => $this->adminModel->getUser(),
					'komplain' => $this->komplainModel->getKomplain(),
				];

				return view('admin/export/exxlsKomplain', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function dockomplain()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "DOC KOMPLAIN | INVENBAR",
					"user" => $this->adminModel->getUser(),
					'komplain' => $this->komplainModel->getKomplain(),
				];

				return view('admin/export/exdocKomplain', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfkomplain()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF KOMPLAIN | INVENBAR",
					"user" => $this->adminModel->getUser(),
					'komplain' => $this->komplainModel->getKomplain(),
				];

				$html = view('admin/export/expdfKomplain', $data);

				$dompdf = new Dompdf();
				$dompdf->loadHtml($html);
				$dompdf->setPaper('A4', 'potrait');
				$dompdf->render();
				$dompdf->stream('Data-Komplain.pdf');
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function excelabsensi()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "EXCEL ABSENSI | INVENBAR",
					'user' => $this->userModel->getUserId(session('uid')),
					"absensi" => $this->absensiModel->getAbsen(),
					"countWorked" => $this->absensiModel->countWorked(),
					"countNotWorked" => $this->absensiModel->countNotWorked()
				];

				return view('admin/export/exxlsAbsensi', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function docabsensi()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "DOC ABSENSI | INVENBAR",
					'user' => $this->userModel->getUserId(session('uid')),
					"absensi" => $this->absensiModel->getAbsen(),
					"countWorked" => $this->absensiModel->countWorked(),
					"countNotWorked" => $this->absensiModel->countNotWorked()
				];

				return view('admin/export/exdocAbsensi', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfabsensi()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF ABSENSI | INVENBAR",
					'user' => $this->userModel->getUserId(session('uid')),
					"absensi" => $this->absensiModel->getAbsen(),
					"countWorked" => $this->absensiModel->countWorked(),
					"countNotWorked" => $this->absensiModel->countNotWorked()
				];

				$html = view('admin/export/expdfAbsensi', $data);

				$dompdf = new Dompdf();
				$dompdf->loadHtml($html);
				$dompdf->setPaper('A4', 'potrait');
				$dompdf->render();
				$dompdf->stream('Data-Absensi.pdf');
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function excelaktivitas()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "EXCEL AKTIVITAS | INVENBAR"
				];

				return view('admin/export/exxlsAktivitas', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function docaktivitas()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "DOC AKTIVITAS | INVENBAR"
				];

				return view('admin/export/exdocAktivitas', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfaktivitas()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF AKTIVITAS | INVENBAR"
				];

				$html = view('admin/export/expdfAktivitas', $data);

				$dompdf = new Dompdf();
				$dompdf->loadHtml($html);
				$dompdf->setPaper('A4', 'potrait');
				$dompdf->render();
				$dompdf->stream('Data-Aktivitas.pdf');
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function excelizin()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "EXCEL PERIZINAN | INVENBAR",
					"log_item" => $this->LogModel->ReadLogItem(),
					"log_notifs" => $this->LogModel->notifsLog(),
					"komplain_notifs" => $this->komplainModel->notifsKomplain()
				];

				return view('admin/export/exxlsIzin', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function docizin()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "DOC PERIZINAN | INVENBAR",
					"log_item" => $this->LogModel->ReadLogItem(),
					"log_notifs" => $this->LogModel->notifsLog(),
					"komplain_notifs" => $this->komplainModel->notifsKomplain()
				];

				return view('admin/export/exdocIzin', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfizin()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF PERIZINAN | INVENBAR",
					"log_item" => $this->LogModel->ReadLogItem(),
					"log_notifs" => $this->LogModel->notifsLog(),
					"komplain_notifs" => $this->komplainModel->notifsKomplain()
				];

				$html = view('admin/export/expdfIzin', $data);

				$dompdf = new Dompdf();
				$dompdf->loadHtml($html);
				$dompdf->setPaper('A4', 'potrait');
				$dompdf->render();
				$dompdf->stream('Data-Perizinan.pdf');
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintUser()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF USER | INVENBAR",
					"user" => $this->adminModel->getUser(),
					"us" => $this->adminModel->countUser()
				];
				return view('admin/print/printUser', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintKomplain()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF KOMPLAIN | INVENBAR",
					"user" => $this->adminModel->getUser(),
					'komplain' => $this->komplainModel->getKomplain()
				];

				return view('admin/print/printKomplain', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintAktivitas()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF AKTIVITAS | INVENBAR"
				];

				return view('admin/print/printAktivitas', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintAbsensi()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF Absensi | INVENBAR",
					'user' => $this->userModel->getUserId(session('uid')),
					"absensi" => $this->absensiModel->getAbsen(),
					"countWorked" => $this->absensiModel->countWorked(),
					"countNotWorked" => $this->absensiModel->countNotWorked()
				];

				return view('admin/print/printAbsensi', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintIzin()
	{
		// seleksi login
		if (session('uid') != null) {
			// jika user merupakan Admin
			if (session('role') == 0) {
				$data = [
					"title" => "PDF PERIZINAN | INVENBAR",
					"log_item" => $this->LogModel->ReadLogItem(),
					"log_notifs" => $this->LogModel->notifsLog(),
					"komplain_notifs" => $this->komplainModel->notifsKomplain()
				];

				return view('admin/print/printIzin', $data);
			} else {
				return redirect()->to('/dashboard');
			}
		} else {
			return redirect()->to('/login');
		}
	}

  
  
  // =========================================================================================================
	// ==================================== Export & Print Data Global =========================================
  // =========================================================================================================
	public function excelbarang()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "Excel BARANG | INVENBAR",
				"item" => $this->barangModel->getItems()
			];

			return view('global/export/exxlsBarang', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function docbarang()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "DOC BARANG | INVENBAR",
				"item" => $this->barangModel->getItems()
			];

			return view('global/export/exdocBarang', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfbarang()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF BARANG | INVENBAR",
				"item" => $this->barangModel->getItems()
			];

			$html = view('global/export/expdfBarang', $data);

			$dompdf = new Dompdf();
			$dompdf->loadHtml($html);
			$dompdf->setPaper('A4', 'potrait');
			$dompdf->render();
			$dompdf->stream('Tabel-Barang-Gudang-2021.pdf');
		} else {
			return redirect()->to('/login');
		}
	}

	public function excelspesifikasi()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "EXCEL SPESIFIKASI | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier()
			];

			return view('global/export/exxlsSpesifikasi', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function docspesifikasi()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "DOC SPESIFIKASI | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier()
			];

			return view('global/export/exdocSpesifikasi', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfspesifikasi()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF SPESIFIKASI | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier()
			];

			$html = view('global/export/expdfSpesifikasi', $data);

			$dompdf = new Dompdf();
			$dompdf->loadHtml($html);
			$dompdf->setPaper('A4', 'potrait');
			$dompdf->render();
			$dompdf->stream('Tabel-Spesifikasi-Barang-2021.pdf');
		} else {
			return redirect()->to('/login');
		}
	}

	public function excelstatizin()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "EXCEL STATUS PERIZINAN | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier(),
				"log_item" => $this->LogModel->ReadLogItem(),
			];

			return view('global/export/exxlsStatizin', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function docstatizin()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "DOC STATUS PERIZINAN | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier(),
				"log_item" => $this->LogModel->ReadLogItem(),
			];

			return view('global/export/exdocStatizin', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfstatizin()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF STATUS PERIZINAN | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier(),
				"log_item" => $this->LogModel->ReadLogItem(),
			];

			$html = view('global/export/expdfStatizin', $data);

			$dompdf = new Dompdf();
			$dompdf->loadHtml($html);
			$dompdf->setPaper('A4', 'potrait');
			$dompdf->render();
			$dompdf->stream('Status-Perizinan.pdf');
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfchart1()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF CHART-1 | INVENBAR",
				"sj1" => $this->barangModel->stockjenis1(),
				"sj2" => $this->barangModel->stockjenis2(),
				"sj3" => $this->barangModel->stockjenis3(),
				"sj4" => $this->barangModel->stockjenis4(),
				"sj5" => $this->barangModel->stockjenis5()
			];

			return view('global/print/printChart1', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfchart2()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF CHART-2 | INVENBAR",
				"sc1" => $this->barangModel->stockclass1(),
				"sc2" => $this->barangModel->stockclass2(),
				"sc3" => $this->barangModel->stockclass3(),
				"sc4" => $this->barangModel->stockclass4(),
				"sc5" => $this->barangModel->stockclass5(),
				"sc6" => $this->barangModel->stockclass6(),
				"sc7" => $this->barangModel->stockclass7(),
				"cc1" => $this->barangModel->costclassA(),
				"cc2" => $this->barangModel->costclassB(),
				"cc3" => $this->barangModel->costclassC(),
				"cc4" => $this->barangModel->costclassD(),
				"cc5" => $this->barangModel->costclassE(),
				"cc6" => $this->barangModel->costclassF(),
				"cc7" => $this->barangModel->costclassG(),
				"cw1" => $this->barangModel->weightclassA(),
				"cw2" => $this->barangModel->weightclassB(),
				"cw3" => $this->barangModel->weightclassC(),
				"cw4" => $this->barangModel->weightclassD(),
				"cw5" => $this->barangModel->weightclassE(),
				"cw6" => $this->barangModel->weightclassF(),
				"cw7" => $this->barangModel->weightclassG()
			];

			return view('global/print/printChart2', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfchart3()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF CHART-3 | INVENBAR",
				"inc" => $this->LogModel->stockIncome(),
				"otc" => $this->LogModel->stockOutcome()
			];

			return view('global/print/printChart3', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfchart4()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF CHART-4 | INVENBAR",
				"cf" => $this->userModel->countFemale(),
				"cm" => $this->userModel->countMale()
			];

			return view('global/print/printChart4', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintBarang()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF BARANG | INVENBAR",
				"item" => $this->barangModel->getItems()
			];

			return view('global/print/printBarang', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintSpesifikasi()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF SPESIFIKASI | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier()
			];

			return view('global/print/printSpesifikasi', $data);
		} else {
			return redirect()->to('/login');
		}
	}

	public function pdfprintStatizin()
	{
		if (session('uid') != null) {
			$data = [
				"title" => "PDF STATUS PERIZINAN | INVENBAR",
				"item" => $this->barangModel->getItems(),
				"supplier" => $this->barangModel->viewSuppliers(),
				"spec" => $this->barangModel->joinSupplier(),
				"log_item" => $this->LogModel->ReadLogItem(),
			];

			return view('global/print/printStatizin', $data);
		} else {
			return redirect()->to('/login');
		}
	}
}