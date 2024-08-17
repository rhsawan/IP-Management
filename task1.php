<?php
	session_start();
?>

<!DOCTYPE html>
<html>
<head>
	<title>Task Assign</title>
</head>
<body>
	<form action="taskaction.php" method="post">
		<input type="text" name="company" placeholder="Company">
		<input type="text" name="dept" placeholder="Department">
		<input type="text" name="tsktitle" placeholder="Task Title">
		<input type="text" name="taskuser" placeholder="Task To">
		<input type="submit" name="submit" value="Submit">
	</form>
</body>
</html>