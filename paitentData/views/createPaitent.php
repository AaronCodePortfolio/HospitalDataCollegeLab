<div class="container">
	<div class="grey lighten-1">
		<h3 class="center-align">Create a new patient</h3>
		<form action="index.php" method="post" class="row">
			<input type="hidden" name="userName" value="<?php echo $userName?>">
  			<input type="hidden" name="pass" value="<?php echo $pass?>">
  			<div class="input-field col s4">
				<input type="text" name="fname" id="fname" required>
				<label for="fname">First Name</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="mname" id="mname" required>
				<label for="mname">Middle Name</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="lname" id="lname" required>
				<label for="lname">Last Name</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="street" id="street" required>
				<label for="street">Street</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="city" id="city" required>
				<label for="city">City</label>
			</div>
			<div class="input-field col s2">
				<input type="text" name="state" id="state" required>
				<label for="state">State</label>
			</div>
			<div class="input-field col s2">
				<input type="text" name="zip" id="zip" required>
				<label for="zip">Zip</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" class="datepicker" name="bday" id="bday" required>
				<label for="bday">Birth Day</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" name="ssn" id="ssn" required>
				<label for="ssn">SSN</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="tel" name="phone" id="phone" required>
				<label for="phone">Phone</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="email" name="email" id="email">
				<label for="email">Email</label>
			</div>
			<div class="center-align col s12">
				<button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="subNewPaitent">Submit</button>
			</div>
			
		</form>
	</div>
</div>