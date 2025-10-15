// Usage:
//
//  <table-of-content title="On this page" items="<%%= @resource.table_of_content.to_json %>" active-classes="toc__item--highlight">
//    <template type="title">
//      <p>On this page (use this to have more control over the title element)</p>
//    </template>
//  </table-of-content>
//
class TableOfContentElement extends HTMLElement {
  constructor() {
    super();

    this.#items = JSON.parse(this.getAttribute("items"));
  }

  connectedCallback() {
    if (this.#items.length < 1) return

    this.innerHTML = this.#template;
    this.#highlightActiveLink();
  }

  // private

  #items;

  get #template() {
    return `
      <nav>
        ${this.#leader}

        ${this.#list( { for: this.#items })}
      </nav>
    `;
  }

  #list({ for: items }) {
    if (!items?.length) return "";

    const listItems = items.map(item => `
      <li>
        <a href="#${item.id}">
          ${item.text}
        </a>

        ${this.#list({ for: item.children })}
      </li>
    `).join("");

    return `<ul>${listItems}</ul>`;
  }

  #highlightActiveLink() {
    if (!this.#activeClasses) return;

    const selector = "a[href^='#']";
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(({ isIntersecting, target }) => {
        if (!isIntersecting) return;

        this.querySelectorAll(selector).forEach(link => link.classList.remove(...this.#activeClasses));
        this.querySelector(`a[href="#${target.id}"]`)?.classList.add(...this.#activeClasses);
      });
    }, { rootMargin: "0px 0px -80% 0px", threshold: 0 });

    this.querySelectorAll(selector).forEach(({ hash }) => {
      const element = document.getElementById(hash.slice(1));

      if (element) observer.observe(element);
    });

    this.querySelector(selector)?.classList.add(...this.#activeClasses);
  }

  get #leader() {
    return this.querySelector("template[type=title]")?.innerHTML || `<p>${this.getAttribute("title") || "Table of Content"}</p>`;
  }

  get #activeClasses() {
    return this.getAttribute("active-classes")?.split(" ");
  }
}

customElements.define("table-of-content", TableOfContentElement);
