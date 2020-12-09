<div class="container">
	<div class="grey lighten-1 row">
		<form action="index.php" method="post" class="row">
			<input type="hidden" name="userName" value="<?php echo $userName?>">
  			<input type="hidden" name="pass" value="<?php echo $pass?>">
  			<input type="hidden" name="paitentID" value="<?php echo $paitentID->paitentID ?>">
  			<input type="hidden" name="action" value="getVisits">
  			<table>
  				<tr class="row">
  					<th class="col s2">Staff Username</th>
  					<th class="col s2">Date In</th>
  					<th class="col s2">Date Out</th>
  					<th class="col s4">Reason</th>
  					<th class="col s2">Edit</th>
  				</tr>
  				<?php foreach ($paitentVisits as $visit):?>
  				<tr class="row">
  					<td class="col s2"><?php echo sodium_crypto_secretbox_open($visit['staffUser'], $nonce, $key);?></td>
  					<td class="col s2"><?php echo $visit['dateIn']?></td>
  					<td class="col s2"><?php echo $visit['dateOut']?></td>
  					<td class="col s4"><?php echo sodium_crypto_secretbox_open($visit['reason'], $nonce, $key);?></td>
  					<td class="col s2">
  						
  						<button class="btn waves-effect waves-light logsubmit blue" type="submit" name="visitID" value="<?php echo $visit['visitId']?>">Edit</button>		
  					</td>
  				</tr>
  				<?php endforeach ?>
  			</table>
  		</form>
  	</div>
 </div>