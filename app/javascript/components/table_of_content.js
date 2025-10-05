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
      <nav class="fixed top-[3lh] flex flex-col gap-y-1.5">
        ${this.querySelector("template[type=title]")?.innerHTML || `<p>${this.getAttribute("title") || "Table of Content"}</p>`}

        ${this.#list( { for: this.#items })}
      </nav>
    `;
  }

  #list({ for: items }) {
    if (!items?.length) return "";

    const listItems = items.map(item => `
      <li>
        <a href="#${item.id}" class="block w-full text-sm font-normal text-slate-800 truncate [ul>li>ul_&]:text-slate-500 hover:text-slate-900">
          ${item.text}
        </a>

        ${this.#list({ for: item.children })}
      </li>
    `).join("");

    return `<ul class="grid gap-y-2.5 [li>&]:ml-3 [li>&]:mt-1.5">${listItems}</ul>`;
  }
}

customElements.define("table-of-content", TableOfContentElement);
