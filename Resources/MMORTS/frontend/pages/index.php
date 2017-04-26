<?php
	global $title;
	global $seperator;
	global $description;
	global $logo;
?>
<html>
	<head>
		<title><?php echo $title.$seperator.$description; ?></title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link href="frontend/design/css/bootstrap.min.css" rel="stylesheet">
	    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
	    <link href="frontend/design/css/stylesheet.css" rel="stylesheet" type="text/css">
	</head>
	
	<body>
		<div class="wrapper">
			<?php require_once("frontend/templates/header.php"); ?>
			<div class="layer">
				<div class="content">
					<h2>Index</h2>
					<p>This is the index page.</p>
					<?php
						if(isset($_GET['msg']))
						{
							$msg = $_GET['msg'];
							
							if($msg == "loginsuccess")
							{
								$msg = "You succesfully logged in, boss!";
							}
							
							if($msg == "registrationsuccess")
							{
								$msg = "You succesfully registrated with the NSA, boss!";
							}
							
							if($msg == "logoutsuccess")
							{
								$msg = "You succesfully logged out, boss!";
							}
							
							?>
							<div class="alert alert-success" role="alert"><?php echo $msg; ?></div>
							<?php
						}
						if(isset($_SESSION['loggedin']))
						{
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
							
							$username = $_SESSION['loggedin'];
							
							$query = "SELECT id FROM users WHERE username = '$username'";
							$result = mysqli_query($conn, $query);
							$row = mysqli_fetch_assoc($result);
							
							//USERDATA
							$userId = $row['id'];
							
							//GET CITY DATA							
							$query = "SELECT id, name, resources_id FROM cities WHERE user_id = '$userId'";
							$result = mysqli_query($conn, $query);
							$row = mysqli_fetch_assoc($result);
							
							//CITYDATA
							$cityId = $row['id'];
							$cityName = $row['name'];
							$cityResourcesId = $row['resources_id'];
							
							//GET CITY RESOURCES						
							$query = "SELECT planks, ore, clay, food FROM resources WHERE id = '$cityResourcesId'";
							$result = mysqli_query($conn, $query);
							$row = mysqli_fetch_assoc($result);
							
							$planks = $row['planks'];
							$ore = $row['ore'];
							$clay = $row['clay'];
							$food = $row['food'];
							
							//GET CITY RESOURCES PRODUCTION						
							$query = "SELECT planks_production, ore_production, clay_production, food_production FROM production WHERE city_id = '$cityId'";
							$result = mysqli_query($conn, $query);
							$row = mysqli_fetch_assoc($result);
							
							$planks_production = $row['planks_production'];
							$ore_production = $row['ore_production'];
							$clay_production = $row['clay_production'];
							$food_production = $row['food_production'];
							
							?>
								<center><h3><?php echo $cityName; ?></h3></center>
								<div class="village-wrapper">
									<div class="resources">
										<h4>Resources</h4>
										<?php
											echo "Planks: ".$planks."<br/>";
											echo "Ore: ".$ore."<br/>";
											echo "Clay: ".$clay."<br/>";
											echo "Food: ".$food."<br/>";
										?>
										<h5><strong>Production</strong></h5>
										<?php
											echo "Planks: ".$planks_production."<br/>";
											echo "Ore: ".$ore_production."<br/>";
											echo "Clay: ".$clay_production."<br/>";
											echo "Food: ".$food_production."<br/>";
										?>
									</div>
									<div class="village">
										<div class="keep">
											<a href="http://google.com"><img src="frontend/images/keep.png"/></a>
										</div>
									</div>
									<div class="armies">
										<h4>Armies</h4>
									</div>
								</div>
							<?php
						}
						?>
					<a href="index.php?page=index">Index</a>
					<a href="index.php?page=contact">Contact</a>
				</div>
			</div>
			<?php require_once("frontend/templates/footer.php"); ?>
		</div>
	</body>
</html>