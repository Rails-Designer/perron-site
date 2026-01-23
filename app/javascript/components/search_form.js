import MiniSearch from "minisearch"
import { excerpt, highlight } from "helpers/search"

export default class SearchForm extends HTMLElement {
  connectedCallback() {
    this.debounceTimeout = null
    this.selectedIndex = -1

    this.#resultsContainer.setAttribute("hidden", "")

    this.#input.addEventListener("focus", () => this.#initialize())
    if (!this.#submitButton) {
      this.#input.addEventListener("input", (event) => this.#debounce(event.target.value))
    } else {
      this.#submitButton.addEventListener("click", (event) => {
        event.preventDefault()

        this.#search(this.#input.value)
      })
    }
    this.#input.addEventListener("keydown", (event) => this.#navigate(event))

    document.addEventListener("click", (event) => this.#closeOnClickOutside(event))

    if (this.hasAttribute("shortcut-key")) this.#setupShortcut()
  }

  disconnectedCallback() {
    document.removeEventListener("click", (event) => this.#closeOnClickOutside(event))

    if (this.debounceTimeout) clearTimeout(this.debounceTimeout)
  }

  // private

  async #initialize() {
    if (this.index) return

    this.setAttribute("aria-busy", "true")

    try {
      const response = await fetch(this.#searchEndpoint)
      this.index = await response.json()
      this.miniSearch = new MiniSearch(this.#config)

      this.miniSearch.addAll(this.index)
    } catch (error) {
      console.error("Failed to load search index:", error)
    } finally {
      this.removeAttribute("aria-busy")
    }
  }

  #debounce(query) {
    if (this.debounceTimeout) clearTimeout(this.debounceTimeout)

    this.debounceTimeout = setTimeout(() => this.#search(query), 150)
  }

  #navigate(event) {
    if (!this.#resultsContainer.hasAttribute("open")) return

    const results = this.#resultsContainer.querySelectorAll("li a")
    if (results.length === 0) return

    switch (event.key) {
      case "ArrowDown":
        event.preventDefault()

        this.selectedIndex = Math.min(this.selectedIndex + 1, results.length - 1)
        this.#updateSelection(results)

        break
      case "ArrowUp":
        event.preventDefault()

        this.selectedIndex = Math.max(this.selectedIndex - 1, -1)
        this.#updateSelection(results)

        break
      case "Enter":
        event.preventDefault()

        if (this.selectedIndex >= 0) results[this.selectedIndex].click()

        break
      case "Escape":
        event.preventDefault()

        this.#close()

        break
    }
  }

  #closeOnClickOutside(event) {
    if (!this.contains(event.target)) this.#close()
  }

  async #setupShortcut() {
    try {
      const imported = await import("tinykeys")
      const tinykeys = imported.default || imported.tinykeys || imported

      this.unsubscribe = tinykeys(window, {
        [this.getAttribute("shortcut-key")]: (event) => {
          event.preventDefault()

          this.#input.focus()
        }
      })
    } catch {}
  }

  #search(query) {
    if (query.trim().length < 2) {
      this.#close()

      return
    }

    const results = this.miniSearch.search(query)
    this.#render(results, query)
  }

  #close() {
    this.#resultsContainer.innerHTML = ""

    this.#hide();
    this.removeAttribute("data-results-count")
  }

  #render(results, query = "") {
    this.selectedIndex = -1

    if (results.length === 0) {
      this.#renderEmpty()

      return
    }

    const groupBy = this.getAttribute("group-by")
    const html = groupBy ? this.#renderGrouped(results, groupBy, query) : results.map(result => this.#renderItem(result, query)).join("")

    this.#resultsContainer.innerHTML = html

    this.#resultsContainer.querySelectorAll("li a").forEach(link => {
      link.addEventListener("mouseenter", () => {
        this.selectedIndex = -1

        this.#resultsContainer.querySelectorAll("li[data-selected]").forEach(item => item.removeAttribute("data-selected"))
      })
    })

    this.setAttribute("data-results-count", results.length)
    this.#show()
  }

  #renderEmpty() {
    this.#resultsContainer.innerHTML = `<p data-slot="empty-message">${this.#emptyMessage}</p>`

    this.setAttribute("data-results-count", "0")
    this.#show()
  }

  #renderGrouped(results, groupBy, query) {
    const grouped = results.reduce((group, result) => {
      const key = result[groupBy] || "Other"

      if (!group[key]) {
        group[key] = []
      }

      group[key].push(result)

      return group
    }, {})

    return Object.entries(grouped).map(([group, items]) => `
      <li data-slot="group">
        <h6 data-group-label>${group}</h6>

        <ul data-slot="items">
          ${items.map(result => this.#renderItem(result, query)).join("")}
        </ul>
      </li>
    `).join("")
  }

  #renderItem(result, query) {
    return `
      <li data-slot="item">
        <a href="${result.href}">
          <h5>${highlight(result.title, query)}</h5>

          <p>${highlight(excerpt(result.body, query), query)}</p>
        </a>
      </li>
    `
  }

  #updateSelection(results) {
    results.forEach((result, index) => {
      const listItem = result.closest("li")

      if (index === this.selectedIndex) {
        listItem.setAttribute("data-selected", "")
        listItem.scrollIntoView({ block: "nearest" })
      } else {
        listItem.removeAttribute("data-selected")
      }
    })
  }

  #show() {
    this.#resultsContainer.removeAttribute("hidden")
    this.#resultsContainer.setAttribute("open", "")
  }

  #hide() {
    this.#resultsContainer.removeAttribute("open")
    this.#resultsContainer.setAttribute("hidden", "")
  }

  get #config() {
    const defaults = {
      fields: ["title", "headings", "body"],
      idField: "slug",
      storeFields: ["title", "body", "href", "slug"],
      searchOptions: {
        prefix: true,
        boost: { title: 30, headings: 20 },
        combineWith: "and",
        fuzzy: true
      }
    }

    const customConfig = this.getAttribute("config")
    if (!customConfig) return defaults

    const parsed = JSON.parse(customConfig)

    return {
      ...defaults,
      ...parsed,
      fields: parsed.fields || defaults.fields,
      storeFields: [...new Set([...defaults.storeFields, ...(parsed.storeFields || [])])],
      searchOptions: {
        ...defaults.searchOptions,
        ...parsed.searchOptions,
        boost: {
          ...defaults.searchOptions.boost,
          ...parsed.searchOptions?.boost
        }
      }
    }
  }

  get #input() {
    return this.querySelector("input[type='search']")
  }

  get #submitButton() {
    return this.querySelector("button[type='submit']")
  }

  get #resultsContainer() {
    return this.querySelector("[data-slot='results']")
  }

  get #searchEndpoint() {
    return this.getAttribute("endpoint")
  }

  get #emptyMessage() {
    return this.getAttribute("empty-message") || "No results found"
  }
}

customElements.define("search-form", SearchForm)
