// Usage:
//
//  <table-of-content title="On this page" items="<%%= @resource.table_of_content.to_json %>">
//    <template type="title">
//      <p>On this page</p>
//    </template>
//  </table-of-content>
//
class TableOfContentElement extends HTMLElement {
  constructor() {
    super();

    this.#items = JSON.parse(this.getAttribute("items"));
  }

  connectedCallback() {
    if (this.#items.length > 0) this.innerHTML = this.#template;
  }

  // private

  #items;

  get #template() {
    return `
      <nav>
        ${this.querySelector("template[type=title]")?.innerHTML || `<p>${this.getAttribute("title") || "Table of Content"}</p>`}

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
}

customElements.define("table-of-content", TableOfContentElement);
