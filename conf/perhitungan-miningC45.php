<?php
//---------- KUMPULAN FUNGSI YANG AKAN DILAKUKAN DALAM PROSES MINING ----------
include ('config.php');


function miningC45($atribut, $nilai_atribut, $tabel)
{
    perhitunganC45($atribut, $nilai_atribut,$tabel);
    insertAtributPohonKeputusan($atribut, $nilai_atribut);
    getInfGainMax($atribut, $nilai_atribut,$tabel);
    replaceNull();
}

//#1# Hapus semua DB dan insert default atribut dan nilai atribut
function populateDb() 
{
    include ('config.php');
    mysqli_query($koneksi,"TRUNCATE mining_c45");
    mysqli_query($koneksi,"TRUNCATE iterasi_c45");
    mysqli_query($koneksi,"TRUNCATE pohon_keputusan_c45");
    populateAtribut();
}

function populateAtribut() 
{
    include ('config.php');
    mysqli_query($koneksi,"TRUNCATE atribut");
    mysqli_query($koneksi,"INSERT INTO `atribut` (`id`, `atribut`, `nilai_atribut`) VALUES
    ('1', 'total', 'total'),
    ('2', 'Pelayanan', 'Sangat Memuaskan'),
    ('3', 'Pelayanan', 'Memuaskan'),
    ('4', 'Pelayanan', 'Cukup Memuaskan'),
    ('5', 'Pelayanan', 'Tidak Memuaskan'),
    ('6', 'Biaya', 'Ada'),
    ('7', 'Biaya', 'Tidak Ada'),
	('8', 'Kemampuan', 'Sangat Mampu'),
	('9', 'Kemampuan', 'Mampu'),
	('10', 'Kemampuan', 'Kurang Mampu'),
	('11', 'Kemampuan', 'Tidak Mampu'),
	('12', 'Sikap', 'Sangat Baik'),
	('13', 'Sikap', 'Baik'),
	('14', 'Sikap', 'Cukup Baik'),
    ('15', 'Sikap', 'Tidak Baik')
    ");
}

// ================ FUNGSI PERHITUNGAN C45 =================
function perhitunganC45($atribut, $nilai_atribut,$tabel) 
{
    include ('config.php');
    if (empty($atribut) AND empty($nilai_atribut)) {
//#2# Jika atribut yg diinputkan kosong, maka lakukan perhitungan awal
        $kondisiAtribut = ""; // set kondisi atribut kosong
    } else if (!empty($atribut) AND !empty($nilai_atribut)) { 
        // jika atribut tdk kosong, maka select kondisi atribut dari DB
        $sqlKondisiAtribut = mysqli_query($koneksi,"SELECT kondisi_atribut FROM pohon_keputusan_c45 WHERE atribut = '$atribut' AND nilai_atribut = '$nilai_atribut' order by id DESC LIMIT 1");
        $rowKondisiAtribut = mysqli_fetch_array($sqlKondisiAtribut);
        $kondisiAtribut = str_replace("~", "'", $rowKondisiAtribut['kondisi_atribut']); // replace string ~ menjadi '
    } 
    
    // ambil seluruh atribut
    $sqlAtribut = mysqli_query($koneksi,"SELECT distinct atribut FROM atribut");
    while($rowGetAtribut = mysqli_fetch_array($sqlAtribut)) {
        $getAtribut = $rowGetAtribut['atribut'];
        if ($getAtribut === 'total') { 
//#3# Jika atribut = total, maka hitung jumlah kasus total, jumlah kasus Puas dan jumlah kasus tdk Puas
            // hitung jumlah kasus total
            $sqlJumlahKasusTotal = mysqli_query($koneksi,"SELECT COUNT(*) as jumlah_total FROM ".$tabel." WHERE hasil is not null $kondisiAtribut");
            $rowJumlahKasusTotal = mysqli_fetch_array($sqlJumlahKasusTotal);
            $getJumlahKasusTotal = $rowJumlahKasusTotal['jumlah_total'];

            // hitung jumlah kasus Puas
            $sqlJumlahKasusPuas = mysqli_query($koneksi,"SELECT COUNT(*) as jumlah_Puas FROM ".$tabel." WHERE hasil = 'Puas' AND hasil is not null $kondisiAtribut");
            $rowJumlahKasusPuas = mysqli_fetch_array($sqlJumlahKasusPuas);
            $getJumlahKasusPuas = $rowJumlahKasusPuas['jumlah_Puas'];

            // hitung jumlah kasus tdk Puas
            $sqlJumlahKasusTidakPuas = mysqli_query($koneksi,"SELECT COUNT(*) as jumlah_tidak_Puas FROM ".$tabel." WHERE hasil = 'Tidak Puas' AND hasil is not null $kondisiAtribut");
            $rowJumlahKasusTidakPuas = mysqli_fetch_array($sqlJumlahKasusTidakPuas);
            $getJumlahKasusTidakPuas = $rowJumlahKasusTidakPuas['jumlah_tidak_Puas'];

//#4# Insert jumlah kasus total, jumlah kasus Puas dan jumlah kasus tdk Puas ke DB
            // insert ke database mining_c45
            mysqli_query($koneksi,"INSERT INTO mining_c45 VALUES ('', 'Total', 'Total', '$getJumlahKasusTotal', '$getJumlahKasusPuas', '$getJumlahKasusTidakPuas', '', '', '', '', '', '')");

        } else {
//#5# Jika atribut != total (atribut lainnya), maka hitung jumlah kasus total, jumlah kasus Puas dan jumlah kasus tdk Puas masing2 atribut
            // ambil nilai atribut
            $sqlNilaiAtribut = mysqli_query($koneksi,"SELECT nilai_atribut FROM atribut WHERE atribut = '$getAtribut' ORDER BY id");
            while($rowNilaiAtribut = mysqli_fetch_array($sqlNilaiAtribut)) {
                $getNilaiAtribut = $rowNilaiAtribut['nilai_atribut'];

                // set kondisi dimana nilai_atribut = berdasakan masing2 atribut dan status data = data training
                $kondisi = "$getAtribut = '$getNilaiAtribut' AND hasil is not null $kondisiAtribut";

                // hitung jumlah kasus per atribut
                $sqlJumlahKasusTotalAtribut = mysqli_query($koneksi,"SELECT COUNT(*) as jumlah_total FROM ".$tabel." WHERE $kondisi");
                $rowJumlahKasusTotalAtribut = mysqli_fetch_array($sqlJumlahKasusTotalAtribut);
                $getJumlahKasusTotalAtribut = $rowJumlahKasusTotalAtribut['jumlah_total'];

                // hitung jumlah kasus Puas
                $sqlJumlahKasusPuasAtribut = mysqli_query($koneksi,"SELECT COUNT(*) as jumlah_Puas FROM ".$tabel." WHERE $kondisi AND hasil = 'Puas'");
                $rowJumlahKasusPuasAtribut = mysqli_fetch_array($sqlJumlahKasusPuasAtribut);
                $getJumlahKasusPuasAtribut = $rowJumlahKasusPuasAtribut['jumlah_Puas'];

                // hitung jumlah kasus TDK Puas
                $sqlJumlahKasusTidakPuasAtribut = mysqli_query($koneksi,"SELECT COUNT(*) as jumlah_tidak_Puas FROM ".$tabel." WHERE $kondisi AND hasil = 'Tidak Puas'");
                $rowJumlahKasusTidakPuasAtribut = mysqli_fetch_array($sqlJumlahKasusTidakPuasAtribut);
                $getJumlahKasusTidakPuasAtribut = $rowJumlahKasusTidakPuasAtribut['jumlah_tidak_Puas'];

//#6# Insert jumlah kasus total, jumlah kasus Puas dan jumlah kasus tdk Puas masing2 atribut ke DB
                // insert ke database mining_c45
                mysqli_query($koneksi,"INSERT INTO mining_c45 VALUES ('', '$getAtribut', '$getNilaiAtribut', '$getJumlahKasusTotalAtribut', '$getJumlahKasusPuasAtribut', '$getJumlahKasusTidakPuasAtribut', '', '', '', '', '', '')");
                
//#7# Lakukan perhitungan entropy
                // perhitungan entropy
                $sqlEntropy = mysqli_query($koneksi,"SELECT id, jml_kasus_total, jml_puas, jml_tdk_puas FROM mining_c45");
                while($rowEntropy = mysqli_fetch_array($sqlEntropy)) {
                    $getJumlahKasusTotalEntropy = $rowEntropy['jml_kasus_total'];
                    $getJumlahKasusPuasEntropy = $rowEntropy['jml_puas'];
                    $getJumlahKasusTidakPuasEntropy = $rowEntropy['jml_tdk_puas'];
                    $idEntropy = $rowEntropy['id'];

                    // jika jml kasus = 0 maka entropy = 0
                    if ($getJumlahKasusTotalEntropy == 0 OR $getJumlahKasusPuasEntropy == 0 OR $getJumlahKasusTidakPuasEntropy == 0) {
                        $getEntropy = 0;
                    // jika jml kasus Puas = jml kasus tdk Puas, maka entropy = 1
                    } else if ($getJumlahKasusPuasEntropy == $getJumlahKasusTidakPuasEntropy) {
                        $getEntropy = 1;
                    } else { // jika jml kasus != 0, maka hitung rumus entropy:
                        $perbandingan_Puas = $getJumlahKasusPuasEntropy / $getJumlahKasusTotalEntropy;
                        $perbandingan_tidak_Puas = $getJumlahKasusTidakPuasEntropy / $getJumlahKasusTotalEntropy;

                        $rumusEntropy = (-($perbandingan_Puas) * log($perbandingan_Puas,2)) + (-($perbandingan_tidak_Puas) * log($perbandingan_tidak_Puas,2));
                        $getEntropy = round($rumusEntropy,4); // 4 angka di belakang koma
                    }

//#8# Update nilai entropy
                    // update nilai entropy
                    mysqli_query($koneksi,"UPDATE mining_c45 SET entropy = $getEntropy WHERE id = $idEntropy");
                }
                
//#9# Lakukan perhitungan information gain
                // perhitungan information gain
                // ambil nilai entropy dari total (jumlah kasus total)
                $sqlJumlahKasusTotalInfGain = mysqli_query($koneksi,"SELECT jml_kasus_total, entropy FROM mining_c45 WHERE atribut = 'Total'");
                $rowJumlahKasusTotalInfGain = mysqli_fetch_array($sqlJumlahKasusTotalInfGain);
                $getJumlahKasusTotalInfGain = $rowJumlahKasusTotalInfGain['jml_kasus_total'];
                // rumus information gain
                $getInfGain = (-(($getJumlahKasusTotalEntropy / $getJumlahKasusTotalInfGain) * ($getEntropy))); 

//#10# Update information gain tiap nilai atribut (temporary)
                // update inf_gain_temp (utk mencari nilai masing2 atribut)
                mysqli_query($koneksi,"UPDATE mining_c45 SET inf_gain_temp = $getInfGain WHERE id = $idEntropy");
                $getEntropy = $rowJumlahKasusTotalInfGain['entropy'];

                // jumlahkan masing2 inf_gain_temp atribut 
                $sqlAtributInfGain = mysqli_query($koneksi,"SELECT SUM(inf_gain_temp) as inf_gain FROM mining_c45 WHERE atribut = '$getAtribut'");
                while ($rowAtributInfGain = mysqli_fetch_array($sqlAtributInfGain)) {
                    $getAtributInfGain = $rowAtributInfGain['inf_gain'];

                    // hitung inf gain
                    $getInfGainFix = round(($getEntropy + $getAtributInfGain),4);

//#11# Looping perhitungan information gain, sehingga mendapatkan information gain tiap atribut. Update information gain
                    // update inf_gain (fix)
                    mysqli_query($koneksi,"UPDATE mining_c45 SET inf_gain = $getInfGainFix WHERE atribut = '$getAtribut'");
                } 
                
//#12# Lakukan perhitungan split info
                // rumus split info
                $getSplitInfo = (($getJumlahKasusTotalEntropy / $getJumlahKasusTotalInfGain) * (log(($getJumlahKasusTotalEntropy / $getJumlahKasusTotalInfGain),2)));
                
//#13# Update split info tiap nilai atribut (temporary)
                // update split_info_temp (utk mencari nilai masing2 atribut)
                mysqli_query($koneksi,"UPDATE mining_c45 SET split_info_temp = $getSplitInfo WHERE id = $idEntropy");
                
                // jumlahkan masing2 split_info_temp dari tiap atribut 
                $sqlAtributSplitInfo = mysqli_query($koneksi,"SELECT SUM(split_info_temp) as split_info FROM mining_c45 WHERE atribut = '$getAtribut'");
                while ($rowAtributSplitInfo = mysqli_fetch_array($sqlAtributSplitInfo)){
                    $getAtributSplitInfo = $rowAtributSplitInfo['split_info'];

                    // split info fix (4 angka di belakang koma)
                    $getSplitInfoFix = -(round($getAtributSplitInfo,4));

//#14# Looping perhitungan split info, sehingga mendapatkan information gain tiap atribut. Update information gain
                    // update split info (fix)
                    mysqli_query($koneksi,"UPDATE mining_c45 SET split_info = $getSplitInfoFix WHERE atribut = '$getAtribut'");
                }
            }
            
//#15# Lakukan perhitungan gain ratio
            $sqlGainRatio = mysqli_query($koneksi,"SELECT id, inf_gain, split_info FROM mining_c45");
            while($rowGainRatio = mysqli_fetch_array($sqlGainRatio)) {
                $idGainRatio = $rowGainRatio['id'];
                // jika nilai inf gain == 0 dan split info == 0, maka gain ratio = 0
                if ($rowGainRatio['inf_gain'] == 0 AND $rowGainRatio['split_info'] == 0){
                    $getGainRatio = 0;
                } else {
                    // rumus gain ratio
                    $getGainRatio = round(($rowGainRatio['inf_gain'] / $rowGainRatio['split_info']),4);
                }
                
//#16# Update gain ratio dari setiap atribut
                mysqli_query($koneksi,"UPDATE mining_c45 SET gain_ratio = $getGainRatio WHERE id = '$idGainRatio'");
            }
        }
    }
}

//#17# Insert atribut dgn information gain max ke DB pohon keputusan
function insertAtributPohonKeputusan($atribut, $nilai_atribut)
{
    include ('config.php');
    // ambil nilai inf gain tertinggi dimana hanya 1 atribut saja yg dipilih
    $sqlInfGainMaxTemp = mysqli_query($koneksi,"SELECT distinct atribut, inf_gain FROM mining_c45 WHERE inf_gain in (SELECT max(inf_gain) FROM `mining_c45`) LIMIT 1");
    $rowInfGainMaxTemp = mysqli_fetch_array($sqlInfGainMaxTemp);
    // hanya ambil atribut dimana jumlah kasus totalnya tidak kosong
    if ($rowInfGainMaxTemp['inf_gain'] > 0) {
        // ambil nilai atribut yang memiliki nilai inf gain max
        $sqlInfGainMax = mysqli_query($koneksi,"SELECT * FROM mining_c45 WHERE atribut = '$rowInfGainMaxTemp[atribut]'");
        while($rowInfGainMax = mysqli_fetch_array($sqlInfGainMax)) {
            if ($rowInfGainMax['jml_puas'] == 0 AND $rowInfGainMax['jml_tdk_puas'] == 0) {
                $keputusan = 'Kosong'; // jika jml_puas = 0 dan jml_tdk_puas = 0, maka keputusan Null
            } else if ($rowInfGainMax['jml_puas'] !== 0 AND $rowInfGainMax['jml_tdk_puas'] == 0) {
                $keputusan = 'Puas'; // jika jml_puas != 0 dan jml_tdk_puas = 0, maka keputusan Puas
            } else if ($rowInfGainMax['jml_puas'] == 0 AND $rowInfGainMax['jml_tdk_puas'] !== 0) {
                $keputusan = 'Tidak Puas'; // jika jml_puas = 0 dan jml_tdk_puas != 0, maka keputusan Tidak Puas
            } else {
                $keputusan = '?'; // jika jml_puas != 0 dan jml_tdk_puas != 0, maka keputusan ?
            }
            
            if (empty($atribut) AND empty($nilai_atribut)) {
//#18# Jika atribut yang diinput kosong (atribut awal) maka insert ke pohon keputusan id_parent = 0
                // set kondisi atribut = AND atribut = nilai atribut
                $kondisiAtribut = "AND $rowInfGainMax[atribut] = ~$rowInfGainMax[nilai_atribut]~";
                // insert ke tabel pohon keputusan
                mysqli_query($koneksi,"INSERT INTO pohon_keputusan_c45 VALUES ('', '$rowInfGainMax[atribut]', '$rowInfGainMax[nilai_atribut]', 0, '$rowInfGainMax[jml_puas]', '$rowInfGainMax[jml_tdk_puas]', '$keputusan', 'Belum', '$kondisiAtribut', 'Belum')");
            }

//#19# Jika atribut yang diinput tidak kosong maka insert ke pohon keputusan dimana id_parent diambil dari tabel pohon keputusan sebelumnya (where atribut = atribut yang diinput)
            else if (!empty($atribut) AND !empty($nilai_atribut)) {
                $sqlIdParent = mysqli_query($koneksi,"SELECT id, atribut, nilai_atribut, jml_puas, jml_tdk_puas FROM pohon_keputusan_c45 WHERE atribut = '$atribut' AND nilai_atribut = '$nilai_atribut' order by id DESC LIMIT 1");
                $perhitunganPessimisticChildIncrement=0;
                while($rowIdParent = mysqli_fetch_array($sqlIdParent)) {
                    // insert ke tabel pohon keputusan
                    mysqli_query($koneksi,"INSERT INTO pohon_keputusan_c45 VALUES ('', '$rowInfGainMax[atribut]', '$rowInfGainMax[nilai_atribut]', $rowIdParent[id], '$rowInfGainMax[jml_puas]', '$rowInfGainMax[jml_tdk_puas]', '$keputusan', 'Belum', '', 'Belum')");
                    
                    //#PRE PRUNING (dokumentasi -> http://id3-c45.xp3.biz/dokumentasi/Decision-Tree.10.11.ppt)#
                    // hitung Pessimistic error rate parent dan child 
                    $perhitunganParentPrePruning = loopingPerhitunganPrePruning($rowIdParent['jml_puas'], $rowIdParent['jml_tdk_puas']);
                    $perhitunganChildPrePruning = loopingPerhitunganPrePruning($rowInfGainMax['jml_puas'], $rowInfGainMax['jml_tdk_puas']);
                    
                    // hitung average Pessimistic error rate child 
                    $perhitunganPessimisticChild = (($rowInfGainMax['jml_puas'] + $rowInfGainMax['jml_tdk_puas']) / ($rowIdParent['jml_puas'] + $rowIdParent['jml_tdk_puas'])) * $perhitunganChildPrePruning;
                    // Increment average Pessimistic error rate child
                    $perhitunganPessimisticChildIncrement += $perhitunganPessimisticChild;
                    $perhitunganPessimisticChildIncrement = round($perhitunganPessimisticChildIncrement, 4);
                    
                    // jika error rate pada child lebih besar dari error rate parent
                    if ($perhitunganPessimisticChildIncrement > $perhitunganParentPrePruning) {
                        // hapus child (child tidak diinginkan)
                        mysqli_query($koneksi,"DELETE FROM pohon_keputusan_c45 WHERE id_parent = $rowIdParent[id]");
                        
                        // jika jml kasus Puas lbh besar, maka keputusan == Puas
                        if ($rowIdParent['jml_puas'] > $rowIdParent['jml_tdk_puas']) {
                            $keputusanPrePruning = 'Puas';
                        // jika jml tdk kasus Puas lbh besar, maka keputusan == tdk Puas
                        } else if ($rowIdParent['jml_puas'] < $rowIdParent['jml_tdk_puas']) {
                            $keputusanPrePruning = 'Tidak Puas';
                        }
                        // update keputusan parent
                        mysqli_query($koneksi,"UPDATE pohon_keputusan_c45 SET keputusan = '$keputusanPrePruning' where id = $rowIdParent[id]");
                    }
                }
            }
        }
    }
    loopingKondisiAtribut();
}

//#20# Lakukan looping kondisi atribut untuk diproses pada fungsi perhitunganC45()
function loopingKondisiAtribut() 
{
    include ('config.php');
    // ambil semua id dan kondisi atribut
    $sqlLoopingKondisi = mysqli_query($koneksi,"SELECT id, kondisi_atribut FROM pohon_keputusan_c45");
    while($rowLoopingKondisi = mysqli_fetch_array($sqlLoopingKondisi)) {
        // select semua data dimana id_parent = id awal
        $sqlUpdateKondisi = mysqli_query($koneksi,"SELECT * FROM pohon_keputusan_c45 WHERE id_parent = $rowLoopingKondisi[id] AND looping_kondisi = 'Belum'");
        while($rowUpdateKondisi = mysqli_fetch_array($sqlUpdateKondisi)) {
            // set kondisi: kondisi sebelumnya yg diselect berdasarkan id_parent ditambah 'AND atribut = nilai atribut'
            $kondisiAtribut = "$rowLoopingKondisi[kondisi_atribut] AND $rowUpdateKondisi[atribut] = ~$rowUpdateKondisi[nilai_atribut]~";
            // update kondisi atribut
            mysqli_query($koneksi,"UPDATE pohon_keputusan_c45 SET kondisi_atribut = '$kondisiAtribut', looping_kondisi = 'Sudah' WHERE id = $rowUpdateKondisi[id]");
        }
    }
    insertIterasi();
}

//#21# Insert iterasi nilai perhitungan ke DB
function insertIterasi()
{
    include ('config.php');
    $sqlInfGainMaxIterasi = mysqli_query($koneksi,"SELECT distinct atribut, nilai_atribut, inf_gain FROM mining_c45 WHERE inf_gain in (SELECT max(inf_gain) FROM `mining_c45`) LIMIT 1");
    $rowInfGainMaxIterasi = mysqli_fetch_array($sqlInfGainMaxIterasi);
    // hanya ambil atribut dimana jumlah kasus totalnya tidak kosong
    if ($rowInfGainMaxIterasi['inf_gain'] > 0) {
        $kondisiAtribut = "$rowInfGainMaxIterasi[atribut]";
        $iterasiKe = 1;
        $sqlInsertIterasiC45 = mysqli_query($koneksi,"SELECT * FROM mining_c45");
        while($rowInsertIterasiC45 = mysqli_fetch_array($sqlInsertIterasiC45)) {
            // insert ke tabel iterasi
            mysqli_query($koneksi,"INSERT INTO iterasi_c45 VALUES ('', $iterasiKe, '','$kondisiAtribut', '$rowInsertIterasiC45[nilai_atribut]', '$rowInsertIterasiC45[atribut]', '$rowInsertIterasiC45[nilai_atribut]', '$rowInsertIterasiC45[jml_kasus_total]', '$rowInsertIterasiC45[jml_puas]', '$rowInsertIterasiC45[jml_tdk_puas]', '$rowInsertIterasiC45[entropy]', '$rowInsertIterasiC45[inf_gain]', '$rowInsertIterasiC45[split_info]', '$rowInsertIterasiC45[gain_ratio]')");
            $iterasiKe++;
        }
        
    }
}

//#22# Ambil information gain max untuk diproses pada fungsi loopingMiningC45()
function getInfGainMax($atribut, $nilai_atribut,$tabel)
{
    include ('config.php');
    // select inf gain max
    $sqlInfGainMaxAtribut = mysqli_query($koneksi,"SELECT distinct atribut FROM mining_c45 WHERE inf_gain in (SELECT max(inf_gain) FROM `mining_c45`) LIMIT 1");
    while($rowInfGainMaxAtribut = mysqli_fetch_array($sqlInfGainMaxAtribut)) {
        $inf_gain_max_atribut = "$rowInfGainMaxAtribut[atribut]";
        if (empty($atribut) AND empty($nilai_atribut)) {
            // jika atribut kosong, proses atribut dgn inf gain max pada fungsi loopingMiningC45()
            loopingMiningC45($inf_gain_max_atribut,$tabel);
        } else if (!empty($atribut) AND !empty($nilai_atribut)) {
            // jika atribut tdk kosong, maka update diproses = sudah pada tabel pohon_keputusan_c45
            mysqli_query($koneksi,"UPDATE pohon_keputusan_c45 SET diproses = 'Sudah' WHERE nilai_atribut = '$nilai_atribut'");
            // proses atribut dgn inf gain max pada fungsi loopingMiningC45()
            loopingMiningC45($inf_gain_max_atribut,$tabel);
        }
    }
}

//#23# Looping proses mining dimana atribut dgn information gain max yang akan diproses pada fungsi miningC45()
function loopingMiningC45($inf_gain_max_atribut,$tabel) 
{
    include ('config.php');
    $sqlBelumAdaKeputusanLagi = mysqli_query($koneksi,"SELECT * FROM pohon_keputusan_c45 WHERE keputusan = '?' and diproses = 'Belum' AND atribut = '$inf_gain_max_atribut'");
    while($rowBelumAdaKeputusanLagi = mysqli_fetch_array($sqlBelumAdaKeputusanLagi)) {
        if ($rowBelumAdaKeputusanLagi['id_parent'] == 0) {
            populateAtribut();
        }
        $atribut = "$rowBelumAdaKeputusanLagi[atribut]";
        $nilai_atribut = "$rowBelumAdaKeputusanLagi[nilai_atribut]";
        $kondisiAtribut = "AND $atribut = \'$nilai_atribut\'";
        mysqli_query($koneksi,"TRUNCATE mining_c45");
        mysqli_query($koneksi,"DELETE FROM atribut WHERE atribut = '$inf_gain_max_atribut'");
        miningC45($atribut, $nilai_atribut,$tabel);
        populateAtribut();
    }
}

// rumus menghitung Pessimistic error rate
function perhitunganPrePruning($r, $z, $n)
{
    if ($n==0){
        $rumus=0;
    }else{
        $rumus = ($r + (($z * $z) / (2 * $n)) + ($z * (sqrt(($r / $n) - (($r * $r) / $n) + (($z * $z) / (4 * ($n * $n))))))) / (1 + (($z * $z) / $n));
        $rumus = round($rumus, 4);
    }
       
    return $rumus;
}

// looping perhitungan Pessimistic error rate
function loopingPerhitunganPrePruning($positif, $negatif)
{
    $z = 1.645; // z = batas kepercayaan (confidence treshold)
    $n = $positif + $negatif; // n = total jml kasus
    $n = round($n, 4);
    // r = perbandingan child thd parent
    if ($positif < $negatif) {
        $r = $positif / ($n);
        $r = round($r, 4);
        return perhitunganPrePruning($r, $z, $n);
    } elseif ($positif > $negatif) {
        $r = $negatif / ($n);
        $r = round($r, 4);
        return perhitunganPrePruning($r, $z, $n);
    } elseif ($positif == $negatif) {
        if ($n==0){
            $r=0;
        }else{
            $r = $negatif / ($n);
        }
        
        $r = round($r, 4);
        return perhitunganPrePruning($r, $z, $n);
    }
}

// replace keputusan jika ada keputusan yg Null
function replaceNull()
{
    include ('config.php');
    $sqlReplaceNull = mysqli_query($koneksi,"SELECT id, id_parent FROM pohon_keputusan_c45 WHERE keputusan = 'Null'");
    while($rowReplaceNull = mysqli_fetch_array($sqlReplaceNull)) {
        $sqlReplaceNullIdParent = mysqli_query($koneksi,"SELECT jml_puas, jml_tdk_puas, keputusan FROM pohon_keputusan_c45 WHERE id = $rowReplaceNull[id_parent]");
        $rowReplaceNullIdParent = mysqli_fetch_array($sqlReplaceNullIdParent);
        if ($rowReplaceNullIdParent['jml_puas'] > $rowReplaceNullIdParent['jml_tdk_puas']) {
            $keputusanNull = 'Puas'; // jika jml_puas != 0 dan jml_tdk_puas = 0, maka keputusan Puas
        } else if ($rowReplaceNullIdParent['jml_puas'] < $rowReplaceNullIdParent['jml_tdk_puas']) {
            $keputusanNull = 'Tidak Puas'; // jika jml_puas = 0 dan jml_tdk_puas != 0, maka keputusan Tidak Puas
        }
        mysqli_query($koneksi,"UPDATE pohon_keputusan_c45 SET keputusan = '$keputusanNull' WHERE id = $rowReplaceNull[id]");
    }
}
//echo "<script>window.alert('Proses Mining Sukses !!!');
				//window.location='index2.php'</script>";

?>


				
	