<?php
session_start();


    session_destroy();
    session_write_close();
    echo "<script>location.href='login.php'</script>";

?>