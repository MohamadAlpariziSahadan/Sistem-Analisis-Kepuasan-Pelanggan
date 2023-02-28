<!DOCTYPE html>
<html lang="en">
<?php include ('header3.php');?>
<?php include ('../conf/config.php');?>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Preloader -->
    <?php include ('preloader.php');?>
    
    <?php include ('navbar.php');?>

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <?php include ('logo.php');?>

    <!-- Sidebar -->
    <?php include ('sidebar.php');?>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <?php include ('content_header3.php');?>
    <!-- /.content-header -->

    <!-- Main content -->
    <?php include ('tampil_pohon_keputusan.php');?>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
    <?php include ('footer.php');?>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

</body>
</html>
