<div class="container">
	<div class="grey lighten-1 loginBox center-align">
		<h3>Hippo Crates General Hospital</h3>
		<h4>Login</h4>
		<?php 
			if(isset($permission))
			{
				if($permission->permission == "fail")
				{
					echo("<h5>Incorrect password or username.  Try again.</h5>");
				}
				elseif ($permission->permission == "timeout") 
				{
					echo("<h5>Session timed out log in again</h5>");
				}	
			}
		?>
		<form action="index.php" method="post">
			<div class="row">
				<div class="input-field col s8 offset-s2">
					<input type="text" name="userName" id="userName" required>
					<label for="userName">User Name</label>
				</div>
				
				<div class="input-field col s8 offset-s2">
					<input type="password" name="pass" id="pass" required>
					<label for="pass">Password</label>
				</div>
			</div>
			<button class="btn waves-effect waves-light logsubmit light-blue lighten-1" type="submit" name="action">Log In</button>
		</form>
	</div>
</div>