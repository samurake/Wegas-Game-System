<?php
//Oracle DB user name
$username = 'STUDENT';

// Oracle DB user password
$password = 'STUDENT';

// Oracle DB connection string
$connection_string = 'localhost/xe';

//Connect to an Oracle database
$connection = oci_connect(
$username,
$password,
$connection_string
);

If (!$connection)
echo 'The keks were not in your favour -- connection failed';
else
echo 'Praised be Kek! -- connection succesfull';

// Close connection
//oci_close($connection);
?>
