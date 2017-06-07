<?php
include('connection.php');
ini_set('display_errors', '0');

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


If (isset($_POST['entity']))
{
    //be sure to validate and clean your variables
    $val1 = $_POST['entity'];


    $stid = oci_parse($connection, strip_special_characters("begin  buildingshandler.calculateBuildingPointsRU(:u); end;"));
    oci_bind_by_name($stid, ':u', $val1);

    $e = oci_execute($stid);

    if(!$e) {
      $e = oci_error($stid);
      echo '<br>';
      print htmlentities($e['message']);
      echo '<br>Loser!';
    }
    else {
      echo '<br>Building Points with entity id: '.$val1.' updated!';
    }

    oci_free_statement($stid);

}
oci_close($connection);
?>
