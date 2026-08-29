<?php
header('Content-Type: application/json');

// Tắt cache trình duyệt
header('Cache-Control: no-cache, must-revalidate');
header('Expires: 0');

// Giả lập danh sách người chơi đang online
$onlineUsers = [
    [
        'name' => 'ThiênLong01',
        'strongestHero' => ['tid' => 'hero001']
    ],
    [
        'name' => 'PhongVũ02',
        'strongestHero' => ['tid' => 'hero002']
    ],
    [
        'name' => 'BạchHổ03',
        'strongestHero' => ['tid' => 'hero003']
    ]
];

// Giả lập danh sách người chơi top
$topUsers = [
    ['name' => 'ThiênLong01'],
    ['name' => 'PhongVũ02']
];

// Trả về JSON kết quả
echo json_encode([
    'status' => 'success',
    'onlineUsers' => $onlineUsers,
    'topUsers' => $topUsers
]);
