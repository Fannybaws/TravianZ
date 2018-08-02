<?php 
if(!is_numeric($_SESSION['search'])) {
?>
	<center><font color=orange size=2><p class=\"error\">The user <b>"<?php echo $_SESSION['search']; ?>"</b> does not exist.</p></font></center>
<?php
    $search = 0;
}
else {
$search = $_SESSION['search'];
}
?>
<table cellpadding="1" cellspacing="1" id="player_off" class="row_table_data">
			<thead>
				<tr>
					<th colspan="5">
						The most successful attackers						<div id="submenu"><a title="Top 10" href="statistiken.php?id=7"><img class="btn_top10" src="img/x.gif" alt="Top 10" /></a><a title="defender" href="statistiken.php?id=32"><img class="btn_def" src="img/x.gif" alt="defender" /></a><a title="attacker" href="statistiken.php?id=31"><img class="active btn_off" src="img/x.gif" alt="attacker" /></a></div>		    
					</th>
				</tr>
		<tr><td></td><td>Player</td><td>Population</td><td>Villages</td><td>Points</td></tr>
		</thead><tbody>  
        <?php
        $rankArray = $ranking->getRank();
        if(isset($_GET['rank'])){
            $multiplier = 1;
            if(is_numeric($_GET['rank'])) {
                if($_GET['rank'] > count($rankArray)) {
                    $_GET['rank'] = count($rankArray) - 1;
                }
                while($_GET['rank'] > (20 * $multiplier)) $multiplier++;
                
                $start = 20 * $multiplier - 19;
            }
            else $start = ($_SESSION['start'] + 1);
        }
        else $start = ($_SESSION['start'] + 1);
        
        if(count($rankArray) > 1) {
            for($i = $start; $i < $start + 20; $i++) {
                if(isset($rankArray[$i]['username']) && $rankArray[$i] != "pad") {
                	if($i == $search) echo "<tr class=\"hl\"><td class=\"ra fc\" >";                   
                    else echo "<tr><td class=\"ra \" >";
                    
                    echo $i.".</td><td class=\"pla \" >";
                    if($rankArray[$i]['access'] > 2){
                        echo"<u><a href=\"spieler.php?uid=".$rankArray[$i]['id']."\">".$rankArray[$i]['username']."</a></u>";
				    } else {
				        echo"<a href=\"spieler.php?uid=".$rankArray[$i]['id']."\">".$rankArray[$i]['username']."</a>";
					}	
					echo"</td><td class=\"pop \" >".$rankArray[$i]['totalpop']."";
					echo "</td><td class=\"vil\">".$rankArray[$i]['totalvillages']."</td><td class=\"po \" >".$rankArray[$i]['apall']."</td></tr>";
                }
            }
        }
        else echo "<td class=\"none\" colspan=\"5\">No users found</td>";      
        ?>
</tbody>
</table>
<?php 
include("ranksearch.tpl");
?>
