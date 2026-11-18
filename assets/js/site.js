// Theme toggle. The initial theme is set inline in <head> (_includes/theme-init.html).
(function () {
  var root = document.documentElement;
  var button = document.querySelector(".theme-toggle");
  var media = window.matchMedia("(prefers-color-scheme: dark)");

  function saved() { try { return localStorage.getItem("theme"); } catch (e) { return null; } }
  function apply(theme) {
    root.setAttribute("data-theme", theme);
    if (button) button.setAttribute("aria-label", theme === "dark" ? "Switch to light theme" : "Switch to dark theme");
  }

  apply(root.getAttribute("data-theme") || (media.matches ? "dark" : "light"));

  if (button) button.addEventListener("click", function () {
    var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
    try { localStorage.setItem("theme", next); } catch (e) {}
    apply(next);
  });

  // Follow the OS setting until the visitor makes an explicit choice.
  media.addEventListener("change", function (e) { if (!saved()) apply(e.matches ? "dark" : "light"); });
})();

// Accessibility touch-ups for Markdown output.
(function () {
  // Horizontally scrollable code blocks must be keyboard-focusable.
  document.querySelectorAll(".prose pre").forEach(function (pre) {
    if (pre.scrollWidth > pre.clientWidth) { pre.setAttribute("tabindex", "0"); }
  });
  // kramdown task-list checkboxes have no label; use the item's text.
  document.querySelectorAll(".prose .task-list-item-checkbox").forEach(function (box) {
    box.setAttribute("aria-label", box.parentNode.textContent.trim());
  });
})();
