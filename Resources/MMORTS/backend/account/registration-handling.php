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

	//ASSIGN VARIABLES FROM FORM
	$username = $_POST['username'];
	$password = $_POST['password'];
	$email = $_POST['email'];
	
	//ENCRYPT PASSWORD
	//$password = md5($password);
	
	$password = password_hash($password, PASSWORD_BCRYPT);
	
	//CHECK IF VALUES ARE OKAY
	
	//CHECK IF USER IS UNIQUE
	$sql = "SELECT username FROM users WHERE username = '$username'";
	if($result=mysqli_query($conn,$sql))
	{
		$rowcount = mysqli_num_rows($result);
	}
	
	if($rowcount >= 1)
	{
		echo "There is already an user with this username.";
	}
	else
	{
		//INSERT DATA INTO DATABASE
		$sql = "INSERT INTO users (username, password, email)
		VALUES ('$username', '$password', '$email')";
		
		//EXECUTE QUERY
		if($conn->query($sql) === TRUE)
		{
			echo "Account has been added successfully.";
			
			header("Location: ../../index.php?msg=registrationsuccess");
			die();
		}
		else
		{
			echo "Error: ".$sql."<br/>".$conn->error;
		}
	}
?>