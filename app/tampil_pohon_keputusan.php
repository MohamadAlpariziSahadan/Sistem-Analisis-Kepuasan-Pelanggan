
    <!-- Main content -->

    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
             
              <!-- /.card-header -->
               <div class="card-header">
                   <h3 class="card-title">Pohon Keputusan </h3>
              </div>

              <div>
                  <?php 
                  include('../conf/config.php');

			            generatePohonC45('0', 0);
                  function generatePohonC45($idparent, $spasi){
                   
                  include('../conf/config.php');
                  $result = mysqli_query($koneksi,"select * from pohon_keputusan_c45 where id_parent= '$idparent'");
                 
                  while($row=mysqli_fetch_row($result)){
                  
                    for($i=1;$i<=$spasi;$i++){
                     echo "| &nbsp;&nbsp;";
                    }
                   

                    if ($row[6] === 'Puas') {
                        $keputusan = "<font color=green>$row[6]</font>";
                    } else if ($row[6] === 'Tidak Puas') {
                      $keputusan = "<font color=red>$row[6]</font>";
                    } else if ($row[6] === '?') {
                      $keputusan = "<font color=blue>$row[6]</font>";
                    } else {
                      $keputusan = "<b>$row[6]</b>";
                    }
                      echo "<font color=red>$row[1]</font> = $row[2] (Puas = $row[4], Tidak Puas = $row[5]) : <b>$keputusan</b><br>";
                               
                  /*panggil dirinya sendiri*/
              
                  generatePohonC45($row[0], $spasi + 1);
                  
                  }
                }
                  
                  ?>
              </div>
              
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


 