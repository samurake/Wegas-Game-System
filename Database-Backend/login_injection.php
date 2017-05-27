<?php
include('connection.php');

function strip_special_characters($str)
  {
    $out = "";
    for ($i = 0;$i < strlen($str);$i++)
      if ((ord($str[$i]) != 9) && (ord($str[$i]) != 10) &&
          (ord($str[$i]) != 13))
        $out .= $str[$i];

    // Return pre-parsed SQL statement.
    return $out;
  }


If (isset($_POST['username']) && isset($_POST['password']))
{
    //be sure to validate and clean your variables
    $val1 = $_POST['username'];
    $val2 = $_POST['password'];

    $query = "SELECT username, passwd from players where username='$val1' and passwd='$val2'";
    $stid = oci_parse($connection, $query);

    oci_execute($stid);

    print '<table border="2">';
    while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    print '<tr><td>' .$row['USERNAME'] .'</td></tr>' .'<tr><td>' .$row['PASSWD'] .'</td></tr>';
  }
    print '</table>';

    oci_free_statement($stid);

}
oci_close($connection);
?>

<html>
<body>

<form action="" method="post">
  Username:<br>
  <input type="text" name="username" value="">
  <br>
  Password:<br>
  <input type="password" name="password" value="">
  <br><br>
  <input type="submit" value="Login">
</form>

</body>
</html>
