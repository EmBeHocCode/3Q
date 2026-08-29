<?php
include_once('../api/config.php');
require_once API_DIR.'/includes/utils.php';
require_once API_DIR.'/includes/pdo.php';
require_once API_DIR.'/service/configAction/index.php';
$config = (new Config())->getConfig();
?>

<!doctype html>
<html lang="vi">
<head>
  <title><?php echo $config['game_name']; ?></title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
  <meta name="description" content="<?php echo $config['game_info']; ?>">
  <meta property="og:title" content="<?php echo $config['game_name']; ?>" />
  <meta property="og:description" content="<?php echo $config['game_info']; ?>">
  <meta property="og:type" content="website" />
  <meta property="og:url" content="<?php echo $config['web_link']; ?>" />
  <meta property="og:image" content="<?php echo $config['game_banner']; ?>" />
  <meta property="og:locale" content="VI_VN" />
  <meta property="og:locale:alternate" content="en_US" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Quicksand:300,400,500,600,700">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
   <!-- <script src="/client/js/devtool.js"></script>
  
Change for Production-->
  <script defer="defer" src="/client/js/chunk-vendors.5b7d5129.js"></script>
  <script defer="defer" src="/client/js/app.3fe29340.js?v=20260811-16"></script>
  <script defer="defer" src="/client/js/neo-2026.js?v=20260811-41"></script>
  <script defer="defer" src="/client/js/game-pay-bridge.js?v=20260810-8"></script>
  <link href="/client/css/app.6fa9ec80.css" rel="stylesheet">
  <link href="/client/css/neo-2026.css?v=20260811-39" rel="stylesheet">
</head>

<body>
  <script type="text/javascript">
    window.CONFIG = <?php echo json_encode($config); ?>;
    window.SOCKET_URL = "<?php echo SOCKET_URL; ?>";
  </script>
  <div id="app"></div>
</body>
</html>
