<?php
include("connection.php");

$query = 'SELECT userid, username, email FROM (SELECT userid, username, email, rownum FROM (SELECT userid, username, email from PLAYERS ORDER BY userid) WHERE rownum <= :pg order by rownum desc) WHERE  rownum < 11 order by rownum asc';
$statemen = oci_parse($connection, $query);

$page=$_GET['page'];
if($page<'2')
{
	$page=1;
}
$page1=$page*10;
oci_bind_by_name($statemen, ":pg", $page1);
oci_execute($statemen);

while($row = oci_fetch_array($statemen, OCI_ASSOC))
{
	echo $row['USERID']." - ";
	echo $row['USERNAME']." - ";
	echo $row['EMAIL']."<br>\n";
}

//count pages
$query2 = "select * from PLAYERS";
$statemen2 = oci_parse($connection, $query2);
oci_execute($statemen2);
$numerotate=oci_fetch_all($statemen2, $res);
$a = $numerotate/10;
$a = ceil($a);

echo "<br>";
echo "<br>";

for($b=1; $b<=$a; $b++)
{
	?><a href="page.php?page=<?php echo $b; ?>" style="text-decoration:none "><?php echo $b." "; ?></a><?php
}
oci_free_statement($statemen);

//oci_close($connection);
?>


<html>
<body>

<form action="page2.php" method="post">
   Search dupa user:<br>
  <input type="text" name="Search" value="">
  <br>
  <input type="submit" value="Search">
</form>

</body>
</html>
