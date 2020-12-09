<?php
	require("models/Conn.php");
	require("models/getKey.php");

	if(isset($_POST['userName']))
	{
		$userName = trim(filter_input(INPUT_POST, 'userName', FILTER_SANITIZE_STRING));
	}
	else
	{
		$userName = "null";
	}

	if(isset($_POST['pass']))
	{
		$pass = trim(filter_input(INPUT_POST, 'pass', FILTER_SANITIZE_STRING));
	}
	else
	{
		$pass = "null";
	}

	include("views/header.php");

	if($userName == "null" || $pass == "null")
	{
		include("views/login.php");
	}
	else
	{
		//Test login
		$encUserName = sodium_crypto_secretbox($userName, $nonce, $key);
		$encPass = sodium_crypto_secretbox($pass, $nonce, $key);
		$sql = $db->prepare("CALL login('$encUserName', '$encPass', @permission)");
		$sql->execute();
		$permission = $db->query("SELECT @permission AS permission")->fetch(PDO::FETCH_OBJ);

		print_r($permission);

		if($permission->permission == null || $permission->permission == "timeout")
		{
			include("views/login.php");
		}
		else
		{
			$permission = sodium_crypto_secretbox_open($permission->permission, $nonce, $key);
			$permissionSet = array("dr" => 1, "nurse" => 2, "desk" => 3);

			include("views/headerbar.php");

			if(isset($_POST['action']))
			{
				$action = trim(filter_input(INPUT_POST, 'action', FILTER_SANITIZE_STRING));
			}
			else
			{
				$action = "null";
			}


			echo $action;

			if($action == "Create Paitent")
			{
				include("views/createPaitent.php");
			}
			else if($action == "subNewPaitent")
			{
				if(isset($_POST['fname']))
				{
					$fname = trim(filter_input(INPUT_POST, 'fname', FILTER_SANITIZE_STRING));
				}
				else
				{
					$fname = "null";
				}
				if(isset($_POST['mname']))
				{
					$mname = trim(filter_input(INPUT_POST, 'mname', FILTER_SANITIZE_STRING));
				}
				else
				{
					$mname = "null";
				}
				if(isset($_POST['lname']))
				{
					$lname = trim(filter_input(INPUT_POST, 'lname', FILTER_SANITIZE_STRING));
				}
				else
				{
					$lname = "null";
				}
				if(isset($_POST['street']))
				{
					$street = trim(filter_input(INPUT_POST, 'street', FILTER_SANITIZE_STRING));
				}
				else
				{
					$street = "null";
				}
				if(isset($_POST['city']))
				{
					$city = trim(filter_input(INPUT_POST, 'city', FILTER_SANITIZE_STRING));
				}
				else
				{
					$city = "null";
				}
				if(isset($_POST['state']))
				{
					$state = trim(filter_input(INPUT_POST, 'state', FILTER_SANITIZE_STRING));
				}
				else
				{
					$state = "null";
				}
				if(isset($_POST['zip']))
				{
					$zip = trim(filter_input(INPUT_POST, 'zip', FILTER_SANITIZE_STRING));
				}
				else
				{
					$zip = "null";
				}
				if(isset($_POST['bday']))
				{
					$bday = trim(filter_input(INPUT_POST, 'bday', FILTER_SANITIZE_STRING));
				}
				else
				{
					$bday = "null";
				}
				if(isset($_POST['ssn']))
				{
					$ssn = trim(filter_input(INPUT_POST, 'ssn', FILTER_SANITIZE_STRING));
				}
				else
				{
					$ssn = "null";
				}
				if(isset($_POST['phone']))
				{
					$phone = trim(filter_input(INPUT_POST, 'phone', FILTER_SANITIZE_STRING));
				}
				else
				{
					$phone = "null";
				}
				if(isset($_POST['email']))
				{
					$email = trim(filter_input(INPUT_POST, 'email', FILTER_SANITIZE_STRING));
				}
				else
				{
					$email = "null";
				}

				$CreatePaitent = $db->prepare("CALL CreatePaitent(:fname, :mname, :lname, :street, :city, :state, :zip, :phone, :bday, :ssn, :email, :encUserName)");

				$fname = sodium_crypto_secretbox($fname, $nonce, $key);
				$CreatePaitent->bindParam(":fname", $fname);
				$mname = sodium_crypto_secretbox($mname, $nonce, $key);
				$CreatePaitent->bindParam(":mname", $mname);
				$lname = sodium_crypto_secretbox($lname, $nonce, $key);
				$CreatePaitent->bindParam(":lname", $lname);
				$street = sodium_crypto_secretbox($street, $nonce, $key);
				$CreatePaitent->bindParam(":street", $street);
				$city = sodium_crypto_secretbox($city, $nonce, $key);
				$CreatePaitent->bindParam(":city", $city);
				$state = sodium_crypto_secretbox($state, $nonce, $key);
				$CreatePaitent->bindParam(":state", $state);
				$zip = sodium_crypto_secretbox($zip, $nonce, $key);
				$CreatePaitent->bindParam(":zip", $zip);
				$phone = sodium_crypto_secretbox($phone, $nonce, $key);
				$CreatePaitent->bindParam(":phone", $phone);
				$bday = sodium_crypto_secretbox($bday, $nonce, $key);
				$CreatePaitent->bindParam(":bday", $bday);
				$ssn = sodium_crypto_secretbox($ssn, $nonce, $key);
				$CreatePaitent->bindParam(":ssn", $ssn);
				$email = sodium_crypto_secretbox($email, $nonce, $key);
				$CreatePaitent->bindParam(":email", $email);
				$CreatePaitent->bindParam(":encUserName", $encUserName);
				$CreatePaitent->execute();
			}
			else if($action == "GetPaitent")
			{
				if(isset($_POST['fName']) && isset($_POST['lName']) && isset($_POST['bday']))
				{
					$fName = trim(filter_input(INPUT_POST, 'fName', FILTER_SANITIZE_STRING));
					$lName = trim(filter_input(INPUT_POST, 'lName', FILTER_SANITIZE_STRING));
					$bday = trim(filter_input(INPUT_POST, 'bday', FILTER_SANITIZE_STRING));

					$getPaitentData = $db->prepare("CALL GetPaitentID(:fName, :lName, :bday, @paitentID, :userName)");


					$fName = sodium_crypto_secretbox($fName, $nonce, $key);
					$getPaitentData->bindParam(":fName", $fName);
					$lName = sodium_crypto_secretbox($lName, $nonce, $key);
					$getPaitentData->bindParam(":lName", $lName);
					$bday = sodium_crypto_secretbox($bday, $nonce, $key);
					$getPaitentData->bindParam(":bday", $bday);
					$getPaitentData->bindParam(":userName", $userName);
					$getPaitentData->execute();
					$paitentID = $db->query("SELECT @paitentID AS paitentID")->fetch(PDO::FETCH_OBJ);

					$getPaitentData = $db->prepare("CALL getPaitentData(:paitentID, @fName, @mName, @lName, @street, @city, @state, @zip, @phone, @bday, @ssn, @email, @dday)");


					$getPaitentData->bindParam(":paitentID", $paitentID->paitentID);
					$getPaitentData->execute();

					$fName = $db->query("SELECT @fName AS fName")->fetch(PDO::FETCH_OBJ);
					$mName = $db->query("SELECT @mName AS mName")->fetch(PDO::FETCH_OBJ);
					$lName = $db->query("SELECT @lName AS lName")->fetch(PDO::FETCH_OBJ);
					$street = $db->query("SELECT @street AS street")->fetch(PDO::FETCH_OBJ);
					$city = $db->query("SELECT @city AS city")->fetch(PDO::FETCH_OBJ);
					$state = $db->query("SELECT @state AS state")->fetch(PDO::FETCH_OBJ);
					$zip = $db->query("SELECT @zip AS zip")->fetch(PDO::FETCH_OBJ);
					$phone = $db->query("SELECT @phone AS phone")->fetch(PDO::FETCH_OBJ);
					$bday = $db->query("SELECT @bday AS bday")->fetch(PDO::FETCH_OBJ);
					$ssn = $db->query("SELECT @ssn AS ssn")->fetch(PDO::FETCH_OBJ);
					$email = $db->query("SELECT @email AS email")->fetch(PDO::FETCH_OBJ);
					$dday = $db->query("SELECT @dday AS dday")->fetch(PDO::FETCH_OBJ);



					$fName = sodium_crypto_secretbox_open($fName->fName, $nonce, $key);
					$mName = sodium_crypto_secretbox_open($mName->mName, $nonce, $key);
					$lName = sodium_crypto_secretbox_open($lName->lName, $nonce, $key);
					$street = sodium_crypto_secretbox_open($street->street, $nonce, $key);
					$city = sodium_crypto_secretbox_open($city->city, $nonce, $key);
					$state = sodium_crypto_secretbox_open($state->state, $nonce, $key);
					$zip = sodium_crypto_secretbox_open($zip->zip, $nonce, $key);
					$phone = sodium_crypto_secretbox_open($phone->phone, $nonce, $key);
					$bday = sodium_crypto_secretbox_open($bday->bday, $nonce, $key);
					$ssn = sodium_crypto_secretbox_open($ssn->ssn, $nonce, $key);
					$email = sodium_crypto_secretbox_open($email->email, $nonce, $key);
					$dday = sodium_crypto_secretbox_open($dday->dday, $nonce, $key);

					include("views/displayPaitent.php");
				}
				else
				{
					include("views/SelectPaitent.php");
				}
			}
			else if($action == "updatePaitent")
			{
				$updatePaitent = $db->prepare("CALL updatePaitentData(:fName, :mName, :lName, :street, :city, :state, :zip, :bday, :ssn, :phone, :email, :dday, :paitentID, :username);");
				$fName = trim(filter_input(INPUT_POST, 'fname', FILTER_SANITIZE_STRING));
				$fName = sodium_crypto_secretbox($fName, $nonce, $key);
				$updatePaitent->bindParam(":fName", $fName);
				$mName = trim(filter_input(INPUT_POST, 'mname', FILTER_SANITIZE_STRING));
				$mName = sodium_crypto_secretbox($mName, $nonce, $key);
				$updatePaitent->bindParam(":mName", $mName);
				$lName = trim(filter_input(INPUT_POST, 'lname', FILTER_SANITIZE_STRING));
				$lName = sodium_crypto_secretbox($lName, $nonce, $key);
				$updatePaitent->bindParam(":lName", $lName);
				$street = trim(filter_input(INPUT_POST, 'street', FILTER_SANITIZE_STRING));
				$street = sodium_crypto_secretbox($street, $nonce, $key);
				$updatePaitent->bindParam(":street", $street);
				$city = trim(filter_input(INPUT_POST, 'city', FILTER_SANITIZE_STRING));
				$city = sodium_crypto_secretbox($city, $nonce, $key);
				$updatePaitent->bindParam(":city", $city);
				$state = trim(filter_input(INPUT_POST, 'state', FILTER_SANITIZE_STRING));
				$state = sodium_crypto_secretbox($state, $nonce, $key);
				$updatePaitent->bindParam(":state", $state);
				$zip = trim(filter_input(INPUT_POST, 'zip', FILTER_SANITIZE_STRING));
				$zip = sodium_crypto_secretbox($zip, $nonce, $key);
				$updatePaitent->bindParam(":zip", $zip);
				$bday = trim(filter_input(INPUT_POST, 'bday', FILTER_SANITIZE_STRING));
				$bday = sodium_crypto_secretbox($bday, $nonce, $key);
				$updatePaitent->bindParam(":bday", $bday);
				$ssn = trim(filter_input(INPUT_POST, 'ssn', FILTER_SANITIZE_STRING));
				$ssn = sodium_crypto_secretbox($ssn, $nonce, $key);
				$updatePaitent->bindParam(":ssn", $ssn);
				$phone = trim(filter_input(INPUT_POST, 'phone', FILTER_SANITIZE_STRING));
				$phone = sodium_crypto_secretbox($phone, $nonce, $key);
				$updatePaitent->bindParam(":phone", $phone);
				$email = trim(filter_input(INPUT_POST, 'email', FILTER_SANITIZE_STRING));
				$email = sodium_crypto_secretbox($email, $nonce, $key);
				$updatePaitent->bindParam(":email", $email);
				$dday = trim(filter_input(INPUT_POST, 'dday', FILTER_SANITIZE_STRING));
				$dday = sodium_crypto_secretbox($dday, $nonce, $key);
				$updatePaitent->bindParam(":dday", $dday);
				$paitentID = trim(filter_input(INPUT_POST, 'paitentID', FILTER_SANITIZE_STRING));
				$updatePaitent->bindParam(":paitentID", $paitentID);
				$dday = trim(filter_input(INPUT_POST, 'dday', FILTER_SANITIZE_STRING));
				print_r($paitentID);
				$updatePaitent->bindParam(":username", $username);
				$updatePaitent->execute();
			}
			else if($action == "createVisit")
			{
				if(isset($_POST['fName']) && isset($_POST['lName']) && isset($_POST['bday']))
				{
					$fName = trim(filter_input(INPUT_POST, 'fName', FILTER_SANITIZE_STRING));
					$lName = trim(filter_input(INPUT_POST, 'lName', FILTER_SANITIZE_STRING));
					$bday = trim(filter_input(INPUT_POST, 'bday', FILTER_SANITIZE_STRING));

					$getPaitentData = $db->prepare("CALL GetPaitentID(:fName, :lName, :bday, @paitentID, :userName)");


					$fName = sodium_crypto_secretbox($fName, $nonce, $key);
					$getPaitentData->bindParam(":fName", $fName);
					$lName = sodium_crypto_secretbox($lName, $nonce, $key);
					$getPaitentData->bindParam(":lName", $lName);
					$bday = sodium_crypto_secretbox($bday, $nonce, $key);
					$getPaitentData->bindParam(":bday", $bday);
					$getPaitentData->bindParam(":userName", $userName);
					$getPaitentData->execute();
					$paitentID = $db->query("SELECT @paitentID AS paitentID")->fetch(PDO::FETCH_OBJ);

					print_r($paitentID);

					include("views/createVisit.php");
				}
				else if (isset($_POST['paitentID']))
				{
					$createVisit = $db->prepare("CALL CreateVisit(:userName, :paitentID, :dateIn, :dateOut, :reason);");

					$userName = trim(filter_input(INPUT_POST, 'userName', FILTER_SANITIZE_STRING));
					$userName = sodium_crypto_secretbox($userName, $nonce, $key);
					$createVisit->bindParam(":userName", $userName);

			

					$paitentID = trim(filter_input(INPUT_POST, 'paitentID', FILTER_SANITIZE_NUMBER_INT));
					$createVisit->bindParam(":paitentID", $paitentID);
					$dateIn = trim(filter_input(INPUT_POST, 'dateIn', FILTER_SANITIZE_STRING));
					$createVisit->bindParam(":dateIn", $dateIn);
			

					$dateOut = trim(filter_input(INPUT_POST, 'dateOut', FILTER_SANITIZE_STRING));
					$createVisit->bindParam(":dateOut", $dateOut);
								

					$reason = trim(filter_input(INPUT_POST, 'reason', FILTER_SANITIZE_STRING));
					$reason = sodium_crypto_secretbox($reason, $nonce, $key);
					$createVisit->bindParam(":reason", $reason);
			

					$stuff = $createVisit->execute();
			
				}
				else
				{
					include("views/SelectPaitent.php");
				}
			}
			else if($action == "getVisits")
			{
				if(isset($_POST['fName']) && isset($_POST['lName']) && isset($_POST['bday']))
				{
					$fName = trim(filter_input(INPUT_POST, 'fName', FILTER_SANITIZE_STRING));
					$lName = trim(filter_input(INPUT_POST, 'lName', FILTER_SANITIZE_STRING));
					$bday = trim(filter_input(INPUT_POST, 'bday', FILTER_SANITIZE_STRING));

					$getPaitentData = $db->prepare("CALL GetPaitentID(:fName, :lName, :bday, @paitentID, :userName)");


					$fName = sodium_crypto_secretbox($fName, $nonce, $key);
					$getPaitentData->bindParam(":fName", $fName);
					$lName = sodium_crypto_secretbox($lName, $nonce, $key);
					$getPaitentData->bindParam(":lName", $lName);
					$bday = sodium_crypto_secretbox($bday, $nonce, $key);
					$getPaitentData->bindParam(":bday", $bday);
					$getPaitentData->bindParam(":userName", $userName);
					$getPaitentData->execute();
					$paitentID = $db->query("SELECT @paitentID AS paitentID")->fetch(PDO::FETCH_OBJ);


					$getPaitentVisits = "SELECT ylvlw.ylvlwlg AS visitId, ylvlw.xvhuqdph AS staffUser, ylvlw.gdwhlq AS dateIn, ylvlw.gdwhrxw AS dateOut, ylvlw.uhdvrq AS reason FROM ylvlw WHERE $paitentID->paitentID = ylvlw.sdwlhqwqxp";
					$paitentVisits = $db->query($getPaitentVisits);

					include("views/displayVisit.php");
				}
				else if(isset($_POST['visitID']))
				{

					$visitID = trim(filter_input(INPUT_POST, 'visitID', FILTER_SANITIZE_STRING));

					$getPaitentVisit = "SELECT ylvlw.xvhuqdph AS staffUser, ylvlw.gdwhlq AS dateIn, ylvlw.gdwhrxw AS dateOut, ylvlw.uhdvrq AS reason FROM ylvlw WHERE $visitID = ylvlw.ylvlwlg";
					$paitentVisit = $db->query($getPaitentVisit);

					include("views/updateVisit.php");
				}
				else
				{
					include("views/SelectPaitent.php");
				}
			}
			else if($action == "updateVisit")
			{
				$visitID = trim(filter_input(INPUT_POST, 'visitID', FILTER_SANITIZE_STRING));
				$staffUser = trim(filter_input(INPUT_POST, 'staffUser', FILTER_SANITIZE_STRING));
				$dateIn = trim(filter_input(INPUT_POST, 'dateIn', FILTER_SANITIZE_STRING));
				if(isset($_POST['dateOut']))
				{
					$dateOut = trim(filter_input(INPUT_POST, 'dateOut', FILTER_SANITIZE_STRING));
				}
				else
				{
					$dateOut = "";
				}
				if(isset($_POST['reason']))
				{
					$reason = trim(filter_input(INPUT_POST, 'reason', FILTER_SANITIZE_STRING));
				}
				else
				{
					$reason = "";
				}

				$staffUser = sodium_crypto_secretbox($staffUser, $nonce, $key);
				$reason = sodium_crypto_secretbox($reason, $nonce, $key);


				$updateVisit = "UPDATE ylvlw SET ylvlw.xvhuqdph = '$staffUser', ylvlw.gdwhlq = '$dateIn', ylvlw.gdwhrxw = '$dateOut', ylvlw.uhdvrq = '$reason' WHERE ylvlw.ylvlwlg = '$visitID'";
				$db->query($updateVisit);
			}

			/*$CreatePaitent = $db->prepare("CALL CreatePaitent(:fname, :mname, :lname, :street, :city, :state, :zip, :phone, :birthdate, :ssn, :email, :encUserName)");

			$fname = sodium_crypto_secretbox("Anna", $nonce, $key);
			$CreatePaitent->bindParam(":fname", $fname);
			$mname = sodium_crypto_secretbox("Bryce", $nonce, $key);
			$CreatePaitent->bindParam(":mname", $mname);
			$lname = sodium_crypto_secretbox("Williams", $nonce, $key);
			$CreatePaitent->bindParam(":lname", $lname);
			$street = sodium_crypto_secretbox("123 road way", $nonce, $key);
			$CreatePaitent->bindParam(":street", $street);
			$city = sodium_crypto_secretbox("placetown", $nonce, $key);
			$CreatePaitent->bindParam(":city", $city);
			$state = sodium_crypto_secretbox("NY", $nonce, $key);
			$CreatePaitent->bindParam(":state", $state);
			$zip = sodium_crypto_secretbox("12345", $nonce, $key);
			$CreatePaitent->bindParam(":zip", $zip);
			$phone = sodium_crypto_secretbox("1674985531", $nonce, $key);
			$CreatePaitent->bindParam(":phone", $phone);
			$birthdate = sodium_crypto_secretbox("1997-04-29", $nonce, $key);
			$CreatePaitent->bindParam(":birthdate", $birthdate);
			$ssn = sodium_crypto_secretbox("349457866", $nonce, $key);
			$CreatePaitent->bindParam(":ssn", $ssn);
			$email = sodium_crypto_secretbox("williaab@alfredstate.edu", $nonce, $key);
			$CreatePaitent->bindParam(":email", $email);
			$CreatePaitent->bindParam(":encUserName", $encUserName);
			$CreatePaitent->execute();
*/
			
			
		
			
		}
	}


	
	
	include("views/footer.php");



	//$fname = sodium_crypto_secretbox("bob", $nonce, $key);
	//$lname = sodium_crypto_secretbox("boberson", $nonce, $key);
	//$position = sodium_crypto_secretbox("dr", $nonce, $key);
	//$username = sodium_crypto_secretbox("test", $nonce, $key);
	//$password = sodium_crypto_secretbox("password", $nonce, $key);

	//$fname = "bob";
	//$lname = "boberson";
	//$position = "dr";
	//$username = "test";
	//$password = "password";
	//$permission = "fail";


    //$sql = $db->prepare("CALL login('$username', '$password', @permission)");
	//$sql->execute();
	//$permission = $db->query("SELECT @permission AS permission")->fetch(PDO::FETCH_OBJ);
	//echo sodium_crypto_secretbox_open($permission->permission, $nonce, $key);
?>