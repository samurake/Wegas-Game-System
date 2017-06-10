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


If (isset($_POST['r_username']) && isset($_POST['r_password']) && isset($_POST['r_email']))
{
    //be sure to validate and clean your variables
    $val1 = $_POST['r_username'];
    $val2 = $_POST['r_password'];
    $val3 = $_POST['r_email'];

    $stid = oci_parse($connection, strip_special_characters("begin :r := usershandler.registerC(:u,:e,:p); end;"));
    oci_bind_by_name($stid, ':r', $r, 40);
    oci_bind_by_name($stid, ':u', $val1);
    oci_bind_by_name($stid, ':e', $val3);
    oci_bind_by_name($stid, ':p', $val2);

    oci_execute($stid);

    if($r == 1)
    echo '<script type = "text/javascript" >alert("Thank you for playing this game. You can now login.");
          window.location.pathname = "Medieval%20City/index.html";
          </script>';
    else
    echo '<script type = "text/javascript" >alert("Registration Failed. There is already an user with this name.");
          window.location.pathname = "Medieval%20City/index.html";
          </script>';

    oci_free_statement($stid);

}
oci_close($connection);
?>
