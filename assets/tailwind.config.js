// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/realtime_chat_web.ex",
    "../lib/realtime_chat_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        gruvboxDark: {
          bg: "#282828",
          bg0: "#282828",
          bgH: "#1d2021",
          bgS: "#32302f",
          bg1: "#3c3836",
          bg2: "#504945",
          bg3: "#665c54",
          bg4: "#7c6f64",

          fg: "#ebdbb2",
          fg0: "#fbf1c7",
          fg1: "#ebdbb2",
          fg2: "#d5c4a1",
          fg3: "#bdae93",
          fg4: "#a89984",

          red: "#cc241d",
          red2: "#fb4934",
          green: "#98971a",
          green2: "#b8bb26",
          yellow: "#d79921",
          yellow2: "#fabd2f",
          blue: "#458588",
          blue2: "#83a598",
          purple: "#b16286",
          purple2: "#d3869b",
          aqua: "#689d6a",
          aqua2: "#8ec07c",
          orange: "#d65d0e",
          orange2: "#fe8019",
          gray: "#a89984",
          gray2: "#928374"
        },
        gruvbox: {
          bg: "#fbf1c7",
          bg0: "#fbf1c7",
          bgH: "#f9f5d7",
          bgS: "#f2e5bc",
          bg1: "#ebdbb2",
          bg2: "#d5c4a1",
          bg3: "#bdae93",
          bg4: "#a89984",

          fg: "#3c3836",
          fg0: "#282828",
          fg1: "#3c3836",
          fg2: "#504945",
          fg3: "#665c54",
          fg4: "#7c6f64",

          red: "#cc241d",
          red2: "#9d0006",
          green: "#98971a",
          green2: "#79740e",
          yellow: "#d79921",
          yellow2: "#b57614",
          blue: "#458588",
          blue2: "#076678",
          purple: "#b16286",
          purple2: "#8f3f71",
          aqua: "#689d6a",
          aqua2: "#427b58",
          orange: "#d65d0e",
          orange2: "#af3a03",
          gray: "#7c6f64",
          gray2: "#928374"
        }
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function ({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
        })
      })
      matchComponents({
        "hero": ({ name, fullPath }) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, { values })
    })
  ]
}
