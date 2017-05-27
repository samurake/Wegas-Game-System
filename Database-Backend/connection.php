<?php
//Oracle DB user name
$username = 'wegasgame';

// Oracle DB user password
$password = 'wegasgame';

// Oracle DB connection string
$connection_string = 'localhost/xe';

//Connect to an Oracle database
$connection = oci_connect(
$username,
$password,
$connection_string
);

If (!$connection)
echo 'Connection failed';
else
echo 'Connection succesfull';

// Close connection
//oci_close($connection);
?>
