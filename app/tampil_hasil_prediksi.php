<?php 
  include('../conf/config.php');
  $akurasi = mysqli_query($koneksi,"select akurasi from hasil_prediksi where tahap = '1'");
  $akurasi2 = mysqli_query($koneksi,"select * from hasil_prediksi where tahap = '2'");
  $recall_puas = mysqli_query($koneksi,"select recall_puas from hasil_prediksi where tahap = '1'");
  $recall_puas2 = mysqli_query($koneksi,"select recall_puas from hasil_prediksi where tahap = '2'");
  $recall_tdk_puas = mysqli_query($koneksi,"select recall_tdk_puas from hasil_prediksi where tahap = '1'");
  $recall_tdk_puas2 = mysqli_query($koneksi,"select recall_tdk_puas from hasil_prediksi where tahap = '2'");
  $precision_puas = mysqli_query($koneksi,"select precision_puas from hasil_prediksi where tahap = '1'");
  $precision_puas2 = mysqli_query($koneksi,"select precision_puas from hasil_prediksi where tahap = '2'");
  $precision_tdk_puas = mysqli_query($koneksi,"select precision_tdk_puas from hasil_prediksi where tahap = '1'");
  $precision_tdk_puas2 = mysqli_query($koneksi,"select precision_tdk_puas from hasil_prediksi where tahap = '2'");
?>
<!-- Main content -->
<section class="content">
      <div class="container-fluid">
        <div class="row">
          
          <!-- /.col (LEFT) -->
          <div class="col-md-6">
            <!-- BAR CHART -->
            <div class="card card-success">
              <div class="card-header">
                <h3 class="card-title">Pengujian Tahap 1</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <div class="card-body">
                <div class="chart">
                  <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                  <script>
                    const labels = [
                      'Pelayanan Administrasi',
                      'Pelayanan Perkara',
                      'Pelayanan Hukum',
                      'Pelayanan Teknis',
                    ];

                    const data = {
                      labels: labels,
                      datasets: [
                        {
                          label               : 'Akurasi',
                          backgroundColor     : 'crimson',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : '#3b8bba',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($akurasi)){ echo '"'.$row['akurasi'].'",';}?>],
                        },
                        {
                          label               : 'Recall Puas',
                          backgroundColor     : 'dark orange',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($recall_puas)){ echo '"'.$row['recall_puas'].'",';}?>],
                        },
                        {
                          label               : 'Recall Tidak Puas',
                          backgroundColor     : 'aqua',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($recall_tdk_puas)){ echo '"'.$row['recall_tdk_puas'].'",';}?>],
                        },
                        {
                          label               : 'Precision Puas',
                          backgroundColor     : 'rgb(240, 128, 128)',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($precision_puas)){ echo '"'.$row['precision_puas'].'",';}?>],
                        },
                        {
                          label               : 'Precision Tidak Puas',
                          backgroundColor     : 'rgb(40, 178, 170)',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($precision_tdk_puas)){ echo '"'.$row['precision_tdk_puas'].'",';}?>],
                        }
                    ]
                    };

                    const config = {
                      type: 'bar',
                      data: data,
                      options: {
                        scales: {
                          x: {
                              stacked: true
                          },
                          y: {
                              stacked: true
                          }
                      }}
                    };

                    const myChart = new Chart(document.getElementById('barChart'),
                      config
                    );
                  </script>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- STACKED BAR CHART -->
            <div class="card card-success">
              <div class="card-header">
                <h3 class="card-title">Pengujian Tahap 2</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <div class="card-body">
                <div class="chart">
                  <canvas id="barChart_2" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                  <script>
                    const labels2 = [
                      'Pelayanan Administrasi',
                      'Pelayanan Perkara',
                      'Pelayanan Hukum',
                      'Pelayanan Teknis',
                    ];

                    const data2 = {
                      labels: labels2,
                      datasets: [
                        {
                          label               : 'Akurasi',
                          backgroundColor     : 'crimson',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : '#3b8bba',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($akurasi2)){ echo '"'.$row['akurasi'].'",';}?>],
                        },
                        {
                          label               : 'Recall Puas',
                          backgroundColor     : 'dark orange',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($recall_puas2)){ echo '"'.$row['recall_puas'].'",';}?>],
                        },
                        {
                          label               : 'Recall Tidak Puas',
                          backgroundColor     : 'aqua',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($recall_tdk_puas2)){ echo '"'.$row['recall_tdk_puas'].'",';}?>],
                        },
                        {
                          label               : 'Precision Puas',
                          backgroundColor     : 'rgb(240, 128, 128)',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($precision_puas2)){ echo '"'.$row['precision_puas'].'",';}?>],
                        },
                        {
                          label               : 'Precision Tidak Puas',
                          backgroundColor     : 'rgb(40, 178, 170)',
                          borderColor         : 'rgba(60,141,188,0.8)',
                          pointRadius          : false,
                          pointColor          : 'orange',
                          pointStrokeColor    : 'rgba(60,141,188,1)',
                          pointHighlightFill  : '#fff',
                          pointHighlightStroke: 'rgba(60,141,188,1)',
                          data: [<?php while ($row=mysqli_fetch_array($precision_tdk_puas2)){ echo '"'.$row['precision_tdk_puas'].'",';}?>],
                        }
                    ]
                    };

                    const config2 = {
                      type: 'bar',
                      data: data2,
                      options: {
                        scales: {
                          x: {
                              stacked: true
                          },
                          y: {
                              stacked: true
                          }
                      }}
                    };

                    const myChart1 = new Chart(document.getElementById('barChart_2'),
                      config2
                    );
                  </script>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

          </div>
          <!-- /.col (RIGHT) -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>