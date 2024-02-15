<?php
$bd = new Mysqli("localhost", "root", "123456", "schedule");
$bd->query("SET NAMES utf8mb4");

$query = $bd->query( 'SELECT	`students_table`.`student_id`,	`students_table`.`group_id`,	`students_table`.`group_name`,	`students_table`.`people_name` FROM `schedule`.`students_table`');
$arr = [];
while($row = $query->fetch_assoc()) {
  $arr[] = $row;
}
$query->close();


for($cnt = 0; $cnt < count($arr); $cnt++) {

  print_r($arr[$cnt]['people_name']);

}



$bd->close();
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>asdasd</title>
  <link rel="stylesheet" href="src/style.css" />
  <script src="src/script.js"></script>
</head>

<body>
  <header>
    <ul id="lang-list">
      <li>
        <span tabindex="0" data-lang="ru">Русский</span>
      </li>
      <li>
        <span tabindex="0" data-lang="kz">Казахский</span>
      </li>
      <li>
        <span tabindex="0" data-lang="en">Английский</span>
      </li>
    </ul>
    <nav>
      <ul id="nav-list">
        <li>
          <span tabindex="0">Главная</span>
        </li>
        <li><span tabindex="0" data-link="products">Продукты</span></li>
        <li><span tabindex="0" data-link="services">Услуги</span></li>
        <li><span tabindex="0" data-link="contacts">Контакты</span></li>
      </ul>
    </nav>
  </header>
</body>

</html>