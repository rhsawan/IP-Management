<?php
	session_start();
	require_once "GoogleAPI/vendor/autoload.php";
	$gClient = new Google_Client();
	$gClient->setClientId("636304320349-5ettggh0m81vpdrkds7pktq80014ve07.apps.googleusercontent.com");
	$gClient->setClientSecret("CnB5yHwDZgSom_qUvlhoC-Si");
	$gClient->setApplicationName("ICT Cell");
	$gClient->setRedirectUri("http://localhost:8090/ictcell/g-callback.php");
	$gClient->addScope("https://www.googleapis.com/auth/userinfo.profile");
	$gClient->addScope("https://www.googleapis.com/auth/userinfo.email");
    //$gClient->setScopes($creds->scopes);
	//$gClient->addScope(scope_of_scopes: "https://www.googleapis.com/auth/plus.login htps://www.googleapis.com/auth/userinfo.email");
?>