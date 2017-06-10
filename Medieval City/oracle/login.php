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
  If (isset($_POST['a_username']) && isset($_POST['a_password']))
  {
      //be sure to validate and clean your variables
      $val1 = $_POST['a_username'];
      $val2 = $_POST['a_password'];

      $stid = oci_parse($connection, strip_special_characters("begin :r := usershandler.loginR(:u,:p); end;"));
      oci_bind_by_name($stid, ':r', $r, 40);
      oci_bind_by_name($stid, ':u', $val1);
      oci_bind_by_name($stid, ':p', $val2);

      oci_execute($stid);

      if($r > 0)
        header("Location: http://localhost:8101/Medieval%20City/level.html");
      else{
        echo '<script type = "text/javascript" >alert("Invalid User.");
              window.location.pathname = "Medieval%20City/index.html";
              </script>';
      }

      oci_free_statement($stid);

  }
oci_close($connection);
?>
