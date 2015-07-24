<?php
	
class shareData {
	public $pdo;
	public $return;
	
	public $insert;
	public $verify;
	
	public $contents;
	
	function __construct() {
		$this->pdo = new PDO("sqlite:tmpweb.sqlite3"); // "mysql:host=;dbname=", 'username', 'password' <- mysql?
		$this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		$this->insert = "INSERT INTO \"tmpshares\" (\"id\",\"shareid\",\"createdtoken\",\"sharedata\") VALUES (NULL,?,?,?)";
		$this->verify = "SELECT * FROM \"tmpshares\" where `id` = ?;";
	}
	
	private function idExists($id) {
		$exists = $this->pdo->prepare($this->verify);
				
		$exists->execute(array($shareid));
			
		if ($exists->fetchColumn()) {
			$shareid = true;
		} else {
			$shareid = false;
		}
		
		return $shareid;
	}
	
	function createShare($dataIncoming) {
		$dataIncoming = json_decode($dataIncoming, true);
		if ($dataIncoming) {
			if($dataIncoming['source'] == "tmp") {
				
				
				$shareid = mt_rand();
				
				while ($this->idExists($shareid)) {
					$shareid = mt_rand();
				}
				
				$createdtoken = $dataIncoming['apptoken'];
				$sharedata = json_encode($dataIncoming['appdata']);
				
				if (empty($sharedata) || empty($createdtoken)) { 
					$this->return = false;
				} else {
					$prepared = $this->pdo->prepare($this->insert);
					$prepared->execute(array($shareid, $createdtoken, $sharedata));
					
					$shareurl = array("url"=>"https://maths.tfel.edu.au/s/" . $shareid);
					$this->return = $shareurl;
				}
			} else {
				$this->return = false;
			}
		} else {
			$this->return = false;
		}
		return $this->return;
	}
	
	function retrieveShare($code) {
		$query = $this->pdo->prepare("SELECT * FROM `tmpshares` where `shareid` = '$code';");
		
		try {
		$result = $query->execute();
		} catch (PDOException $e) {
			var_dump($e);
		}
		
		$result = $query->fetchAll();
				
		if ($result) {
			$this->contents = json_decode($result[0][4], true);
		} else {
			$this->contents = false;
		}
		
		return $this; 
	}
}
	
?>