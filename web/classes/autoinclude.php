<?php
	
// Autoinc

if (!$base) {
	$base = "./";
}

// Abstract Classes
require $base . "classes/presentation.abs.class.php";

// Solid Classes
require $base . "classes/presentation.class.php";
require $base . "classes/sharedata.class.php";
require $base . "classes/token.class.php"

?>