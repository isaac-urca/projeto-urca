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