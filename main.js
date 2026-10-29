// Ebio Cosmetic - Interactive Client Scripts

document.addEventListener('DOMContentLoaded', () => {
  // Initialize Lucide Icons
  if (window.lucide) {
    window.lucide.createIcons();
  }

  // 1. Mobile Menu Toggle
  const mobileBtn = document.getElementById('mobileMenuBtn');
  const mobileMenu = document.getElementById('mobileMenu');
  const mobileLinks = document.querySelectorAll('.mobile-link');

  if (mobileBtn && mobileMenu) {
    mobileBtn.addEventListener('click', () => {
      mobileMenu.classList.toggle('hidden');
    });

    mobileLinks.forEach(link => {
      link.addEventListener('click', () => {
        mobileMenu.classList.add('hidden');
      });
    });
  }

  // 2. Product Category Filter
  const filterBtns = document.querySelectorAll('.filter-btn');
  const productCards = document.querySelectorAll('.product-card');

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const category = btn.getAttribute('data-category');

      // Update active button UI
      filterBtns.forEach(b => {
        b.classList.remove('active', 'bg-amazonia', 'text-white');
        b.classList.add('text-tierra/70');
      });
      btn.classList.add('active', 'bg-amazonia', 'text-white');
      btn.classList.remove('text-tierra/70');

      // Filter cards
      productCards.forEach(card => {
        const cardCategory = card.getAttribute('data-category');
        if (category === 'all' || cardCategory === category) {
          card.classList.remove('hidden');
        } else {
          card.classList.add('hidden');
        }
      });
    });
  });

  // 3. Product Details Modal
  const modal = document.getElementById('productModal');
  const openModalBtns = document.querySelectorAll('.open-modal-btn');
  const closeModalBtn = document.getElementById('closeModalBtn');
  const modalCloseActionBtn = document.getElementById('modalCloseActionBtn');

  const modalTitle = document.getElementById('modalTitle');
  const modalSubtitle = document.getElementById('modalSubtitle');
  const modalOrigin = document.getElementById('modalOrigin');
  const modalDesc = document.getElementById('modalDesc');
  const modalIngredients = document.getElementById('modalIngredients');
  const modalUsage = document.getElementById('modalUsage');
  const modalWhatsAppBtn = document.getElementById('modalWhatsAppBtn');

  function openModal(data) {
    modalTitle.textContent = data.title;
    modalSubtitle.textContent = data.subtitle;
    modalOrigin.textContent = data.origin;
    modalDesc.textContent = data.desc;
    modalIngredients.textContent = data.ingredients;
    modalUsage.textContent = data.usage;

    const message = encodeURIComponent(`Hola Ebio Cosmetic, me gustaría consultar y hacer un pedido de: ${data.title} (${data.subtitle})`);
    modalWhatsAppBtn.href = `https://wa.me/?text=${message}`;

    modal.classList.remove('hidden');
    setTimeout(() => {
      modal.classList.add('modal-open');
    }, 10);
  }

  function closeModal() {
    modal.classList.remove('modal-open');
    setTimeout(() => {
      modal.classList.add('hidden');
    }, 300);
  }

  openModalBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const data = {
        title: btn.getAttribute('data-title'),
        subtitle: btn.getAttribute('data-subtitle'),
        origin: btn.getAttribute('data-origin'),
        desc: btn.getAttribute('data-desc'),
        ingredients: btn.getAttribute('data-ingredients'),
        usage: btn.getAttribute('data-usage')
      };
      openModal(data);
    });
  });

  if (closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
  if (modalCloseActionBtn) modalCloseActionBtn.addEventListener('click', closeModal);

  if (modal) {
    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        closeModal();
      }
    });
  }

  // 4. FAQ Accordion
  const faqButtons = document.querySelectorAll('.faq-btn');

  faqButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const content = btn.nextElementSibling;
      const isOpen = !content.classList.contains('hidden');

      // Close all first
      document.querySelectorAll('.faq-content').forEach(c => c.classList.add('hidden'));
      document.querySelectorAll('.faq-btn').forEach(b => b.classList.remove('active'));

      // Toggle clicked if it was closed
      if (!isOpen) {
        content.classList.remove('hidden');
        btn.classList.add('active');
      }
    });
  });

  // 5. WhatsApp Order Form Submitter
  const orderForm = document.getElementById('orderForm');
  if (orderForm) {
    orderForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const name = document.getElementById('userName').value.trim();
      const city = document.getElementById('userCity').value.trim();
      const product = document.getElementById('productSelection').value;
      const message = document.getElementById('userMessage').value.trim();

      let text = `🌿 *Nuevo Pedido / Consulta - Ebio Cosmetic*\n\n`;
      text += `👤 *Nombre:* ${name}\n`;
      text += `📍 *Ciudad / Destino:* ${city}\n`;
      text += `🧼 *Producto seleccionado:* ${product}\n`;
      if (message) {
        text += `💬 *Detalle:* ${message}\n`;
      }
      text += `\n_Enviado desde la página web de Ebio Cosmetic_`;

      const encodedText = encodeURIComponent(text);
      window.open(`https://wa.me/?text=${encodedText}`, '_blank');
    });
  }

  // 6. Smooth Navbar background on scroll
  const navbar = document.getElementById('navbar');
  window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
      navbar.classList.add('shadow-sm');
    } else {
      navbar.classList.remove('shadow-sm');
    }
  });
});
