<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
date_default_timezone_set('Asia/Ho_Chi_Minh');

// Start the session
session_start();

try {
    // Kết nối tới cơ sở dữ liệu
    $pdo = new PDO("mysql:host=127.0.0.1;dbname=WEB", "root", "EHrWXkpA30e6f7CQx2cx");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Set PDO để ném ngoại lệ khi có lỗi
    $pdo->exec('set names utf8'); // Sử dụng mã hóa UTF-8
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage()); // Hiển thị lỗi nếu kết nối thất bại
}

$post = $_POST;
$get = $_GET;

// Các bộ lọc để ngăn chặn tấn công SQL Injection
$getfilter = "'|(and|or)\\b.+?(>|<|=|in|like)|\\/\\*.+?\\*\\/|<\\s*script\\b|\\bEXEC\\b|UNION.+?SELECT|UPDATE.+?SET|INSERT\\s+INTO.+?VALUES|(SELECT|DELETE).+?FROM|(CREATE|ALTER|DROP|TRUNCATE)\\s+(TABLE|DATABASE)";
$postfilter = "\\b(and|or)\\b.{1,6}?(=|>|<|\\bin\\b|\\blike\\b)|\\/\\*.+?\\*\\/|<\\s*script\\b|\\bEXEC\\b|UNION.+?SELECT|UPDATE.+?SET|INSERT\\s+INTO.+?VALUES|(SELECT|DELETE).+?FROM|(CREATE|ALTER|DROP|TRUNCATE)\\s+(TABLE|DATABASE)";
$cookiefilter = "\\b(and|or)\\b.{1,6}?(=|>|<|\\bin\\b|\\blike\\b)|\\/\\*.+?\\*\\/|<\\s*script\\b|\\bEXEC\\b|UNION.+?SELECT|UPDATE.+?SET|INSERT\\s+INTO.+?VALUES|(SELECT|DELETE).+?FROM|(CREATE|ALTER|DROP|TRUNCATE)\\s+(TABLE|DATABASE)";

// Hàm ngăn chặn tấn công
function StopAttack($StrFiltKey, $StrFiltValue, $ArrFiltReq) {
    if (is_array($StrFiltValue)) {
        $StrFiltValue = implode($StrFiltValue); // Nếu là mảng, chuyển thành chuỗi
    }
    if (preg_match("/" . $ArrFiltReq . "/is", $StrFiltValue) == 1) {
        exit('langtukids ^^!'); // Thông báo nếu phát hiện tấn công
    }
}

// Kiểm tra và lọc các tham số GET, POST, COOKIE
foreach ($_GET as $key => $value) {
    StopAttack($key, $value, $getfilter);
}
foreach ($_POST as $key => $value) {
    StopAttack($key, $value, $postfilter);
}
foreach ($_COOKIE as $key => $value) {
    StopAttack($key, $value, $cookiefilter);
}

// Kiểm tra xem `payid` có tồn tại trong tham số GET không
if (!isset($get['payid'])) {
    exit('Missing payid'); // Thông báo lỗi nếu không có `payid`
}
$payid = $get['payid'];

// Kiểm tra tài khoản người dùng qua ny_user hoặc từ session
$account = "";
if (isset($get['ny_user'])) {
    $account = $get['ny_user'];
    $_SESSION['account'] = $account; // Lưu vào session nếu lấy từ GET
} elseif (isset($_SESSION['account'])) {
    $account = $_SESSION['account']; // Lấy từ session nếu đã đăng nhập
} else {
    exit('Vui lòng đăng nhập'); // Yêu cầu đăng nhập nếu không có tài khoản
}

if ($account) {
    // Truy vấn thông tin người dùng từ bảng ny_user
    $sql = "SELECT * FROM ny_user WHERE account = :account LIMIT 1";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['account' => $account]);
    $info = $stmt->fetch(); // Lấy thông tin người dùng

    if ($info) {
        // Lấy số dư coin của người dùng
        $coin = (int)$info['coin'];  // Chuyển đổi coin thành kiểu số nguyên để so sánh chính xác

        // Mở tệp để tìm `payid` và số coin cần trừ
        $file = fopen("./id.txt", "r");
        $truxu = null; // Biến để lưu số coin cần trừ

        while (!feof($file)) {
            $line = fgets($file);
            $txts = explode(';', $line);
            if ($txts[0] == $payid) {
                $truxu = (int)trim($txts[1]); // Lấy số coin cần trừ và chuyển thành số nguyên
                break;
            }
        }
        fclose($file); // Đóng file sau khi đọc

        // Kiểm tra xem truxu có được tìm thấy trong file không
        if (is_null($truxu)) {
            exit('Payid không hợp lệ'); // Thông báo nếu `payid` không hợp lệ
        }

        // Hiển thị giá trị để kiểm tra (gỡ lỗi)
        // echo "Coin: $coin, Truxu: $truxu"; // Sử dụng để kiểm tra giá trị của `coin` và `truxu`

        // Kiểm tra xem người dùng có đủ coin không
        if ($coin <= 0 || $coin < $truxu) {
            exit('Không đủ coin'); // Thông báo nếu không đủ coin
        } else {
            // Trừ coin và cập nhật vào cơ sở dữ liệu
            $new_coin = $coin - $truxu;
            $stmt = $pdo->prepare("UPDATE ny_user SET coin = :new_coin WHERE account = :account");
            $stmt->execute(['new_coin' => $new_coin, 'account' => $account]);
            exit('true'); // Trả về kết quả thành công
        }
    } else {
        exit('User not found'); // Thông báo nếu không tìm thấy người dùng
    }
} else {
    exit('Vui lòng đăng nhập'); // Thông báo nếu không có tài khoản đăng nhập
}
?>
