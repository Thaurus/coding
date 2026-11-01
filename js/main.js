(() => {
  const EMAIL = 'postmaster@branth-chemie.de';
  const body = document.body;

  // Header shadow on scroll
  const header = document.querySelector('.site-header');
  const onScroll = () => header && header.classList.toggle('is-scrolled', window.scrollY > 8);
  onScroll();
  window.addEventListener('scroll', onScroll, { passive: true });

  // Mobile navigation
  const toggle = document.querySelector('.nav-toggle');
  const nav = document.getElementById('main-nav');
  const setNav = (open) => {
    body.classList.toggle('nav-open', open);
    if (toggle) {
      toggle.setAttribute('aria-expanded', String(open));
      toggle.setAttribute('aria-label', open ? 'Menü schließen' : 'Menü öffnen');
    }
  };
  toggle?.addEventListener('click', () => setNav(!body.classList.contains('nav-open')));
  nav?.addEventListener('click', (e) => { if (e.target.closest('a')) setNav(false); });
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape') setNav(false); });

  // Active nav link while scrolling
  const links = nav ? [...nav.querySelectorAll('a[href^="#"]')] : [];
  const sections = links.map((a) => document.querySelector(a.getAttribute('href'))).filter(Boolean);
  if ('IntersectionObserver' in window && sections.length) {
    const spy = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        links.forEach((a) => a.classList.toggle('is-active', a.getAttribute('href') === '#' + entry.target.id));
      });
    }, { rootMargin: '-45% 0px -50% 0px' });
    sections.forEach((s) => spy.observe(s));
  }

  // Product filter
  const tabs = [...document.querySelectorAll('.tab[data-filter]')];
  const cards = [...document.querySelectorAll('.product-card[data-cat]')];
  tabs.forEach((tab) => tab.addEventListener('click', () => {
    const filter = tab.dataset.filter;
    tabs.forEach((t) => t.setAttribute('aria-selected', String(t === tab)));
    cards.forEach((card) => { card.hidden = filter !== 'all' && card.dataset.cat !== filter; });
  }));

  // Reveal on scroll
  const reveals = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    const io = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) { entry.target.classList.add('is-visible'); io.unobserve(entry.target); }
      });
    }, { threshold: 0.12 });
    reveals.forEach((el) => io.observe(el));
  } else {
    reveals.forEach((el) => el.classList.add('is-visible'));
  }

  // Static site: forms open the visitor's mail client with a prefilled message
  const openMail = (subject, text) => {
    window.location.href = `mailto:${EMAIL}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(text)}`;
  };

  document.getElementById('dealer-form')?.addEventListener('submit', (e) => {
    e.preventDefault();
    const plz = e.target.plz.value.trim();
    if (!e.target.checkValidity()) { e.target.reportValidity(); return; }
    openMail(`Händleranfrage PLZ ${plz}`,
      `Guten Tag,\n\nbitte nennen Sie mir einen Brantho-Korrux Händler in der Nähe der Postleitzahl ${plz}.\n\nVielen Dank!`);
  });

  const form = document.getElementById('contact-form');
  const note = document.getElementById('form-note');
  form?.addEventListener('submit', (e) => {
    e.preventDefault();
    if (!form.checkValidity()) {
      form.reportValidity();
      return;
    }
    const d = new FormData(form);
    const lines = [
      d.get('message'),
      '',
      '—',
      `Name: ${d.get('name')}`,
      d.get('company') ? `Firma: ${d.get('company')}` : null,
      `E-Mail: ${d.get('email')}`,
      d.get('phone') ? `Telefon: ${d.get('phone')}` : null,
    ].filter((l) => l !== null);
    openMail(`Anfrage: ${d.get('topic')}`, lines.join('\n'));
    if (note) {
      note.textContent = 'Ihr E-Mail-Programm wurde mit Ihrer Nachricht geöffnet. Vielen Dank!';
      note.classList.add('is-success');
    }
  });

  // Current year
  document.querySelectorAll('[data-year]').forEach((el) => { el.textContent = new Date().getFullYear(); });
})();
