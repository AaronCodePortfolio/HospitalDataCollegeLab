<?php
	$fin = fopen("models/keyFile.txt", "r");

	// Generating an encryption key and a nonce
	$key   = fgets($fin); //"anfEDz8W8pWf5tKHfXTbEH8Xdr0aDqEj"; //random_bytes(SODIUM_CRYPTO_SECRETBOX_KEYBYTES); // 256 bit
	$nonce = fgets($fin); //"5K7CPchdXPjNHCKKvNrBVhUb"; //random_bytes(SODIUM_CRYPTO_SECRETBOX_NONCEBYTES); // 24 bytes

	$key = str_replace("\n", "", $key);
	$key = str_replace("\r", "", $key);
	$nonce = str_replace("\n", "", $nonce);
	$nonce = str_replace("\r", "", $nonce);

	fclose($fin);
?>