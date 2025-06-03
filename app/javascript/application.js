// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


import "popper"
import "bootstrap"
import "trix"
import "@rails/actiontext"


document.addEventListener("turbo:load", () => {
  // Inicializa todos os elementos com data-bs-toggle="dropdown"
  const dropdownElementList = document.querySelectorAll('[data-bs-toggle="dropdown"]');
  dropdownElementList.forEach((dropdownToggleEl) => {
    new bootstrap.Dropdown(dropdownToggleEl);
  });
});

// Função para inicializar os componentes do Bootstrap
function initializeBootstrapComponents() {
  // Inicializa Dropdowns
  document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach(dropdownToggleEl => {
    bootstrap.Dropdown.getOrCreateInstance(dropdownToggleEl); // Usa getOrCreateInstance para evitar duplicatas
  });

  // Inicializa Modais
  document.querySelectorAll('[data-bs-toggle="modal"]').forEach(modalToggleEl => {
    bootstrap.Modal.getOrCreateInstance(modalToggleEl); // Inicializa ou obtém a instância existente
  });

  // Inicializa Tooltips (se estiver usando)
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(tooltipTriggerEl => {
    bootstrap.Tooltip.getOrCreateInstance(tooltipTriggerEl);
  });

  // Inicializa Popovers (se estiver usando)
  document.querySelectorAll('[data-bs-toggle="popover"]').forEach(popoverTriggerEl => {
    bootstrap.Popover.getOrCreateInstance(popoverTriggerEl);
  });
}

// Evento para inicializar componentes quando o Turbo Drive carrega uma página
document.addEventListener("turbo:load", initializeBootstrapComponents);

// Evento para inicializar componentes quando o Turbo Drive *renderiza* conteúdo (útil para Turbo Frames/Streams)
// Este evento é disparado *antes* do turbo:load para elementos dentro de frames/streams.
document.addEventListener("turbo:render", initializeBootstrapComponents);

// Opcional: Evento para destruir componentes quando o Turbo Drive remove uma página
// Isso é mais complexo e nem sempre necessário para modais, mas pode ajudar em casos específicos.
// document.addEventListener("turbo:before-render", () => {
//   document.querySelectorAll('.modal.show').forEach(modalEl => {
//     const modalInstance = bootstrap.Modal.getInstance(modalEl);
//     if (modalInstance) {
//       modalInstance.hide(); // Oculta o modal ativo antes da página ser removida
//       modalInstance.dispose(); // Destrói a instância do modal
//     }
//   });
// });
