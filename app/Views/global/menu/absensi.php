<?= $this->extend('layout/template') ?>

<?= $this->section('content') ?>
<link rel="stylesheet" href="<?= base_url('css/menukhusus.css') ?>">

<!--Main layout-->
<main class="bg-dark">
	<div class="container pt-4">
		<section class="mb-4">
			<div class="card">
				<?php if (session()->getFlashdata('pesan')) : ?>
					<div class="alert alert-success" role="alert">
						<h4><?= session()->getFlashdata('pesan'); ?></h4>
					</div>
				<?php endif ?>
				<?php if (session()->getFlashdata('alert')) : ?>
					<div class="alert alert-danger" role="alert">
						<h4><?= session()->getFlashdata('alert'); ?></h4>
					</div>
				<?php endif ?>
				<div class="card-header text-center py-3">
					<h5 class="mb-0 text-center">
						<strong><i class="fas fa-fw fa-clipboard mr-2"></i> Absensi Pekerja</strong>
					</h5>
				</div>
				<div class="card-body pt-1 bg-light">
					<div class="container mb-3 pb-2" style="border-bottom: 1px solid #dfdfdf;">
						<div class="row no-gutters">
							<div class="col-md-6">
								<img src="<?= base_url("img/ibpk.png"); ?>" class="card-img" alt="img-1">
							</div>
							<div class="col-md-6 border-left">
								<div class=" card-body event-description">
									<form action="<?= ($absensi == false) ? base_url('/menu/absen') : ""; ?>" method="POST" enctype="multipart/form-data">
										<?= csrf_field(); ?>
										<div class="form-group absensi-content">
											<label class="col-12">
												<p class="card-text"><i class="fas fa-user fa-fw me-1"></i><b class="col-4 p-0">Nama <span class="col-2 p-1"> : </span></b><?= $user['nama']; ?></p>
											</label>
										</div>
										<div class="form-group absensi-content">
											<label class="col-12">
												<p class="card-text"><i class="fas fa-envelope-open-text fa-fw me-1"></i><b class="col-4 p-0">Email <span class="col-2 p-1"> : </span></b><?= $user['email']; ?></p>
											</label>
										</div>
										<div class="form-group absensi-content">
											<label class="col-12">
												<p class="card-text"><i class="fas fa-laptop-house fa-fw me-1"></i><b class="col-4 p-0">Divisi<span class="col-2 p-1"> : </span></b><?= $user_division['nama_divisi']; ?></p>
											</label>
										</div>
										<div class="form-group absensi-content">
											<label class="col-12">
												<p class="card-text"><i class="fas fa-venus-mars fa-fw me-1"></i><b class="col-4 p-0">Gender<span class="col-2 p-1"> : </span></b><?= $user['gender']; ?></p><br>
											</label>
										</div>
										<div class="col-12 pp">
											<?php if (date("l") != "Saturday" and date("l") != "Sunday") : ?>
												<?php if (date("H:i:s") <= "16:15:05") : ?>
													<div class="form-group absensi-content">
														<label class="col-12">
															<b class="col-4"><i class="fas fa-file-signature fa-fw me-1"></i>Status:</b>
															<?php if ($absensi == false) : ?>
																<span><small>Belum Absensi</small></span>
															<?php else : ?>
																<span><small>Sudah Absensi</small></span>
															<?php endif; ?>
														</label>
													</div>
													<div class="">
														<input type="hidden" class="form-control" value="<?= ($absensi == false) ? $user['email'] : ""; ?>" name="email_absen">
														<button type="submit" class="btn btn-success btn-absensi p-3 btn-left" <?= ($absensi == false) ? "" : "disabled"; ?>>
															<p class="text-center nama_tombol"><i class="fas fa-briefcase fa-fw me-1"></i>Absensi Sekarang</p>
														</button>
													</div>
												<?php else : ?>
													<div class="">
														<button type="submit" class="btn btn-success btn-akhir-sesi p-3 btn-left" disabled>
															<p class="text-center nama_tombol"><i class="fas fa-briefcase fa-fw me-1"></i>Sesi Absen Berakhir</p>
														</button>
													</div>
												<?php endif; ?>
												<div class="">
													<button type="button" class="btn btn-success btn-izin p-3 btn-right" data-toggle="modal" data-target="<?= ($izin == false) ? "#Izin" : ""; ?>" <?= ($izin == false) ? "" : "disabled"; ?>>
														<p class="text-center nama_tombol"><i class="far fa-envelope me-1"></i>Ajukan Izin</p>
													</button>
												</div>
											<?php else : ?>
												<div class="form-group absensi-content">
													<label for="status_absen">
														<i class="fas fa-file-signature fa-fw me-1"></i>
														<b>Status:</b> <span><small>Hari Libur</small></span>
													</label>
												</div>
											<?php endif; ?>
										</div>
									</form>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</section>
	</div><br>
</main>

<!-- Izin Modal -->
<div class="modal fade" id="Izin" tabindex="-1" aria-labelledby="IzinLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-light">
				<h5 class="modal-title" id="IzinLabel">Pengajuan Izin</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="<?= ($absensi == false) ? base_url('/menu/absen') : ""; ?>" method="POST" enctype="multipart/form-data">
					<?= csrf_field(); ?>
					<div class="form-group">
						<label for="alasanIzin">Alasan Izin</label>
						<textarea class="col-sm-12 p-2 <?= ($validation->hasError('alasanIzin')) ? 'is-invalid' : ''; ?>" id="alasanIzin" name="alasanIzin" placeholder="Tuliskan Alasan Izin Anda"></textarea>
						<div class="invalid-feedback">
							<?= $validation->getError('alasanIzin'); ?>
							<!-- pesan eror -->
						</div>
					</div>
					<div class="form group">
						<label for="foto">Bukti Izin</label>
						<div class="col">
							<input class="form-control <?= ($validation->hasError('foto')) ? 'is-invalid' : ''; ?>" type="file" id="foto" name="foto" onchange='imgPreview()'>
							<div class="invalid-feedback">
								<?= $validation->getError('foto'); ?>
								<!-- pesan eror -->
							</div>
						</div>
						<div class="col-7 mx-auto">
							<img src="" class="img-thumbnail img-preview">
						</div>
					</div>
					<div class="modal-footer">
						<input type="hidden" class="form-control" value="<?= ($absensi == false) ? $user['email'] : ""; ?>" name="email_absen">
						<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-fw fa-window-close"></i> Batal</button>
						<button type="submit" class="btn btn-primary"><i class="fas fa-check-square fa-fw"></i> Selesai</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<?= $this->endSection() ?>