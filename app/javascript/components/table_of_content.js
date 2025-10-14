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
      <nav class="
        flex fixed top-11 right-0 flex-col gap-y-2.5 max-w-xs bg-white/80 border-slate-200/50 rounded-bl-md backdrop-blur-sm lg:right-auto
        max-lg:p-2 max-lg:border-b max-lg:border-l max-lg:shadow-lg
      ">
        ${this.querySelector("template[type=title]")?.innerHTML || `<p>${this.getAttribute("title") || "Table of Content"}</p>`}

        ${this.#list( { for: this.#items })}
      </nav>
    `;
  }

  #list({ for: items }) {
    if (!items?.length) return "";

    const listItems = items.map(item => `
      <li>
        <a href="#${item.id}" class="block w-full text-sm font-normal text-slate-800 [ul>li>ul_&]:text-slate-500 hover:text-slate-900">
          ${item.text}
        </a>

        ${this.#list({ for: item.children })}
      </li>
    `).join("");

    return `<ul class="grid gap-y-2.5 [li>&]:ml-3 [li>&]:mt-1.5">${listItems}</ul>`;
  }
}

customElements.define("table-of-content", TableOfContentElement);
