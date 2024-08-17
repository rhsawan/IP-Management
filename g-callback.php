<?php

	require_once "config.php";

	if(isset($_SESSION['access_token'])){
		$gClient->setAccessToken($_SESSION['access_token']);
	}else if(isset($_GET['code'])){
		$token = $gClient->fetchAccessTokenWithAuthCode($_GET['code']);
		$_SESSION['access_token'] = $token;
	}else{
		header('Locatoin: index.php');
		exit();
	}

	$oAuth = new Google_Service_Oauth2($gClient);
	$userData = $oAuth->userinfo_v2_me->get();



	$email = explode('@', $userData['email']);
	$emailcheck = strtolower(end($email));

		echo "<script>
				alert('".$emailcheck."');
				window.location.href='index.php';
			</script>";

	if(strcmp($emailcheck,"just.edu.bd") == 0){
		$_SESSION['email'] = $userData['email'];
		$_SESSION['gender'] = $userData['gender'];
		$_SESSION['picture'] = $userData['picture'];
		$_SESSION['familyName'] = $userData['familyName'];
		$_SESSION['givenName'] = $userData['givenName'];

		header('Location: profile.php');
		exit();
	}else{
		echo "<script>
				alert('JUST Authority Provided email adress must be used for login.');
				window.location.href='logout.php';
			</script>";
			exit();
	}
	



	//echo "<pre>";
	//var_dump($userData);
?>