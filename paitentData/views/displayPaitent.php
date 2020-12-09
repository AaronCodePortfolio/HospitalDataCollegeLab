<div class="container">
	<div class="grey lighten-1 row">
		<form action="index.php" method="post" class="row">
			<input type="hidden" name="userName" value="<?php echo $userName?>">
  			<input type="hidden" name="pass" value="<?php echo $pass?>">
  			<input type="hidden" name="paitentID" value="<?php echo $paitentID->paitentID ?>">
  			<div class="input-field col s4">
				<input type="text" name="fname" id="fname" value="<?php echo $fName?>" required>
				<label for="fname">First Name</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="mname" id="mname" value="<?php echo $mName?>" required>
				<label for="mname">Middle Name</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="lname" id="lname" value="<?php echo $lName?>" required>
				<label for="lname">Last Name</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="street" id="street" value="<?php echo $street?>" required>
				<label for="street">Street</label>
			</div>
			<div class="input-field col s4">
				<input type="text" name="city" id="city" value="<?php echo $city?>" required>
				<label for="city">City</label>
			</div>
			<div class="input-field col s2">
				<input type="text" name="state" id="state" value="<?php echo $state?>" required>
				<label for="state">State</label>
			</div>
			<div class="input-field col s2">
				<input type="text" name="zip" id="zip" value="<?php echo $zip?>" required>
				<label for="zip">Zip</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" class="datepicker" name="bday" id="bday" value="<?php echo $bday?>" required>
				<label for="bday">Birth Day</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" name="ssn" id="ssn" value="<?php echo $ssn?>" required>
				<label for="ssn">SSN</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="tel" name="phone" id="phone" value="<?php echo $phone?>" required>
				<label for="phone">Phone</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="email" name="email" id="email" value="<?php echo $email?>">
				<label for="email">Email</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" class="datepicker" name="dday" id="dday" value="<?php echo $dday?>">
				<label for="dday">Death Day</label>
			</div>
			<div class="center-align col s12">
				<button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="updatePaitent">Submit</button>
			</div>
		</form>
	</div>
</div>