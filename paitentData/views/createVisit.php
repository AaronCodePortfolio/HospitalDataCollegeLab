<div class="container">
	<div class="grey lighten-1 row">
		<form action="index.php" method="post" class="row">
			<input type="hidden" name="userName" value="<?php echo $userName?>">
  			<input type="hidden" name="pass" value="<?php echo $pass?>">
  			<input type="hidden" name="paitentID" value="<?php echo $paitentID->paitentID?>">
			<div class="input-field col s8 offset-s2">
				<input type="text" class="datepicker" name="dateIn" id="dateIn">
				<label for="dateIn">Date In</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" class="datepicker" name="dateOut" id="dateOut">
				<label for="dateOut">Date Out</label>
			</div>
			<div class="input-field col s8 offset-s2">
				<input type="text" name="reason" id="reason">
				<label for="reason">Reason</label>
			</div>
			<div class="center-align col s12">
				<button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="createVisit">Submit</button>
			</div>
		</form>
	</div>
</div>