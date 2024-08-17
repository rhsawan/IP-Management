<?php
	session_start();
	if(isset($_POST['doneSubmit'])){

    $key = $_POST['ketToEdit'];
    $q = "update tbl_task set status= 'Done' where docno = '$key'"; 
    $con = mysqli_connect('localhost', 'root', '', 'lvmgt');
    mysqli_query($con, $q); 
  }

  
  if(isset($_POST['submitComment'])){

    $key = $_POST['ketToEdit'];
    $comment = $_POST['comment'];

    $q1 = "insert into tbl_task_comment(compid, deptid, docno, comment, com_user) 
                                values (100, 10, '$key', '$comment', '".$_SESSION['email']."' )"; 
    

    $con = mysqli_connect('localhost', 'root', '', 'lvmgt');
    mysqli_query($con, $q1); 

  }
?>

<?php
  //session_start();
  require_once "dbc.php";

  //echo "<script>alert('".$_SESSION["email"]."');</script>";

  
  
  $query = "SELECT form.frmname, form.frmdetail FROM form LEFT JOIN formaccess ON form.compid = formaccess.compid
            and form.frmname = formaccess.frmname WHERE useremail = '".$_SESSION["email"]."'";
  $result = mysqli_query($con, $query);  

  $query_user = "SELECT company.compid, department.deptid, department.deptname, user.useremail, user.designation 
                 FROM company LEFT JOIN department ON company.compid = department.compid 
                 LEFT JOIN user ON department.compid = user.compid and department.deptid = user.deptid WHERE useremail = '".$_SESSION["email"]."'";
  $result_user = mysqli_query($con, $query_user);
  
  
   
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>ICT Cell - Jashore University of Science and Technology</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">

  <!-- Favicons -->
  <link href="img/favicon.png" rel="icon">
  <link href="img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Montserrat:300,400,500,700" rel="stylesheet">

  <!-- Bootstrap CSS File -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Libraries CSS Files -->
  <link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="lib/animate/animate.min.css" rel="stylesheet">
  <link href="lib/ionicons/css/ionicons.min.css" rel="stylesheet">
  <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">

  <!-- Main Stylesheet File -->
  <link href="css/style.css" rel="stylesheet">

  <!-- =======================================================
    Theme Name: NewBiz
    Theme URL: https://bootstrapmade.com/newbiz-bootstrap-business-template/
    Author: BootstrapMade.com
    License: https://bootstrapmade.com/license/
  ======================================================= -->
</head>

<body>

  <!--==========================
  Header
  ============================-->
  <header id="header" class="fixed-top">
    <div class="container">

      <div class="logo float-left">
        <!-- Uncomment below if you prefer to use an image logo -->
        <!-- <h1 class="text-light"><a href="#header"><span>NewBiz</span></a></h1> -->
        <a href="#intro" class="scrollto" size="20px"><img src="img/just_transparent_logo.png" alt="" class="img-fluid"> &nbsp; ICT Cell</a>
      </div>

      <nav class="main-nav float-right d-none d-lg-block">
        <ul>
          <li class="active"><a href="#intro">Home</a></li>
          <li><a href="#about">About Us</a></li>
          <li><a href="#services">Services</a></li>
          <li><a href="#portfolio">Portfolio</a></li>
          <li><a href="#team">Team</a></li>
          <li class="drop-down"><a href="">Drop Down</a>
            <ul>
              <li><a href="#">Drop Down 1</a></li>
              <li class="drop-down"><a href="#">Drop Down 2</a>
                <ul>
                  <li><a href="#">Deep Drop Down 1</a></li>
                  <li><a href="#">Deep Drop Down 2</a></li>
                  <li><a href="#">Deep Drop Down 3</a></li>
                  <li><a href="#">Deep Drop Down 4</a></li>
                  <li><a href="#">Deep Drop Down 5</a></li>
                </ul>
              </li>
              <li><a href="#">Drop Down 3</a></li>
              <li><a href="#">Drop Down 4</a></li>
              <li><a href="#">Drop Down 5</a></li>
            </ul>
          </li>
          <li><a href="#contact">Contact Us</a></li>
          <?php
            if(isset($_SESSION['access_token'])){
              echo "<li><a href='logout.php'>Logout</a></li>";
            }else{
              echo "<li> <a href='".$loginURL."' class='btn btn-primary'> Login With Google</a></li>";
            }
          ?>
          <!--
         <li><a href="<?php //echo $loginURL; ?>" class="btn btn-primary">Login With Google</a></li>
       -->
        </ul>
      </nav><!-- .main-nav -->
      
    </div><br /><br />
  </header><!-- #header -->

  <!--==========================
    Body Section
  ============================--> 
  
  <div class="container" style="margin-top: 100px; margin-bottom: 20px">
    <div class="row">
      <!--<div class="col-lg-3 col-md-4 footer-info">-->
      <div style="width: 15%; float: left;">
      <!--  <p>Left Side</p> -->
          
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <td align="center">Forms</td>
                </tr>
              </thead>
              <tbody>
            <?php    
              while($row = mysqli_fetch_array($result)){ 
            ?>
              <tr>
                 <td><a href="<?php echo $row["frmname"];?>.php"><?php echo $row["frmdetail"];?></td>
              </tr>
            <?php
            }
            ?>
              </tbody>
            </table>
         
    
    

      </div>
      <!-- Task Div Start -->
      <div style="width: 60%; float: left; padding-left: 2px; padding-right: 2px;">
        <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <td align="center">Assign Task</td>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <form name="myform" action="taskaction.php" method="post" enctype="multipart/form-data" style="padding: 20px">

                    <div class="form-group">
                      <label for="user"> Department: </label>
                      <input type="text" name="dept" id="name" class="form-control">
                    </div>

                    <div class="form-group">
                      <label for="user"> Assigned To: </label>
                      <input type="text" name="taskuser" id="number" class="form-control">
                    </div>

                    <div class="form-group">
                      <label for="user"> Task Title: </label>
                      <input type="text" name="tsktitle" id="email" class="form-control">
                    </div>
                    
                    

                    <input type="submit" name="submit" value="Submit" class="btn btn-success">
                  </form>

                  </td>
                </tr>
                
                  
              </tbody>
          </table>

      </div>
      <!--<div class="col-lg-9 col-md-8 footer-info" >-->
      <div style="width: 25%; float: left;">
        <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <td colspan="2" align="center">
                    <span style="width: 70%"><h1>Personal Informations</h1></span>
                    <span style="width: 30%"><img src="<?php echo $_SESSION['picture'];?>" style="height: 200px; width: 200px;">
                  </span></td>
                </tr>
              </thead>
              <tbody>
              <?php
                while ($row = mysqli_fetch_array($result_user)) {?>
                  
              
              <tr>
                 <td width="30%">Name:</td>
                 <td width="70%"><?php echo $_SESSION['givenName'].' '.$_SESSION['familyName'];?></td>
              </tr>
              <tr>
                 <td width="30%">Email:</td>
                 <td width="70%"><?php echo $_SESSION['email'];?></td>
              </tr>
               <tr>
                 <td width="30%">Department Name:</td>
                 <td width="70%"><?php echo $row['deptname'];?></td>
              </tr>
              <tr>
                 <td width="30%">Designation:</td>
                 <td width="70%"><?php echo $row['designation'];?></td>
              </tr>
              <tr>
                 <td width="30%">Gender:</td>
                 <td width="70%"><?php echo $_SESSION['gender'];?></td>
              </tr>
              <?php
                }
              ?>
              </tbody>
            </table>

            <br /><br />

            
            
      </div>
    </div>
  </div>


  
    </div>
  </div>
   
  <!--==========================
    Footer
  ============================-->
  <footer id="footer">
    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-4 col-md-6 footer-info">
            <h3>NewBiz</h3>
            <p>Cras fermentum odio eu feugiat lide par naso tierra. Justo eget nada terra videa magna derita valies darta donna mare fermentum iaculis eu non diam phasellus. Scelerisque felis imperdiet proin fermentum leo. Amet volutpat consequat mauris nunc congue.</p>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><a href="#">Home</a></li>
              <li><a href="#">About us</a></li>
              <li><a href="#">Services</a></li>
              <li><a href="#">Terms of service</a></li>
              <li><a href="#">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 footer-contact">
            <h4>Contact Us</h4>
            <p>
              A108 Adam Street <br>
              New York, NY 535022<br>
              United States <br>
              <strong>Phone:</strong> +1 5589 55488 55<br>
              <strong>Email:</strong> info@example.com<br>
            </p>

            <div class="social-links">
              <a href="#" class="twitter"><i class="fa fa-twitter"></i></a>
              <a href="#" class="facebook"><i class="fa fa-facebook"></i></a>
              <a href="#" class="instagram"><i class="fa fa-instagram"></i></a>
              <a href="#" class="google-plus"><i class="fa fa-google-plus"></i></a>
              <a href="#" class="linkedin"><i class="fa fa-linkedin"></i></a>
            </div>

          </div>

          <div class="col-lg-3 col-md-6 footer-newsletter">
            <h4>Our Newsletter</h4>
            <p>Tamen quem nulla quae legam multos aute sint culpa legam noster magna veniam enim veniam illum dolore legam minim quorum culpa amet magna export quem marada parida nodela caramase seza.</p>
            <form action="" method="post">
              <input type="email" name="email"><input type="submit"  value="Subscribe">
            </form>
          </div>

        </div>
      </div>
    </div>

    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong>NewBiz</strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!--
          All the links in the footer should remain intact.
          You can delete the links only if you purchased the pro version.
          Licensing information: https://bootstrapmade.com/license/
          Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=NewBiz
        -->
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer><!-- #footer -->

  <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
  <!-- Uncomment below i you want to use a preloader -->
  <!-- <div id="preloader"></div> -->

  <!-- JavaScript Libraries -->
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/jquery/jquery-migrate.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="lib/easing/easing.min.js"></script>
  <script src="lib/mobile-nav/mobile-nav.js"></script>
  <script src="lib/wow/wow.min.js"></script>
  <script src="lib/waypoints/waypoints.min.js"></script>
  <script src="lib/counterup/counterup.min.js"></script>
  <script src="lib/owlcarousel/owl.carousel.min.js"></script>
  <script src="lib/isotope/isotope.pkgd.min.js"></script>
  <script src="lib/lightbox/js/lightbox.min.js"></script>
  <!-- Contact Form JavaScript File -->
  <script src="contactform/contactform.js"></script>

  <!-- Template Main Javascript File -->
  <script src="js/main.js"></script>

</body>
</html>
