<?php
	session_start();
	//DATABASE CONNECTION
	$dbserver 		= "localhost";
	$dbusername 	= "root";
	$dbpassword 	= "";
	$db 			= "mmorts";
	
	//CREATE CONNECTION
	$conn = new mysqli($dbserver, $dbusername, $dbpassword, $db);
	
	//CHECK CONNECTION
	if ($conn->connect_error)
	{
		die("Connection failed: ".$conn->connect_error);
	}
	
	//ASSIGN VARIABLES FROM FORM
	$username = $_POST['username'];
	$password = $_POST['password'];
	
	//ENCRYPT PASSWORD
	//$password = md5($password);
	
	$query = "SELECT password FROM users WHERE username = '$username'";
	$result = mysqli_query($conn, $query);
	$row = mysqli_fetch_assoc($result);
	
	//USERDATA
	$dbPassword = $row['password'];
	
	if (password_verify($password, $dbPassword))
	{
		echo "The details are correct.";
		$_SESSION['loggedin'] = $username;
		
		header("Location: ../../index.php?msg=loginsuccess");
		die();
	}
	else
	{
		echo "Passwords do not match!";
	}
?>