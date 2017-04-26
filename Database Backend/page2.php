<?php
include("connection.php");

if(isset($_POST['Search']))
{
	$val1 = $_POST['Search'];
}

$query = 'SELECT userid, username, email from PLAYERS WHERE instr(username,:name1,1)>0 ORDER BY userid';
$statemen = oci_parse($connection, $query);
oci_bind_by_name($statemen, ":name1", $val1);
oci_execute($statemen);
while($row = oci_fetch_array($statemen, OCI_ASSOC))
{
	echo $row['USERID']." - ";
	echo $row['USERNAME']." - ";
	echo $row['EMAIL']."<br>\n";
}

oci_free_statement($statemen);

?>

<html>
<body>

<form action="page.php" method="post">
  <input type="submit" value="CLEAR">
</form>

</body>
</html>
