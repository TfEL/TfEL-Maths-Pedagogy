<?php

// Abstract class for presentation

abstract class Presentation { 
	public $title;
	public $contents;
	public $page;
	
	abstract public function generatePage( $title, $contents );
}

?>