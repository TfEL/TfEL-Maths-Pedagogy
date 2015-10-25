<?php

// This is the tokenisation process for the app
// because we're sepcifying this key in the app
// we're only specifying the allowed keys by hand
// isn't that beatuiful.  In the future, we could
// database this so that we can allow/deny tokens
// you know, all that fancy verification stuff.

// I'm supposing that at each iteration of the
// AppStore publication, this key SHOULD change
// or at least we should add a NEW one, and,
// eventually delete the old ones, to force
// migration, and enforce security policies with
// the user base.

class Tokens {
	// Structure
	public $tokensArray;
	
	public function __construct() {
		$this->tokensArray = array("test" => "a8b8c8d8-123abc", "1.0" => "f2e155da-849cdf"); // This is obviously where we'd do some database work.
	}
	
	public function verifyToken( $token ) {
		if (in_array($token, $this->tokensArray)) {
			return true;
		} else {
			return false;
		}
	}	
}

?>