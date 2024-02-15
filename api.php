<?php
header("Content-type: application/json; charset=utf-8");



$lang = ($_GET['lang']) ? $_GET['lang'] : "kz";


$goods = [
	"products" => [
		"ru" => '[{"name":"Хлеб","price":150},{"name":"Молоко","price":410},{"name":"Сыр","price":4200}]',
		"kz" => '[{"name":"asd","price":150},{"name":"Молоко","price":410},{"name":"Сыр","price":4200}]',
		"en" => '[{"name":"ddd","price":150},{"name":"Молоко","price":410},{"name":"Сыр","price":4200}]'
	]
];

// echo '[{"lang": "'.$_GET['lang'].'"}]'

echo $goods[$_GET['page']][$lang];

// if($_GET['page'] == 'products') {
// 	echo '[{"name":"Хлеб","price":150},{"name":"Молоко","price":410},{"name":"Сыр","price":4200}]';
// } elseif ($_GET['page'] == 'contacts') {
// 	echo '[{"name":"Вася","tel":"+77771234567"},{"name":"Петя","tel":"+77776543210"}]';
// } else {
// 	echo '[{"error":"Не указан параметр страницы"}]';
// }

?>