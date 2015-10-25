<?php
$base = "./";

// NIVs
date_default_timezone_set('UTC');

// Classes, vendor
require './vendor/autoload.php';
require './classes/autoinclude.php';

// Router follows...
$router = new AltoRouter();

// Index
$router->map( 'GET', '/', function() {
    $tmpPresentation = new tmpPresentation();
    echo $tmpPresentation->generatePage("TfEL Maths Pedagogy", "<h3>TfEL Maths Pedagogy <small>Shared Reflection API</small></h3> <p>Expects arguments on <code>/s/</code> or <code>/a/</code>.</p><p><strong>Here by accident?</strong><br>You probably followed a broken link to someone's shared observation. Ask them to send you the link again.</p><p><strong>Still totally lost?</strong><br>We can help you figure out where you need to go, email <code>DECD.TfEL@sa.gov.au</code>.")->page;
});

// Addition
$router->map( 'POST|PUT', '/a/v[i:version]/[:token]', function($version, $token) {
    header("Content-Type: application/json");
    $tokens = new Tokens();
    if ($tokens->verifyToken($token) && $version == 1) {
	    $shareData = new shareData();
	    $return = $shareData->createShare(file_get_contents('php://input'));
	    if (!$return) {
		    echo json_encode("Failed to create share URL.");
	    } else {
		    echo json_encode($return);
	    }
    } else {
	    echo json_encode("Invalid token, or outdated app.");
    }
});

// Get
$router->map( 'GET', '/s/[i:shareid]', function($shareid) {
	$shareData = new shareData();
	
	$return = $shareData->retrieveShare($shareid);
	
    $tmpPresentation = new tmpPresentation();
    echo $tmpPresentation->generatePage("TfEL Maths - Shared URL", $return->contents)->page;
});

$router->map( 'GET', '/get', function() { header("Location: https://itunes.apple.com/us/app/tfel-maths-pedagogy-audit/id1011669675?ls=1&mt=8"); });

// Router features
$match = $router->match();

// call closure or throw 404 status
if( $match && is_callable( $match['target'] ) ) {
	call_user_func_array( $match['target'], $match['params'] ); 
} else {
	// no route was matched
	header( $_SERVER["SERVER_PROTOCOL"] . ' 404 Not Found');
	$tmpPresentation = new tmpPresentation();
	echo $tmpPresentation->generatePage("TfEL Maths Pedagogy", false)->page;
}

?>