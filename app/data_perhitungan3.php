
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
                    
                    <option selected><?php echo "Pelayanan Administrasi"?></option>
                    <option>Pelayanan Perkara</option>
                    <option>Pelayanan Hukum</option>
                    <option>Pelayanan Teknis</option>
                  </select>
                  <input type="submit" value="OK">
                </div>           
              
              <?php 
                $jenisd;
                if (isset($_GET['jenis'])){
                  $jenisd = $_GET['jenis'];
                }else{
                  $jenisd = "Pelayanan Administrasi";
                }
              ?>
                <h3 class="card-title">Data Perhitungan C.45 Terhadap <?php echo $jenisd ?></h3>
              </div>
              
                  <?php 
                  
                  include ('../conf/perhitungan-miningC45.php');
                  $tabel;
                  if ($jenisd=="Pelayanan Administrasi"){
                    $tabel="tb_pelayanan_administrasi";
                  }
                  else if ($jenisd=="Pelayanan Perkara"){
                    $tabel="tb_pelayanan_perkara";
                  }
                  else if ($jenisd=="Pelayanan Hukum"){
                    $tabel="tb_pelayanan_hukum";
                  }
                  else if ($jenisd=="Pelayanan Teknis"){
                    $tabel="tb_pelayanan_teknis";
                  }
                  populateDb();
                  miningC45('', '',$tabel);

			
                  $node1 = mysqli_query($koneksi,"select id, node from iterasi_c45 where atribut= 'Total' and node='' LIMIT 1");
                  $rowNode1 = mysqli_fetch_array($node1);
                  mysqli_query($koneksi,"UPDATE iterasi_c45 SET node = '1' WHERE id = $rowNode1[0]");
                  $arrLv=array(0,0,0,0);
                  
		  generateNode('0', 1,$arrLv);
                  $lva="";
                  
                  
                  
                  function generateNode($idparent, $spasi, $arrLv){
                    $lv="";
                    
                    
                  include('../conf/config.php');
                  $result = mysqli_query($koneksi,"select * from pohon_keputusan_c45 where id_parent= '$idparent'");
                  $arrLv[0]=0;
                  $j= mysqli_num_rows($result);
                  while($row=mysqli_fetch_row($result)){
                    $kondisiAtribut="";
                    if ($row[6] === '?') {
                      if($j<>0){
                        $arrLv[$spasi]+=1;
                      }
                    }
                    
                    $lv="1";
                    $lva="";
                    for($i=1;$i<=$spasi;$i++){
                      $lva=$lva.".".$arrLv[$i];
                    }
                    $lva=$lv.$lva;
                    
                    if ($row[6] == '?') {
                      if($spasi<3){
                        $node = mysqli_query($koneksi,"select id, node from iterasi_c45 where atribut= 'Total' and node='' LIMIT 1");
                        $rowNode = mysqli_fetch_array($node);
                        if (mysqli_num_rows($node)>0){
                        mysqli_query($koneksi,"UPDATE iterasi_c45 SET node = '$lva' WHERE id = $rowNode[0]");
                        $kondisiAtribut = str_replace("~", "", $row[8]); 
                        $kondisiAtribut = str_replace("=", "", $kondisiAtribut); 
                        $kondisiAtribut = substr_replace($kondisiAtribut,"",0,3);
                        $kondisiAtribut = preg_replace("/AND/", "dan", $kondisiAtribut); 
                        mysqli_query($koneksi,"UPDATE iterasi_c45 SET nilai_att_max = '$kondisiAtribut' WHERE id = $rowNode[0]");
                        }
                      }
                    }
                    /*panggil dirinya sendiri*/
              
                  generateNode($row[0], $spasi + 1,$arrLv);
                  }
                  }
                  
                  $kondisi=true;
                  $sql=mysqli_query($koneksi,"SELECT * FROM iterasi_c45");
                  $node=1;
                  $attrSebelumnya="Total";
                  $idtabel=1;
                    while($data=mysqli_fetch_array($sql))
                    {
                      $atr=$data['atribut'];
                      
                      if($atr=="Total")
                      {?>
                        
                        <caption><b>Tabel Perhitungan Node <?php echo $data['node']." ".$jenisd ?></b></caption>
                        
                        <table id="example2" class="table table-bordered table-striped">
                        
                        <thead>
                        <tr>
                            <th>Node</th>
                            <th>Atribut</th>
                            <th>Nilai</th>
                            <th>Jumlah Kasus</th>
                            <th>Puas</th>
                            <th>Tidak Puas</th>
                            <th>Entropy</th>
                            <th>Gain</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><?php echo $data['node']?></td>
                            <td><?php if($data['node']<>'1'){
                                        echo $data['nilai_att_max'];
                                      } else {echo $data['atribut'];}?></td>
                            <td></td>
                            <td><?php echo $data['jml_kasus_total']?></td>
                            <td><?php echo $data['jml_puas']?></td>
                            <td><?php echo $data['jml_tdk_puas']?></td>
                            <td><?php echo $data['entropy']?></td>
                            <td></td>
                        </tr>
                        <?php
                      }else{
                        if ($atr<>$attrSebelumnya)
                        {
                          if($data['atribut']==$data['atribut_gain_ratio_max']){?>
                          
                            <tr bgcolor='yellow'>
                              <td></td>
                              <td><?php echo $data['atribut']?></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td><?php echo $data['inf_gain']?></td>
                            </tr>
                          <?php
                          }
                          else
                          {
                            ?>                   
                        <tr>
                          <td></td>
                          <td><?php echo $data['atribut']?></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td><?php echo $data['inf_gain']?></td>
                        </tr>
                          <?php
                          }
                          ?>
                        <tr>
                          <td></td>
                          <td></td>
                          <td><?php echo $data['nilai_atribut']?></td>
                          <td><?php echo $data['jml_kasus_total']?></td>
                          <td><?php echo $data['jml_puas']?></td>
                          <td><?php echo $data['jml_tdk_puas']?></td>
                          <td><?php echo $data['entropy']?></td>
                          <td></td>
                        </tr>
                        <?php
                        }else{?>
                          <tr>
                          <td></td>
                          <td></td>
                          <td><?php echo $data['nilai_atribut']?></td>
                          <td><?php echo $data['jml_kasus_total']?></td>
                          <td><?php echo $data['jml_puas']?></td>
                          <td><?php echo $data['jml_tdk_puas']?></td>
                          <td><?php echo $data['entropy']?></td>
                          <td></td>
                        </tr>
                        
                        <?php
                        }
                        
                      }
                       
                        
                      $attrSebelumnya=$data['atribut']; 
                          
                }
                

                    ?>
                    
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


 