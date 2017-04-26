<?php
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
	else
	{
		//IF CONNECTION IS GOOD, GET DATA FROM DATABASE
		$query = "SELECT name, seperator, description, maintenance, logo FROM configuration";
		$result = mysqli_query($conn, $query);
		$row = mysqli_fetch_assoc($result);
		
		//GENERAL SETTINGS
		$title 			= $row['name'];
		$seperator 		= $row['seperator'];
		$description 	= $row['description'];
		$logo 			= $row['logo'];
		
		//TECHNICAL SETTINGS
		$maintenance 	= $row['maintenance'];
	}
?>