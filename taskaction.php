<?php
	session_start();

	$con = mysqli_connect('localhost', 'root');
	mysqli_select_db($con, 'lvmgt');

	if(isset($_POST['submit'])){


		//$company = $_POST['company'];
		$dept = $_POST['dept'];
		$tsktitle = $_POST['tsktitle'];
		$taskuser = $_POST['taskuser'];

		//echo '$company'.'$dept'.'$tsktitle'.'$taskuser'; 


		$q1 = "INSERT INTO `tbl_task` (`compid`, `deptid`, `tasktitle`, `taskuser`, `taskassign`) 
			   VALUES (100, $dept, '$tsktitle', '$taskuser', '".$_SESSION['email']."')";

		$query = mysqli_query($con, $q1);

						echo "<script>
						alert('Your Task Creation is successfull.');
						window.location.href='task.php';
						</script>";

	}
?>