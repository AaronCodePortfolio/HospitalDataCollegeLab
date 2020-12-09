<header>
  <nav class="light-blue lighten-1" role="navigation">
  	<form action="index.php" method="post">
  		<input type="hidden" name="userName" value="<?php echo $userName?>">
  		<input type="hidden" name="pass" value="<?php echo $pass?>">
  		<ul class="<?php if($permissionSet[$permission] > 2){echo "hide";}?>">
        	<li>
        		<button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="Create Paitent">Create patient</button>
        	</li>
      	</ul>
      	<ul class="<?php if($permissionSet[$permission] > 2){echo "hide";}?>">
        	<li>
        		<button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="GetPaitent">Get/Update patient</button>
        	</li>
      	</ul>
        <ul class="<?php if($permissionSet[$permission] > 2){echo "hide";}?>">
          <li>
            <button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="createVisit">Add to patient history</button>
          </li>
        </ul>
        <ul class="<?php if($permissionSet[$permission] > 2){echo "hide";}?>">
          <li>
            <button class="btn waves-effect waves-light logsubmit blue" type="submit" name="action" value="getVisits">Get/Update patient history</button>
          </li>
        </ul>
  	</form>
  </nav>
</header>
