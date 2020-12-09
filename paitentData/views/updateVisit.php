<div class="container">
	<div class="grey lighten-1 row">
		<form action="index.php" method="post" class="row">
			<input type="hidden" name="userName" value="<?php echo $userName?>">
  			<input type="hidden" name="pass" value="<?php echo $pass?>">

  			<input type="hidden" name="visitID" value="<?php echo $visitID?>">
  			<?php foreach ($paitentVisit as $visit):?>
  			<div class="input-field col s8 offset-s2">
				<input type="text" name="staffUser" id="staffUser" value="<?php echo sodium_crypto_secretbox_open($visit['staffUser'], $nonce, $key); ?>" required>
				<label for="staffUser">Staff Username</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" class="datepicker" name="dateIn" id="dateIn" value="<?php echo $visit['dateIn'] ?>" required>
				<label for="dateIn">Date In</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" class="datepicker" name="dateOut" id="dateOut" value="<?php echo $visit['dateOut'] ?>">
				<label for="dateOut">Date Out</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" name="reason" id="reason" value="<?php echo sodium_crypto_secretbox_open($visit['reason'], $nonce, $key); ?>">
				<label for="reason">Reason</label>
			</div>
			<?php endforeach ?>
			<div class="center-align col s12">
				<button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="updateVisit">Submit</button>
			</div>
		</form>
	</div>
</div>