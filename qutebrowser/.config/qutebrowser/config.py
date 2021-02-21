# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

config.load_autoconfig(False)

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {
    'wq': 'quit --save',
    'q': 'close',
    'w': 'session-save',
    'wqa': 'quit --save',
    'qa': 'quit',
    'mpv': 'spawn --userscript ~/.local/bin/view_in_mpv'
}

# This setting can be used to map keys to other keys. When the key used
# as dictionary-key is pressed, the binding for the key used as
# dictionary-value is invoked instead. This is useful for global
# remappings of keys, for example to map Ctrl-[ to Escape. Note that
# when a key is bound (via `bindings.default` or `bindings.commands`),
# the mapping is ignored.
# Type: Dict
c.bindings.key_mappings = {
    '<Shift-Return>': '<Return>',
    '<Ctrl-6>': '<Ctrl-^>',
    '<Enter>': '<Return>',
    '<Ctrl-M>': '<Return>',
    '<Ctrl-J>': '<Return>',
    '<Ctrl-[>': '<Escape>',
    '<Shift-Enter>': '<Return>',
    '<Ctrl-Enter>': '<Ctrl-Return>'
}

# Which method of blocking ads should be used.  Support for Adblock Plus
# (ABP) syntax blocklists using Brave's Rust library requires the
# `adblock` Python package to be installed, which is an optional
# dependency of qutebrowser. It is required when either `adblock` or
# `both` are selected.
# Type: String
# Valid values:
#   - auto: Use Brave's ABP-style adblocker if available, host blocking otherwise
#   - adblock: Use Brave's ABP-style adblocker
#   - hosts: Use hosts blocking
#   - both: Use both hosts blocking and Brave's ABP-style adblocker
c.content.blocking.method = 'adblock'

# List of user stylesheet filenames to use.
# Type: List of File, or File
c.content.user_stylesheets = []

# Where to show the downloaded files.
# Type: VerticalPosition
# Valid values:
#   - top
#   - bottom
c.downloads.position = 'top'

# Duration (in milliseconds) to wait before removing finished downloads.
# If set to -1, downloads are never removed.
# Type: Int
c.downloads.remove_finished = 300000

# Editor (and arguments) to use for the `edit-*` commands. The following
# placeholders are defined:  * `{file}`: Filename of the file to be
# edited. * `{line}`: Line in which the caret is found in the text. *
# `{column}`: Column in which the caret is found in the text. *
# `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
# Same as `{column}`, but starting from index 0.
# Type: ShellCommand
c.editor.command = [
    'i3-sensible-terminal', '-e', 'nvim -f {file} -c normal {line}G{column0}l'
]

# Handler for selecting file(s) in forms. If `external`, then the
# commands specified by `fileselect.single_file.command` and
# `fileselect.multiple_files.command` are used to select one or multiple
# files respectively.
# Type: String
# Valid values:
#   - default: Use the default file selector.
#   - external: Use an external command.
c.fileselect.handler = 'external'

# Command (and arguments) to use for selecting multiple files in forms.
# The command should write the selected file paths to the specified
# file, separated by newlines. The following placeholders are defined: *
# `{}`: Filename of the file to be written to.
# Type: ShellCommand
c.fileselect.single_file.command = [
    'floating_term', 'ranger', '--choosefile={}'
]

# Command (and arguments) to use for selecting a single file in forms.
# The command should write the selected file path to the specified file.
# The following placeholders are defined: * `{}`: Filename of the file
# to be written to.
# Type: ShellCommand
c.fileselect.multiple_files.command = [
    'floating_term', 'ranger', '--choosefiles={}'
]

# Characters used for hint strings.
# Type: UniqueCharString
c.hints.chars = 'asdfghjkl'

# When to find text on a page case-insensitively.
# Type: IgnoreCase
# Valid values:
#   - always: Search case-insensitively.
#   - never: Search case-sensitively.
#   - smart: Search case-sensitively if there are capital characters.
c.search.ignore_case = 'smart'

# Languages to use for spell checking. You can check for available
# languages and install dictionaries using scripts/dictcli.py. Run the
# script with -h/--help for instructions.
# Type: List of String
# Valid values:
#   - af-ZA: Afrikaans (South Africa)
#   - bg-BG: Bulgarian (Bulgaria)
#   - ca-ES: Catalan (Spain)
#   - cs-CZ: Czech (Czech Republic)
#   - da-DK: Danish (Denmark)
#   - de-DE: German (Germany)
#   - el-GR: Greek (Greece)
#   - en-AU: English (Australia)
#   - en-CA: English (Canada)
#   - en-GB: English (United Kingdom)
#   - en-US: English (United States)
#   - es-ES: Spanish (Spain)
#   - et-EE: Estonian (Estonia)
#   - fa-IR: Farsi (Iran)
#   - fo-FO: Faroese (Faroe Islands)
#   - fr-FR: French (France)
#   - he-IL: Hebrew (Israel)
#   - hi-IN: Hindi (India)
#   - hr-HR: Croatian (Croatia)
#   - hu-HU: Hungarian (Hungary)
#   - id-ID: Indonesian (Indonesia)
#   - it-IT: Italian (Italy)
#   - ko: Korean
#   - lt-LT: Lithuanian (Lithuania)
#   - lv-LV: Latvian (Latvia)
#   - nb-NO: Norwegian (Norway)
#   - nl-NL: Dutch (Netherlands)
#   - pl-PL: Polish (Poland)
#   - pt-BR: Portuguese (Brazil)
#   - pt-PT: Portuguese (Portugal)
#   - ro-RO: Romanian (Romania)
#   - ru-RU: Russian (Russia)
#   - sh: Serbo-Croatian
#   - sk-SK: Slovak (Slovakia)
#   - sl-SI: Slovenian (Slovenia)
#   - sq: Albanian
#   - sr: Serbian
#   - sv-SE: Swedish (Sweden)
#   - ta-IN: Tamil (India)
#   - tg-TG: Tajik (Tajikistan)
#   - tr-TR: Turkish (Turkey)
#   - uk-UA: Ukrainian (Ukraine)
#   - vi-VN: Vietnamese (Viet Nam)
c.spellcheck.languages = []

# Open new tabs (middleclick/ctrl+click) in the background.
# Type: Bool
c.tabs.background = False

# Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
# for a blank page.
# Type: FuzzyUrl
c.url.default_page = 'https://google.com'

# Search engines which can be used via the address bar. Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` signs. The search engine named
# `DEFAULT` is used when `url.auto_search` is turned on and something
# else than a URL was entered to be opened. Other search engines can be
# used by prepending the search engine name to the search term, e.g.
# `:open google qutebrowser`.
# Type: Dict
c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}'}

# Page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = ['https://google.com']

# Default zoom level.
# Type: Perc
c.zoom.default = '100%'

# Available zoom levels.
# Type: List of Perc
c.zoom.levels = [
    '25%', '33%', '50%', '67%', '75%', '90%', '100%', '110%', '125%', '150%',
    '175%', '200%', '250%', '300%', '400%', '500%'
]

config.bind('  q', 'tab-focus 1')
config.bind('  w', 'tab-focus 2')
config.bind('  e', 'tab-focus 3')
config.bind('  r', 'tab-focus 4')
config.bind('  t', 'tab-focus 5')
config.bind('  y', 'tab-focus 6')
config.bind('  u', 'tab-focus 7')
config.bind('  i', 'tab-focus 8')
config.bind('  o', 'tab-focus 9')
config.bind('  p', 'tab-focus -1')
CSS = '~/.config/qutebrowser/gruvbox-all-sites.css'
config.bind('sd', f'config-cycle content.user_stylesheets {CSS} ""')
config.bind('sz', 'config-cycle zoom.default 100% 67%')
config.bind('sj', 'config-cycle --print content.javascript.enabled true false')
BASE_SPAWN_FZF = 'spawn --userscript ~/.local/bin/floating_term'
config.bind(' o', BASE_SPAWN_FZF + ' fzf_qutebrowser_url')
config.bind(' O', BASE_SPAWN_FZF + ' fzf_qutebrowser_url -t')
config.bind(' c', BASE_SPAWN_FZF + ' fzf_qutebrowser_cmd')

# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# Gruvbox dark, hard scheme by
# Dawid Kurek (dawikur@gmail.com)
# morhetz (https://github.com/morhetz/gruvbox)

base00 = "#1d2021"
base01 = "#3c3836"
base02 = "#504945"
base03 = "#665c54"
base04 = "#bdae93"
base05 = "#d5c4a1"
base06 = "#ebdbb2"
base07 = "#fbf1c7"
base08 = "#fb4934"
base09 = "#fe8019"
base0A = "#fabd2f"
base0B = "#b8bb26"
base0C = "#8ec07c"
base0D = "#83a598"
base0E = "#d3869b"
base0F = "#d65d0e"

c.colors.completion.fg = base05
c.colors.completion.odd.bg = base03
c.colors.completion.even.bg = base00
c.colors.completion.category.fg = base0A
c.colors.completion.category.bg = base00
c.colors.completion.category.border.top = base00
c.colors.completion.category.border.bottom = base00
c.colors.completion.item.selected.fg = base01
c.colors.completion.item.selected.bg = base0A
c.colors.completion.item.selected.border.top = base0A
c.colors.completion.item.selected.border.bottom = base0A
c.colors.completion.match.fg = base0B
c.colors.completion.scrollbar.fg = base05
c.colors.completion.scrollbar.bg = base00
c.colors.downloads.bar.bg = base00
c.colors.downloads.start.fg = base00
c.colors.downloads.start.bg = base0D
c.colors.downloads.stop.fg = base00
c.colors.downloads.stop.bg = base0C
c.colors.downloads.error.fg = base08
c.colors.hints.fg = base00
c.colors.hints.bg = base0A
c.colors.hints.match.fg = base05
c.colors.keyhint.fg = base05
c.colors.keyhint.suffix.fg = base05
c.colors.keyhint.bg = base00
c.colors.messages.error.fg = base00
c.colors.messages.error.bg = base08
c.colors.messages.error.border = base08
c.colors.messages.warning.fg = base00
c.colors.messages.warning.bg = base0E
c.colors.messages.warning.border = base0E
c.colors.messages.info.fg = base05
c.colors.messages.info.bg = base00
c.colors.messages.info.border = base00
c.colors.prompts.fg = base05
c.colors.prompts.border = base00
c.colors.prompts.bg = base00
c.colors.prompts.selected.bg = base0A
c.colors.statusbar.normal.fg = base0B
c.colors.statusbar.normal.bg = base00
c.colors.statusbar.insert.fg = base00
c.colors.statusbar.insert.bg = base0D
c.colors.statusbar.passthrough.fg = base00
c.colors.statusbar.passthrough.bg = base0C
c.colors.statusbar.private.fg = base00
c.colors.statusbar.private.bg = base03
c.colors.statusbar.command.fg = base05
c.colors.statusbar.command.bg = base00
c.colors.statusbar.command.private.fg = base05
c.colors.statusbar.command.private.bg = base00
c.colors.statusbar.caret.fg = base00
c.colors.statusbar.caret.bg = base0E
c.colors.statusbar.caret.selection.fg = base00
c.colors.statusbar.caret.selection.bg = base0D
c.colors.statusbar.progress.bg = base0D
c.colors.statusbar.url.fg = base05
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.hover.fg = base05
c.colors.statusbar.url.success.http.fg = base0C
c.colors.statusbar.url.success.https.fg = base0B
c.colors.statusbar.url.warn.fg = base0E
c.colors.tabs.bar.bg = base00
c.colors.tabs.indicator.start = base0D
c.colors.tabs.indicator.stop = base0C
c.colors.tabs.indicator.error = base08
c.colors.tabs.odd.fg = base05
c.colors.tabs.odd.bg = base03
c.colors.tabs.even.fg = base05
c.colors.tabs.even.bg = base00
c.colors.tabs.selected.odd.fg = base00
c.colors.tabs.selected.odd.bg = base05
c.colors.tabs.selected.even.fg = base00
c.colors.tabs.selected.even.bg = base05
