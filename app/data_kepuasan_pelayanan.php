
    <!-- Main content -->

    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
             
              <!-- /.card-header -->
               <div class="card-header">
               <form action="" method="GET">
              <div class="form-group">
                  <label>Pilih Jenis Data Pelayanan</label>
                  <select name="jenis" class="form-control" style="width: 25%;">
                    
                    <option selected>Pelayanan Administrasi</option>
                    <option>Pelayanan Perkara</option>
                    <option>Pelayanan Hukum</option>
                    <option>Pelayanan Teknis</option>
                  </select>
                  <input type="submit" value="OK">
                </div>           
              
              <?php 
                
                if (isset($_GET['jenis'])){
                  $jenisd = $_GET['jenis'];
                }else{
                  $jenisd = "Pelayanan Administrasi";
                }
              ?>
                <h3 class="card-title">Data Kepuasan Pelanggan Terhadap <?php echo $jenisd ?></h3>
              </div>
                <table id="example2" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                    <th>Pelanggan</th>
                    <th>Pelayanan</th>
                    <th>Biaya</th>
                    <th>Sikap</th>
                    <th>Kemampuan</th>
                    <th>Hasil</th>
                  </tr>
                  </thead>
                  <tbody>
                  <?php 
                  
                  
                //include('../conf/config.php');
                  
                  if ($jenisd=="Pelayanan Administrasi"){
                      $query = mysqli_query($koneksi,'SELECT * FROM tb_pelayanan_administrasi');
                    }
                    else if ($jenisd=="Pelayanan Perkara"){
                      $query = mysqli_query($koneksi,'SELECT * FROM tb_pelayanan_perkara');
                    }
                    else if ($jenisd=="Pelayanan Hukum"){
                      $query = mysqli_query($koneksi,'SELECT * FROM tb_pelayanan_hukum');
                    }
                    else if ($jenisd=="Pelayanan Teknis"){
                      $query = mysqli_query($koneksi,'SELECT * FROM tb_pelayanan_teknis');
                    }
                 
                  while ($hasil =mysqli_fetch_array ( $query )){
                  ?>
                  <tr>
                  
                      <td><?php echo $hasil['id']?></td>
                      <td><?php echo $hasil['pelayanan']?></td>
                      <td><?php echo $hasil['biaya']?></td>
                      <td><?php echo $hasil['sikap']?></td>
                      <td><?php echo $hasil['kemampuan']?></td>
                      <td><?php echo $hasil['hasil']?></td>
                    </tr>
                  <?php }?>
                  
                </table>
              </div>
              </form>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </section>

 