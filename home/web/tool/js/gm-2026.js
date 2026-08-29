(() => {
  'use strict';

  const API_URL = '/api/index.php';
  const TOKEN_KEY = 'meow3q_gm_token';
  const SERVER_ID = '1';
  const state = { token: sessionStorage.getItem(TOKEN_KEY) || '', admin: null, player: null, pendingAction: null, catalog: { resources: [], items: [] } };
  const UNSAFE_MAIL_REWARDS = new Set(['0:97', '0:98', '0:99']);
  const $ = (selector, root = document) => root.querySelector(selector);
  const $$ = (selector, root = document) => [...root.querySelectorAll(selector)];

  const pages = {
    dashboard: ['TỔNG QUAN', 'Trung tâm vận hành'],
    players: ['NGƯỜI CHƠI', 'Tra cứu người chơi'],
    currency: ['TIỀN TỆ', 'Điều chỉnh số dư'],
    mail: ['BƯU KIỆN', 'Gửi vật phẩm'],
    history: ['AUDIT LOG', 'Nhật ký GM']
  };

  async function request(action, data = {}, controller = null, token = state.token) {
    const payload = { action, data };
    if (controller) payload.controller = controller;
    if (token) payload.token = token;
    const response = await fetch(API_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });
    let json;
    try { json = await response.json(); }
    catch (_) { throw new Error('Máy chủ trả về dữ liệu không hợp lệ.'); }
    if (json.code !== 200 && json.code !== 1368) throw new Error(json.msg || `Lỗi API ${json.code}`);
    return json;
  }

  function formatNumber(value) {
    if (value === null || value === undefined || value === '') return '—';
    return new Intl.NumberFormat('vi-VN').format(Number(value) || 0);
  }

  function formatTime(timestamp) {
    if (!timestamp) return '—';
    return new Intl.DateTimeFormat('vi-VN', { dateStyle: 'short', timeStyle: 'medium' }).format(new Date(Number(timestamp) * 1000));
  }

  function escapeHtml(value) {
    const div = document.createElement('div');
    div.textContent = value ?? '';
    return div.innerHTML;
  }

  function toast(message, type = 'success') {
    const item = document.createElement('div');
    item.className = `toast ${type === 'error' ? 'error' : ''}`;
    item.textContent = message;
    $('#toastStack').appendChild(item);
    setTimeout(() => item.remove(), 4200);
  }

  function setLoading(button, loading, label = 'Đang xử lý...') {
    if (!button) return;
    if (loading) {
      button.dataset.label = button.textContent;
      button.textContent = label;
      button.disabled = true;
    } else {
      button.textContent = button.dataset.label || button.textContent;
      button.disabled = false;
    }
  }

  function showApp(user) {
    state.admin = user;
    $('#loginView').classList.add('is-hidden');
    $('#appView').classList.remove('is-hidden');
    $('#adminName').textContent = user.account || 'GM';
    navigate('dashboard');
    loadCatalog();
    loadHistory();
  }

  function showLogin(message = '') {
    $('#appView').classList.add('is-hidden');
    $('#loginView').classList.remove('is-hidden');
    $('#loginStatus').textContent = message;
  }

  async function validateAdmin(token = state.token) {
    const result = await request('getAllServer', {}, 'admin', token);
    if (!result || result.code !== 200) throw new Error('Không thể xác minh quyền quản trị.');
    return true;
  }

  async function restoreSession() {
    if (!state.token) return showLogin();
    try {
      await validateAdmin();
      const user = await request('getUser', {}, null, state.token);
      showApp(user.data || { account: 'GM' });
    } catch (_) {
      sessionStorage.removeItem(TOKEN_KEY);
      state.token = '';
      showLogin('Phiên GM đã hết hạn. Vui lòng đăng nhập lại.');
    }
  }

  function navigate(page) {
    if (!pages[page]) return;
    $$('.page-section').forEach(section => section.classList.toggle('is-hidden', section.dataset.page !== page));
    $$('.nav-item').forEach(item => item.classList.toggle('is-active', item.dataset.section === page));
    $('#breadcrumb').textContent = pages[page][0];
    $('#pageTitle').textContent = pages[page][1];
    $('.sidebar').classList.remove('is-open');
    if (page === 'history') loadHistory();
  }

  function setPlayer(player) {
    state.player = player;
    $('#statAccount').textContent = player.account;
    $('#statCoin').textContent = formatNumber(player.coin);
    $('#statVip').textContent = `VIP ${formatNumber(player.vip)}`;
    $$('[data-target-banner]').forEach(el => {
      el.classList.add('has-target');
      el.textContent = `Đang thao tác: ${player.account} · VIP ${player.vip || 0} · ${formatNumber(player.coin)} xu`;
    });
    $('#dashboardPlayerState').innerHTML = `<span>✓</span><p>Đã chọn <b>${escapeHtml(player.account)}</b>. Có thể chuyển sang Tiền tệ hoặc Gửi vật phẩm.</p>`;
    renderPlayer(player);
  }

  function renderPlayer(player) {
    const node = $('#playerResult');
    node.className = 'player-result player-card glass-panel';
    node.innerHTML = `
      <div class="player-identity">
        <div class="player-crest">${escapeHtml(player.account.slice(0, 1).toUpperCase())}</div>
        <h3>${escapeHtml(player.account)}</h3>
        <p>VIP ${formatNumber(player.vip)}</p>
      </div>
      <div class="player-data">
        <div class="data-cell"><small>XU</small><b>${formatNumber(player.coin)}</b></div>
        <div class="data-cell"><small>XU KHÓA</small><b>${formatNumber(player.coin_lock)}</b></div>
        <div class="data-cell"><small>KIM CƯƠNG</small><b>${formatNumber(player.diamond)}</b></div>
        <div class="data-cell"><small>LƯỢT QUAY</small><b>${formatNumber(player.wheel)}</b></div>
        <div class="data-cell"><small>TỔNG NẠP</small><b>${formatNumber(player.pay_all)}</b></div>
        <div class="data-cell"><small>TRẠNG THÁI</small><b>${Number(player.block) === 1 ? 'Đã khóa' : 'Hoạt động'}</b></div>
        <div class="player-actions"><button class="button button-primary" data-player-action="currency">Điều chỉnh tiền</button><button class="button button-ghost" data-player-action="mail">Gửi vật phẩm</button></div>
      </div>`;
    $$('[data-player-action]', node).forEach(btn => btn.addEventListener('click', () => navigate(btn.dataset.playerAction)));
  }

  async function searchPlayer(query, button) {
    const account = String(query || '').trim();
    if (!account) return toast('Nhập tài khoản cần tìm.', 'error');
    setLoading(button, true, 'Đang tìm...');
    try {
      const result = await request('searchUser', { search: account, page: 1, limit: 20 }, 'admin');
      const list = result.data?.list || [];
      const exact = list.find(item => String(item.account).toLowerCase() === account.toLowerCase());
      if (!exact) throw new Error('Không tìm thấy tài khoản chính xác.');
      setPlayer(exact);
      $('#playerSearchInput').value = exact.account;
      $('#quickSearchInput').value = exact.account;
      toast(`Đã chọn tài khoản ${exact.account}.`);
      return exact;
    } catch (error) {
      toast(error.message, 'error');
      throw error;
    } finally { setLoading(button, false); }
  }

  function openConfirm(summary, action) {
    if (!state.player) return toast('Hãy chọn tài khoản trước.', 'error');
    state.pendingAction = action;
    $('#confirmSummary').innerHTML = summary;
    $('#confirmAccountLabel').textContent = state.player.account;
    $('#confirmAccountInput').value = '';
    $('#acceptConfirm').disabled = true;
    $('#confirmModal').classList.remove('is-hidden');
    setTimeout(() => $('#confirmAccountInput').focus(), 50);
  }

  function closeConfirm() {
    state.pendingAction = null;
    $('#confirmModal').classList.add('is-hidden');
  }

  async function updateCurrency(form, button) {
    if (!state.player) return toast('Hãy tra cứu và chọn tài khoản trước.', 'error');
    const data = Object.fromEntries(new FormData(form));
    data.count_as_recharge = form.elements.count_as_recharge.checked ? '1' : '0';
    const fields = ['coin', 'coin_lock', 'diamond', 'wheel'];
    if (fields.every(key => Number(data[key]) === 0)) return toast('Cần nhập ít nhất một thay đổi khác 0.', 'error');
    const lines = fields.filter(key => Number(data[key]) !== 0).map(key => {
      const labels = { coin: 'Xu', coin_lock: 'Xu khóa', diamond: 'Kim cương', wheel: 'Lượt quay' };
      const value = Number(data[key]);
      return `<b>${labels[key]}:</b> ${value > 0 ? '+' : ''}${formatNumber(value)}`;
    });
    const rechargeLine = Number(data.coin) > 0
      ? `<br><b>Tích nạp/VIP:</b> ${data.count_as_recharge === '1' ? `Có (+${formatNumber(data.coin)})` : 'Không'}`
      : '';
    openConfirm(`${lines.join('<br>')}${rechargeLine}<br><b>Lý do:</b> ${escapeHtml(data.reason)}`, async () => {
      setLoading($('#acceptConfirm'), true);
      try {
        await request('updateUserInfo', { ...data, account: state.player.account }, 'admin');
        toast(`Đã cập nhật tiền tệ cho ${state.player.account}.`);
        closeConfirm();
        form.reset();
        fields.forEach(key => form.elements[key].value = '0');
        await searchPlayer(state.player.account, null).catch(() => {});
      } catch (error) { toast(error.message, 'error'); }
      finally { setLoading($('#acceptConfirm'), false); }
    });
  }

  async function prepareMail(form) {
    if (!state.player) return toast('Hãy tra cứu và chọn tài khoản trước.', 'error');
    const data = Object.fromEntries(new FormData(form));
    const rewardParts = String(data.reward_code || '').split(':').map(Number);
    if (rewardParts.length !== 2 || rewardParts.some(Number.isNaN)) return toast('Hãy chọn phần thưởng hợp lệ.', 'error');
    if (UNSAFE_MAIL_REWARDS.has(data.reward_code)) return toast('Tai nguyen BT/test nay khong the gui qua thu vi co the lam do game khi nhan.', 'error');
    const selected = $('#rewardSelect').selectedOptions[0];
    const rewardName = selected?.dataset.name || data.reward_code;
    const submit = $('button[type="submit"]', form);
    setLoading(submit, true, 'Đang kiểm tra nhân vật...');
    try {
      const roleResult = await request('checkInfo', { tab: 'account', account: state.player.account, server_id: SERVER_ID }, 'admin');
      const role = roleResult.data;
      $('#rolePreview').innerHTML = `<small>NHÂN VẬT NHẬN</small><b>${escapeHtml(role.role_name)} · Cấp ${formatNumber(role.level)} · Lực chiến ${formatNumber(role.power)}</b>`;
      openConfirm(`<b>Nhân vật:</b> ${escapeHtml(role.role_name)}<br><b>Phần thưởng:</b> ${escapeHtml(rewardName)} × ${formatNumber(data.amount)}<br><b>Mã game:</b> ${escapeHtml(data.reward_code)}<br><b>Lý do:</b> ${escapeHtml(data.reason)}`, async () => {
        setLoading($('#acceptConfirm'), true, 'Đang gửi...');
        try {
          const gifts = JSON.stringify([{ type: rewardParts[0], id: rewardParts[1], amount: Number(data.amount) }]);
          await request('sendItemToUser', { tab: 'account', account: state.player.account, server_id: SERVER_ID, gifts, reason: data.reason }, 'admin');
          toast(`Đã gửi vật phẩm cho ${role.role_name}.`);
          closeConfirm();
          form.reset();
          form.elements.amount.value = '1';
          renderRewardOptions();
          loadHistory();
        } catch (error) { toast(error.message, 'error'); }
        finally { setLoading($('#acceptConfirm'), false); }
      });
    } catch (error) { toast(error.message, 'error'); }
    finally { setLoading(submit, false); }
  }

  async function loadCatalog() {
    if (state.catalog.items.length) return renderRewardOptions();
    try {
      const response = await fetch('/tool/data/item-catalog.json?v=1');
      if (!response.ok) throw new Error('Không tải được danh mục vật phẩm.');
      const catalog = await response.json();
      state.catalog.resources = Array.isArray(catalog.resources) ? catalog.resources : [];
      state.catalog.items = Array.isArray(catalog.items) ? catalog.items : [];
      renderRewardOptions();
    } catch (error) {
      $('#rewardSelect').innerHTML = '<option value="">Không tải được danh mục</option>';
      toast(error.message, 'error');
    }
  }

  function rewardPool() {
    const group = $('#rewardGroup').value;
    const query = $('#rewardSearch').value.trim().toLocaleLowerCase('vi');
    let list;
    if (group === 'resource') list = state.catalog.resources;
    else if (group === 'item') list = state.catalog.items.filter(item => item.canUse);
    else list = state.catalog.items;
    list = list.filter(item => !UNSAFE_MAIL_REWARDS.has(String(item.reward || '')));
    if (query) list = list.filter(item => `${item.id} ${item.name} ${item.description || ''}`.toLocaleLowerCase('vi').includes(query));
    return list.slice(0, 250);
  }

  function renderRewardOptions() {
    const select = $('#rewardSelect');
    const list = rewardPool();
    if (!list.length) {
      select.innerHTML = '<option value="">Không tìm thấy phần thưởng</option>';
      updateRewardPreview();
      return;
    }
    select.innerHTML = list.map(item => `<option value="${escapeHtml(item.reward)}" data-name="${escapeHtml(item.name)}" data-description="${escapeHtml(item.description || item.key || '')}">${escapeHtml(item.name)} · ${escapeHtml(item.reward)}</option>`).join('');
    updateRewardPreview();
  }

  function updateRewardPreview() {
    const option = $('#rewardSelect').selectedOptions[0];
    $('#rewardPreview').innerHTML = option && option.value
      ? `<small>PHẦN THƯỞNG</small><b>${escapeHtml(option.dataset.name)} · ${escapeHtml(option.value)}</b><p>${escapeHtml(option.dataset.description || '')}</p>`
      : '<small>PHẦN THƯỞNG</small><b>Chưa chọn</b><p></p>';
  }

  async function loadHistory() {
    if (!state.token) return;
    const body = $('#historyBody');
    body.innerHTML = '<tr><td colspan="4" class="table-empty">Đang tải nhật ký...</td></tr>';
    try {
      const result = await request('getAllLogAdmin', { page: 1, limit: 30 }, 'admin');
      const list = result.data?.list || [];
      body.innerHTML = list.length ? list.map(item => `<tr><td>${formatTime(item.create_time)}</td><td>${escapeHtml(item.account)}</td><td>${escapeHtml(item.type)}</td><td>${escapeHtml(item.action)}</td></tr>`).join('') : '<tr><td colspan="4" class="table-empty">Chưa có thao tác GM.</td></tr>';
    } catch (error) {
      body.innerHTML = `<tr><td colspan="4" class="table-empty">${escapeHtml(error.message)}</td></tr>`;
    }
  }

  $('#loginForm').addEventListener('submit', async event => {
    event.preventDefault();
    const button = $('button[type="submit"]', event.currentTarget);
    $('#loginStatus').textContent = '';
    setLoading(button, true, 'Đang xác thực...');
    try {
      const result = await request('sign', { type: 'in', account: $('#loginAccount').value.trim(), password: $('#loginPassword').value }, null, '');
      const token = result.data?.token;
      if (!token) throw new Error('Không nhận được token đăng nhập.');
      await validateAdmin(token);
      state.token = token;
      sessionStorage.setItem(TOKEN_KEY, token);
      showApp(result.data);
      toast('Đăng nhập GM thành công.');
    } catch (error) { $('#loginStatus').textContent = error.message; }
    finally { setLoading(button, false); }
  });

  $$('.nav-item').forEach(item => item.addEventListener('click', () => navigate(item.dataset.section)));
  $$('[data-jump]').forEach(item => item.addEventListener('click', () => navigate(item.dataset.jump)));
  $('#menuButton').addEventListener('click', () => $('.sidebar').classList.toggle('is-open'));
  $('#logoutButton').addEventListener('click', () => {
    sessionStorage.removeItem(TOKEN_KEY);
    state.token = '';
    state.player = null;
    showLogin('Đã đăng xuất khỏi GM Center.');
  });
  $('#quickSearchForm').addEventListener('submit', event => { event.preventDefault(); searchPlayer($('#quickSearchInput').value, $('button', event.currentTarget)).catch(() => {}); });
  $('#playerSearchForm').addEventListener('submit', event => { event.preventDefault(); searchPlayer($('#playerSearchInput').value, $('button', event.currentTarget)).catch(() => {}); });
  $('#currencyForm').addEventListener('submit', event => { event.preventDefault(); updateCurrency(event.currentTarget, $('button[type="submit"]', event.currentTarget)); });
  $('#mailForm').addEventListener('submit', event => { event.preventDefault(); prepareMail(event.currentTarget); });
  $('#rewardGroup').addEventListener('change', () => { $('#rewardSearch').value = ''; renderRewardOptions(); });
  $('#rewardSearch').addEventListener('input', renderRewardOptions);
  $('#rewardSelect').addEventListener('change', updateRewardPreview);
  $('#refreshHistory').addEventListener('click', loadHistory);
  $('#cancelConfirm').addEventListener('click', closeConfirm);
  $('#confirmModal').addEventListener('click', event => { if (event.target === event.currentTarget) closeConfirm(); });
  $('#confirmAccountInput').addEventListener('input', event => { $('#acceptConfirm').disabled = !state.player || event.target.value.trim() !== state.player.account; });
  $('#acceptConfirm').addEventListener('click', () => { if (state.pendingAction) state.pendingAction(); });
  document.addEventListener('keydown', event => { if (event.key === 'Escape') closeConfirm(); });

  restoreSession();
})();
