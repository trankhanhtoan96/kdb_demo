<?php
$price = file_get_contents('https://blockchain.info/tobtc?currency=USD&value=1000');
$price = (float)$price;
$price = 1000 / $price;
if ($_GET['type'] == 1) echo round($price);
if ($_GET['type'] == 2) echo ($price * 1000) % 1000;