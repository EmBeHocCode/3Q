<?php
$toolPath = parse_url(isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '/tool/', PHP_URL_PATH);
$hasLoginQuery = isset($_GET['username']) || isset($_GET['password']);
if($toolPath === '/tool' || $hasLoginQuery) {
  header('Location: /tool/', true, 303);
  exit;
}
?>
<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="theme-color" content="#080b16">
  <title>Meow 3Q — GM Center</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/tool/css/gm-2026.css?v=1.0.1">
</head>
<body>
  <div class="ambient ambient-one"></div>
  <div class="ambient ambient-two"></div>

  <section class="login-shell" id="loginView">
    <div class="login-card glass-panel">
      <div class="brand-mark" aria-hidden="true"><span>M</span></div>
      <p class="eyebrow">MEOW 3Q · CONTROL CENTER</p>
      <h1>Đăng nhập GM</h1>
      <p class="muted">Dùng tài khoản quản trị của trang Meow 3Q. Tài khoản người chơi không thể truy cập.</p>

      <form id="loginForm" method="post" action="/tool/" autocomplete="on">
        <label class="field">
          <span>Tài khoản quản trị</span>
          <input id="loginAccount" name="username" autocomplete="username" placeholder="Nhập tài khoản" required>
        </label>
        <label class="field">
          <span>Mật khẩu</span>
          <input id="loginPassword" name="password" type="password" autocomplete="current-password" placeholder="Nhập mật khẩu" required>
        </label>
        <button class="button button-primary button-wide" type="submit">
          <span>Vào GM Center</span><span aria-hidden="true">→</span>
        </button>
      </form>
      <p class="login-status" id="loginStatus" role="status"></p>
      <div class="security-note"><i></i> Mọi thay đổi đều được ghi vào nhật ký admin.</div>
    </div>
  </section>

  <div class="app-shell is-hidden" id="appView">
    <aside class="sidebar glass-panel">
      <div class="side-brand">
        <div class="brand-mark brand-small"><span>M</span></div>
        <div><b>Meow 3Q</b><small>GM CENTER</small></div>
      </div>

      <nav class="side-nav" aria-label="Điều hướng GM">
        <button class="nav-item is-active" data-section="dashboard"><span class="nav-icon">⌂</span>Tổng quan</button>
        <button class="nav-item" data-section="players"><span class="nav-icon">♙</span>Người chơi</button>
        <button class="nav-item" data-section="currency"><span class="nav-icon">◈</span>Tiền tệ</button>
        <button class="nav-item" data-section="mail"><span class="nav-icon">✦</span>Gửi vật phẩm</button>
        <button class="nav-item" data-section="history"><span class="nav-icon">↺</span>Nhật ký GM</button>
      </nav>

      <div class="server-chip">
        <span class="status-dot"></span>
        <div><b>Meow 3Q</b><small>Máy chủ 1 · đang chọn</small></div>
      </div>
      <button class="logout-button" id="logoutButton">Đăng xuất</button>
    </aside>

    <main class="main-area">
      <header class="topbar">
        <button class="mobile-menu" id="menuButton" aria-label="Mở menu">☰</button>
        <div>
          <p class="eyebrow">MEOW 3Q / <span id="breadcrumb">TỔNG QUAN</span></p>
          <h2 id="pageTitle">Trung tâm vận hành</h2>
        </div>
        <div class="admin-pill">
          <span class="admin-avatar">GM</span>
          <div><b id="adminName">admin</b><small>Quản trị viên</small></div>
        </div>
      </header>

      <div class="content-area">
        <section class="page-section" data-page="dashboard">
          <div class="hero-card glass-panel">
            <div>
              <span class="live-badge"><i></i> HỆ THỐNG SẴN SÀNG</span>
              <h3>Quản trị Meow 3Q<br><em>nhanh, rõ và an toàn.</em></h3>
              <p>Tìm người chơi trước, sau đó mọi thao tác tiền tệ và vật phẩm sẽ tự gắn đúng tài khoản.</p>
            </div>
            <div class="hero-orb" aria-hidden="true"><span>3Q</span></div>
          </div>

          <div class="stat-grid">
            <article class="stat-card glass-panel"><span class="stat-icon violet">♙</span><div><small>Tài khoản đang chọn</small><strong id="statAccount">Chưa chọn</strong></div></article>
            <article class="stat-card glass-panel"><span class="stat-icon cyan">◈</span><div><small>Số xu hiện tại</small><strong id="statCoin">—</strong></div></article>
            <article class="stat-card glass-panel"><span class="stat-icon gold">♛</span><div><small>Cấp VIP</small><strong id="statVip">—</strong></div></article>
          </div>

          <div class="dashboard-grid">
            <article class="workspace-card glass-panel">
              <div class="card-heading"><div><p class="eyebrow">TÌM NHANH</p><h3>Tra cứu người chơi</h3></div><span class="key-hint">ENTER</span></div>
              <form class="search-row" id="quickSearchForm">
                <input id="quickSearchInput" placeholder="Nhập chính xác tài khoản..." autocomplete="off">
                <button class="button button-primary" type="submit">Tìm tài khoản</button>
              </form>
              <div class="empty-state compact" id="dashboardPlayerState">
                <span>⌕</span><p>Chưa chọn tài khoản để thao tác.</p>
              </div>
            </article>

            <article class="workspace-card glass-panel">
              <div class="card-heading"><div><p class="eyebrow">THAO TÁC NHANH</p><h3>Công cụ thường dùng</h3></div></div>
              <div class="quick-actions">
                <button data-jump="currency"><span class="stat-icon violet">◈</span><b>Cộng xu</b><small>Xu, xu khóa, kim cương</small></button>
                <button data-jump="mail"><span class="stat-icon cyan">✦</span><b>Gửi vật phẩm</b><small>Gửi thư đến nhân vật</small></button>
                <button data-jump="history"><span class="stat-icon gold">↺</span><b>Xem lịch sử</b><small>Kiểm tra thao tác GM</small></button>
              </div>
            </article>
          </div>
        </section>

        <section class="page-section is-hidden" data-page="players">
          <article class="workspace-card glass-panel">
            <div class="card-heading"><div><p class="eyebrow">NGƯỜI CHƠI</p><h3>Tìm tài khoản hoặc nhân vật</h3></div><span class="server-label">S1 · MEOW 3Q</span></div>
            <form class="search-row" id="playerSearchForm">
              <input id="playerSearchInput" placeholder="Tên tài khoản..." autocomplete="off">
              <button class="button button-primary" type="submit">Tra cứu</button>
            </form>
          </article>
          <div id="playerResult" class="player-result empty-state glass-panel"><span>♙</span><h3>Chưa có người chơi</h3><p>Nhập tài khoản để xem số dư, VIP và thông tin nhân vật.</p></div>
        </section>

        <section class="page-section is-hidden" data-page="currency">
          <div class="section-grid">
            <article class="workspace-card glass-panel">
              <div class="card-heading"><div><p class="eyebrow">TIỀN TỆ</p><h3>Cộng hoặc trừ số dư</h3></div><span class="safe-badge">Có xác nhận</span></div>
              <div class="target-banner" data-target-banner>Chưa chọn tài khoản. Hãy tra cứu người chơi trước.</div>
              <form id="currencyForm" class="form-grid">
                <label class="field"><span>Xu</span><input type="number" name="coin" value="0" step="1"><small>Dùng số âm để trừ.</small></label>
                <label class="field"><span>Xu khóa</span><input type="number" name="coin_lock" value="0" step="1"></label>
                <label class="field"><span>Kim cương</span><input type="number" name="diamond" value="0" step="1"></label>
                <label class="field"><span>Lượt quay</span><input type="number" name="wheel" value="0" step="1"></label>
                <label class="recharge-option field-full">
                  <input type="checkbox" name="count_as_recharge" value="1" checked>
                  <span><b>Tính Xu cộng vào tích nạp và VIP web</b><small>Chỉ áp dụng cho số Xu dương; các tài nguyên khác không được tính.</small></span>
                </label>
                <label class="field field-full"><span>Lý do thao tác</span><input name="reason" maxlength="160" placeholder="Ví dụ: Bù lỗi sự kiện ngày 10/08" required></label>
                <button class="button button-primary field-full" type="submit">Kiểm tra và xác nhận thay đổi</button>
              </form>
            </article>
            <aside class="notice-card glass-panel"><span>!</span><h3>Quy tắc an toàn</h3><p>Số nhập vào là phần chênh lệch, không phải số dư cuối. Hệ thống yêu cầu gõ lại tài khoản trước khi thực hiện.</p><div class="notice-example"><small>Ví dụ</small><b>+100.000.000 xu</b><b>-500 kim cương</b></div></aside>
          </div>
        </section>

        <section class="page-section is-hidden" data-page="mail">
          <div class="section-grid">
            <article class="workspace-card glass-panel">
              <div class="card-heading"><div><p class="eyebrow">BƯU KIỆN HỆ THỐNG</p><h3>Gửi vật phẩm đến nhân vật</h3></div><span class="server-label">S1 · MEOW 3Q</span></div>
              <div class="target-banner" data-target-banner>Chưa chọn tài khoản. Hãy tra cứu người chơi trước.</div>
              <form id="mailForm" class="form-grid">
                <label class="field"><span>Nhóm phần thưởng</span><select id="rewardGroup"><option value="resource">Tài nguyên trong game</option><option value="item">Vật phẩm dùng được</option><option value="all-item">Toàn bộ vật phẩm</option></select></label>
                <label class="field"><span>Tìm theo tên hoặc ID</span><input id="rewardSearch" placeholder="Ví dụ: Nguyên bảo, 100001..." autocomplete="off"></label>
                <label class="field field-full"><span>Phần thưởng đã chọn</span><select id="rewardSelect" name="reward_code" required><option value="">Đang tải danh mục...</option></select></label>
                <label class="field"><span>Số lượng</span><input type="number" name="amount" min="1" max="999999999" value="1" required></label>
                <label class="field field-full"><span>Lý do gửi</span><input name="reason" maxlength="160" placeholder="Ví dụ: Quà hỗ trợ trải nghiệm" required></label>
                <button class="button button-primary field-full" type="submit">Kiểm tra nhân vật và gửi</button>
              </form>
            </article>
            <aside class="notice-card glass-panel"><span>✦</span><h3>Thư hệ thống</h3><p>Danh mục được đọc trực tiếp từ dữ liệu game: 19 tài nguyên ví và hơn 1.000 vật phẩm. Người chơi có thể cần tải lại game để thấy thư mới.</p><div id="rewardPreview" class="reward-preview"><small>PHẦN THƯỞNG</small><b>Chưa chọn</b><p></p></div><div id="rolePreview" class="role-preview"><small>Nhân vật nhận</small><b>Chưa kiểm tra</b></div></aside>
          </div>
        </section>

        <section class="page-section is-hidden" data-page="history">
          <article class="workspace-card glass-panel">
            <div class="card-heading"><div><p class="eyebrow">AUDIT LOG</p><h3>Nhật ký thao tác GM</h3></div><button id="refreshHistory" class="button button-ghost">Tải lại</button></div>
            <div class="table-wrap">
              <table><thead><tr><th>Thời gian</th><th>GM</th><th>Loại</th><th>Chi tiết thao tác</th></tr></thead><tbody id="historyBody"><tr><td colspan="4" class="table-empty">Đang tải nhật ký...</td></tr></tbody></table>
            </div>
          </article>
        </section>
      </div>
    </main>
  </div>

  <div class="modal-backdrop is-hidden" id="confirmModal" role="dialog" aria-modal="true" aria-labelledby="confirmTitle">
    <div class="confirm-card glass-panel">
      <span class="confirm-icon">!</span>
      <p class="eyebrow">XÁC NHẬN THAO TÁC</p>
      <h3 id="confirmTitle">Kiểm tra lần cuối</h3>
      <div class="confirm-summary" id="confirmSummary"></div>
      <label class="field"><span>Gõ lại tài khoản <b id="confirmAccountLabel"></b></span><input id="confirmAccountInput" autocomplete="off"></label>
      <div class="modal-actions"><button class="button button-ghost" id="cancelConfirm">Hủy</button><button class="button button-danger" id="acceptConfirm" disabled>Xác nhận thực hiện</button></div>
    </div>
  </div>

  <div class="toast-stack" id="toastStack" aria-live="polite"></div>
  <script src="/tool/js/gm-2026.js?v=1.0.4"></script>
</body>
</html>
