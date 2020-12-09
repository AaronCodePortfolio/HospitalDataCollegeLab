<div class="container">
	<div class="grey lighten-1 loginBox center-align">
		<h3>Input patient data</h3>
		<form action="index.php" method="post">
			<input type="hidden" name="userName" value="<?php echo $userName?>">
  			<input type="hidden" name="pass" value="<?php echo $pass?>">
			<div class="row">
				<div class="input-field col s8 offset-s2">
					<input type="text" name="fName" id="fName" required>
					<label for="fName">First Name</label>
				</div>
				<div class="input-field col s8 offset-s2">
					<input type="text" name="lName" id="lName" required>
					<label for="lName">Last Name</label>
				</div>
				
				<div class="input-field col s8 offset-s2">
					<input type="text" name="bday" id="bday" class="datepicker" required>
					<label for="bday">Birthday</label>
				</div>
			</div>
			<button class="btn waves-effect waves-light logsubmit light-blue lighten-1" type="submit" name="action" value="<?php echo $action ?>">Submit</button>
		</form>
	</div>
</div>