---
name: flowbite-svelte
description: Flowbite Svelte component documentation lookup. MUST be used whenever creating or editing UI components that use Flowbite Svelte. Fetch component docs before writing any Flowbite component code.
---

# Flowbite Svelte Documentation

## How to Use

Flowbite Svelte provides LLM-optimized documentation at predictable URLs. Before writing or editing any component that uses Flowbite Svelte, fetch the relevant docs.

### URL Pattern

All docs follow: `https://flowbite-svelte.com/llm/{category}/{component}.md`

### Available Components

**Components** (`components/`):
accordion, alert, avatar, badge, banner, bottom-navigation, breadcrumb, button-group, buttons, card, carousel, clipboard, darkmode, datepicker, device-mockups, drawer, dropdown, footer, forms, gallery, indicators, kbd, list-group, mega-menu, modal, navbar, pagination, popover, progress, rating, sidebar, skeleton, speed-dial, spinner, stepper, table, tabs, timeline, toast, tooltip, typography, video

**Forms** (`forms/`):
checkbox, file-input, floating-label, input-field, number-input, phone-input, radio, range, search-input, select, textarea, timepicker, toggle

**Extended** (`extended/`):
button-toggle, clipboard-manager, command-palette, kanban-board, progress-radial, scroll-spy, split-pane, step-indicator, tags, tour, virtual-list, virtual-masonry

**Plugins** (`plugins/`):
charts, datatables, wysiwyg

**Pages** (`pages/`):
colors, customization, quickstart, theme-provider, typescript

**Typography** (`typography/`):
blockquote, heading, hr, image, link, list, paragraph, text

**Utilities** (`utilities/`):
close-button, label, toolbar

### Workflow

1. **Before writing a Flowbite component**: Fetch the relevant doc page using WebFetch
   - Example: `WebFetch("https://flowbite-svelte.com/llm/components/modal.md", "Return the full component API, props, and usage examples")`
2. **Multiple components**: Fetch docs for each component you plan to use
3. **Theming**: Fetch `pages/theme-provider.md` and `pages/colors.md` for customization
4. **Setup questions**: Fetch `pages/quickstart.md`

### Key Facts (no lookup needed)

- Import from `flowbite-svelte`: `import { Button, Card, Modal } from 'flowbite-svelte'`
- Import icons from `flowbite-svelte-icons`: `import { ArrowRightOutline } from 'flowbite-svelte-icons'`
- Uses Svelte 5 runes (`$props()`, `$state`, `$derived`)
- Requires Tailwind CSS 4
- Props use `color`, `size`, `class` conventions
- Dark mode via class strategy: `@custom-variant dark (&:where(.dark, .dark *))`
- Snippets use `{#snippet name()}...{/snippet}` pattern for slots (Svelte 5)
