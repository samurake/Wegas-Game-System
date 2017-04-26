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
	
	$sql = "SELECT * FROM resources";
	$result = $conn->query($sql);
	
	$count = 0;
	while($row = $result->fetch_assoc())
	{
		$cityId = $row['city_id'];
		$sql = "SELECT planks_production, ore_production, clay_production, food_production FROM production WHERE city_id = '$cityId'";
		$result = mysqli_query($conn, $sql);
		$row = mysqli_fetch_assoc($result);
		
		$planks_production = $row['planks_production'];
		$ore_production = $row['ore_production'];
		$clay_production = $row['clay_production'];
		$food_production = $row['food_production'];
		
		$sql = "UPDATE resources SET planks = planks + '$planks_production' WHERE city_id = '$cityId'";
		if (mysqli_query($conn, $sql)) 
		{
			echo "Cities' planks have been updated!<br/>";
		}
		
		$sql = "UPDATE resources SET ore = ore + '$ore_production' WHERE city_id = '$cityId'";
		if (mysqli_query($conn, $sql)) 
		{
			echo "Cities' ore have been updated!<br/>";
		}
		
		$sql = "UPDATE resources SET clay = clay + '$clay_production' WHERE city_id = '$cityId'";
		if (mysqli_query($conn, $sql)) 
		{
			echo "Cities' clay have been updated!<br/>";
		}
		
		$sql = "UPDATE resources SET food = food + '$food_production' WHERE city_id = '$cityId'";
		if (mysqli_query($conn, $sql)) 
		{
			echo "Cities' food have been updated!<br/>";
		}
	}
?>