<?php 
	$query_name = "select fn_username('rh.sawan@just.edu.bd') as taskassign from tbl_task where docno = 'TSK000007'";
	echo $query_name;  
	$con = mysqli_connect('localhost', 'root', '', 'lvmgt'); 
	$result_name=mysqli_query($con, $query_name); 
	while ($row = mysqli_fetch_array($result_name)) {
		echo $row['taskassign'];
	}
?>