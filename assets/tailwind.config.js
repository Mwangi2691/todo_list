// Tailwind CSS Configuration with Dark Theme
const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/todo_list_web.ex",
    "../lib/todo_list_web/**/*.*ex",
  ],
  darkMode: "class", // Enables dark mode via `class="dark"`
  theme: {
    extend: {
      colors: {
        brand: "#FD4F00",     // Accent color (orange)
        background: "#0D0D0D", // Dark background
        surface: "#1A1A1A",    // Slightly lighter panels
        text: "#FFFFFF",       // White text
        muted: "#888888",      // Muted gray text
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),

    // LiveView loading states
    plugin(({ addVariant }) => {
      addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])
    }),
    plugin(({ addVariant }) => {
      addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])
    }),
    plugin(({ addVariant }) => {
      addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])
    }),

    // Heroicons integration
    plugin(function ({ matchComponents, theme }) {
      const iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      const values = {}

      const icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"],
      ]

      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          const name = path.basename(file, ".svg") + suffix
          values[name] = {
            name,
            fullPath: path.join(iconsDir, dir, file),
          }
        })
      })

      matchComponents(
        {
          hero: ({ name, fullPath }) => {
            const content = fs.readFileSync(fullPath, "utf8").replace(/\r?\n|\r/g, "")
            let size = theme("spacing.6")

            if (name.endsWith("-mini")) {
              size = theme("spacing.5")
            } else if (name.endsWith("-micro")) {
              size = theme("spacing.4")
            }

            return {
              [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
              "-webkit-mask": `var(--hero-${name})`,
              mask: `var(--hero-${name})`,
              "mask-repeat": "no-repeat",
              "background-color": "currentColor",
              "vertical-align": "middle",
              display: "inline-block",
              width: size,
              height: size,
            }
          },
        },
        { values }
      )
    }),
  ],
}
