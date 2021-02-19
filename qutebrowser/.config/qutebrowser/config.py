# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

config.load_autoconfig(False)

## Aliases for commands. The keys of the given dictionary are the
## aliases, while the values are the commands they map to.
## Type: Dict
c.aliases = {
    'wq': 'quit --save',
    'q': 'close',
    'w': 'session-save',
    'wqa': 'quit --save',
    'qa': 'quit',
    'mpv': 'spawn --userscript ~/.local/bin/view_in_mpv'
}

## Time interval (in milliseconds) between auto-saves of
## config/cookies/etc.
## Type: Int
c.auto_save.interval = 15000

## Always restore open sites when qutebrowser is reopened.
## Type: Bool
c.auto_save.session = False

## This setting can be used to map keys to other keys. When the key used
## as dictionary-key is pressed, the binding for the key used as
## dictionary-value is invoked instead. This is useful for global
## remappings of keys, for example to map Ctrl-[ to Escape. Note that
## when a key is bound (via `bindings.default` or `bindings.commands`),
## the mapping is ignored.
## Type: Dict
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

## Height (in pixels or as percentage of the window) of the completion.
## Type: PercOrInt
c.completion.height = '50%'

## Minimum amount of characters needed to update completions.
## Type: Int
c.completion.min_chars = 1

## Move on to the next part when there's only one possible completion
## left.
## Type: Bool
c.completion.quick = True

## When to show the autocompletion window.
## Type: String
## Valid values:
##   - always: Whenever a completion is available.
##   - auto: Whenever a completion is requested.
##   - never: Never.
c.completion.show = 'always'

## Format of timestamps (e.g. for the history completion).
## Type: TimestampTemplate
c.completion.timestamp_format = '%Y-%m-%d'

## Execute the best-matching command on a partial match.
## Type: Bool
c.completion.use_best_match = False

## A list of patterns which should not be shown in the history. This only
## affects the completion. Matching URLs are still saved in the history
## (and visible on the qute://history page), but hidden in the
## completion. Changing this setting will cause the completion history to
## be regenerated on the next start, which will take a short while.
## Type: List of UrlPattern
c.completion.web_history.exclude = []

## Number of URLs to show in the web history. 0: no history / -1:
## unlimited
## Type: Int
c.completion.web_history.max_items = -1

## Require a confirmation before quitting the application.
## Type: ConfirmQuit
## Valid values:
##   - always: Always show a confirmation.
##   - multiple-tabs: Show a confirmation if multiple tabs are opened.
##   - downloads: Show a confirmation if downloads are running
##   - never: Never show a confirmation.
c.confirm_quit = ['never']

## Maximum number of pages to hold in the global memory page cache. The
## page cache allows for a nicer user experience when navigating forth or
## back to pages in the forward/back history, by pausing and resuming up
## to _n_ pages. For more information about the feature, please refer to:
## http://webkit.org/blog/427/webkit-page-cache-i-the-basics/
## Type: Int
c.content.cache.maximum_pages = 0

## Size (in bytes) of the HTTP network cache. Null to use the default
## value. With QtWebEngine, the maximum supported value is 2147483647 (~2
## GB).
## Type: Int
c.content.cache.size = None

## Allow websites to request geolocations.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
c.content.geolocation = 'ask'

## Custom headers for qutebrowser HTTP requests.
## Type: Dict
c.content.headers.custom = {}

c.content.blocking.method = 'adblock'

## Allow JavaScript to read from or write to the clipboard. With
## QtWebEngine, writing the clipboard as response to a user interaction
## is always allowed.
## Type: Bool
c.content.javascript.can_access_clipboard = True

## Allow pdf.js to view PDF files in the browser. Note that the files can
## still be downloaded by clicking the download button in the pdf.js
## viewer.
## Type: Bool
c.content.pdfjs = False

## Enable plugins in Web pages.
## Type: Bool
c.content.plugins = False

## Open new windows in private browsing mode which does not record
## visited pages.
## Type: Bool
c.content.private_browsing = False

## Proxy to use. In addition to the listed values, you can use a
## `socks://...` or `http://...` URL.
## Type: Proxy
## Valid values:
##   - system: Use the system wide proxy.
##   - none: Don't use any proxy
c.content.proxy = 'system'

## Send DNS requests over the configured proxy.
## Type: Bool
c.content.proxy_dns_requests = True

## List of user stylesheet filenames to use.
## Type: List of File, or File
c.content.user_stylesheets = []
c.content.cookies.accept = 'all'

c.downloads.position = 'top'
c.downloads.remove_finished = 300000
c.editor.command = [
    'i3-sensible-terminal', '-e', 'nvim -f {file} -c normal {line}G{column0}l'
]

## Encoding to use for the editor.
## Type: Encoding
c.editor.encoding = 'utf-8'

## When a hint can be automatically followed without pressing Enter.
## Type: String
## Valid values:
##   - always: Auto-follow whenever there is only a single hint on a page.
##   - unique-match: Auto-follow whenever there is a unique non-empty match in either the hint string (word mode) or filter (number mode).
##   - full-match: Follow the hint when the user typed the whole hint (letter, word or number mode) or the element's text (only in number mode).
##   - never: The user will always need to press Enter to follow a hint.
c.hints.auto_follow = 'unique-match'

## Duration (in milliseconds) to ignore normal-mode key bindings after a
## successful auto-follow.
## Type: Int
c.hints.auto_follow_timeout = 0

## Characters used for hint strings.
## Type: UniqueCharString
c.hints.chars = 'adfjklgh'

## Dictionary file to be used by the word hints.
## Type: File
c.hints.dictionary = '/usr/share/dict/words'

## Which implementation to use to find elements to hint.
## Type: String
## Valid values:
##   - javascript: Better but slower
##   - python: Slightly worse but faster
c.hints.find_implementation = 'python'

## Hide unmatched hints in rapid mode.
## Type: Bool
c.hints.hide_unmatched_rapid_hints = True

## Minimum number of characters used for hint strings.
## Type: Int
c.hints.min_chars = 1

## Mode to use for hints.
## Type: String
## Valid values:
##   - number: Use numeric hints. (In this mode you can also type letters from the hinted element to filter and reduce the number of elements that are hinted.)
##   - letter: Use the characters in the `hints.chars` setting.
##   - word: Use hints words based on the html elements and the extra words.
c.hints.mode = 'letter'

## Comma-separated list of regular expressions to use for 'next' links.
## Type: List of Regex
c.hints.next_regexes = [
    '\\bnext\\b', '\\bmore\\b', '\\bnewer\\b', '\\b[>→≫]\\b', '\\b(>>|»)\\b',
    '\\bcontinue\\b'
]

## Comma-separated list of regular expressions to use for 'prev' links.
## Type: List of Regex
c.hints.prev_regexes = [
    '\\bprev(ious)?\\b', '\\bback\\b', '\\bolder\\b', '\\b[<←≪]\\b',
    '\\b(<<|«)\\b'
]

## Scatter hint key chains (like Vimium) or not (like dwb). Ignored for
## number hints.
## Type: Bool
c.hints.scatter = True

## Make characters in hint strings uppercase.
## Type: Bool
c.hints.uppercase = False

## Maximum time (in minutes) between two history items for them to be
## considered being from the same browsing session. Items with less time
## between them are grouped when being displayed in `:history`. Use -1 to
## disable separation.
## Type: Int
c.history_gap_interval = 30

## Which unbound keys to forward to the webview in normal mode.
## Type: String
## Valid values:
##   - all: Forward all unbound keys.
##   - auto: Forward unbound non-alphanumeric keys.
##   - none: Don't forward any keys.
c.input.forward_unbound_keys = 'none'

## Enter insert mode if an editable element is clicked.
## Type: Bool
c.input.insert_mode.auto_enter = True

## Leave insert mode if a non-editable element is clicked.
## Type: Bool
c.input.insert_mode.auto_leave = True

## Automatically enter insert mode if an editable element is focused
## after loading the page.
## Type: Bool
c.input.insert_mode.auto_load = False

## Switch to insert mode when clicking flash and other plugins.
## Type: Bool
c.input.insert_mode.plugins = False

## Include hyperlinks in the keyboard focus chain when tabbing.
## Type: Bool
c.input.links_included_in_focus_chain = True

## Timeout (in milliseconds) for partially typed key bindings. If the
## current input forms only partial matches, the keystring will be
## cleared after this time.
## Type: Int
c.input.partial_timeout = 5000

## Enable Opera-like mouse rocker gestures. This disables the context
## menu.
## Type: Bool
# c.input.mouse.rocker_gestures = False

## Enable spatial navigation. Spatial navigation consists in the ability
## to navigate between focusable elements in a Web page, such as
## hyperlinks and form controls, by using Left, Right, Up and Down arrow
## keys. For example, if the user presses the Right key, heuristics
## determine whether there is an element he might be trying to reach
## towards the right and which element he probably wants.
## Type: Bool
#TODO
c.input.spatial_navigation = False

## Keychains that shouldn't be shown in the keyhint dialog. Globs are
## supported, so `;*` will blacklist all keychains starting with `;`. Use
## `*` to disable keyhints.
## Type: List of String
c.keyhint.blacklist = []

## Time (in milliseconds) from pressing a key to seeing the keyhint
## dialog.
## Type: Int
c.keyhint.delay = 500

## Rounding radius (in pixels) for the edges of the keyhint dialog.
## Type: Int
c.keyhint.radius = 6

## Duration (in milliseconds) to show messages in the statusbar for. Set
## to 0 to never clear messages.
## Type: Int
c.messages.timeout = 2000

## How to open links in an existing instance if a new one is launched.
## This happens when e.g. opening a link from a terminal. See
## `new_instance_open_target_window` to customize in which window the
## link is opened in.
## Type: String
## Valid values:
##   - tab: Open a new tab in the existing window and activate the window.
##   - tab-bg: Open a new background tab in the existing window and activate the window.
##   - tab-silent: Open a new tab in the existing window without activating the window.
##   - tab-bg-silent: Open a new background tab in the existing window without activating the window.
##   - window: Open in a new window.
c.new_instance_open_target = 'tab'

## Which window to choose when opening links as new tabs. When
## `new_instance_open_target` is not set to `window`, this is ignored.
## Type: String
## Valid values:
##   - first-opened: Open new tabs in the first (oldest) opened window.
##   - last-opened: Open new tabs in the last (newest) opened window.
##   - last-focused: Open new tabs in the most recently focused window.
##   - last-visible: Open new tabs in the most recently visible window.
c.new_instance_open_target_window = 'last-focused'

## Show a filebrowser in upload/download prompts.
## Type: Bool
c.prompt.filebrowser = True

## Rounding radius (in pixels) for the edges of prompts.
## Type: Int
c.prompt.radius = 8

## Additional arguments to pass to Qt, without leading `--`. With
## QtWebEngine, some Chromium arguments (see
## https://peter.sh/experiments/chromium-command-line-switches/ for a
## list) will work.
## Type: List of String
c.qt.args = []

## Force a Qt platform to use. This sets the `QT_QPA_PLATFORM`
## environment variable and is useful to force using the XCB plugin when
## running QtWebEngine on Wayland.
## Type: String
c.qt.force_platform = None

## When to find text on a page case-insensitively.
## Type: IgnoreCase
## Valid values:
##   - always: Search case-insensitively.
##   - never: Search case-sensitively.
##   - smart: Search case-sensitively if there are capital characters.
c.search.ignore_case = 'smart'

## Name of the session to save by default. If this is set to null, the
## session which was last loaded is saved.
## Type: SessionName
c.session.default_name = None

## Languages to use for spell checking. You can check for available
## languages and install dictionaries using scripts/dictcli.py. Run the
## script with -h/--help for instructions.
## Type: List of String
## Valid values:
##   - af-ZA: Afrikaans (South Africa)
##   - bg-BG: Bulgarian (Bulgaria)
##   - ca-ES: Catalan (Spain)
##   - cs-CZ: Czech (Czech Republic)
##   - da-DK: Danish (Denmark)
##   - de-DE: German (Germany)
##   - el-GR: Greek (Greece)
##   - en-AU: English (Australia)
##   - en-CA: English (Canada)
##   - en-GB: English (United Kingdom)
##   - en-US: English (United States)
##   - es-ES: Spanish (Spain)
##   - et-EE: Estonian (Estonia)
##   - fa-IR: Farsi (Iran)
##   - fo-FO: Faroese (Faroe Islands)
##   - fr-FR: French (France)
##   - he-IL: Hebrew (Israel)
##   - hi-IN: Hindi (India)
##   - hr-HR: Croatian (Croatia)
##   - hu-HU: Hungarian (Hungary)
##   - id-ID: Indonesian (Indonesia)
##   - it-IT: Italian (Italy)
##   - ko: Korean
##   - lt-LT: Lithuanian (Lithuania)
##   - lv-LV: Latvian (Latvia)
##   - nb-NO: Norwegian (Norway)
##   - nl-NL: Dutch (Netherlands)
##   - pl-PL: Polish (Poland)
##   - pt-BR: Portuguese (Brazil)
##   - pt-PT: Portuguese (Portugal)
##   - ro-RO: Romanian (Romania)
##   - ru-RU: Russian (Russia)
##   - sh: Serbo-Croatian
##   - sk-SK: Slovak (Slovakia)
##   - sl-SI: Slovenian (Slovenia)
##   - sq: Albanian
##   - sr: Serbian
##   - sv-SE: Swedish (Sweden)
##   - ta-IN: Tamil (India)
##   - tg-TG: Tajik (Tajikistan)
##   - tr-TR: Turkish (Turkey)
##   - uk-UA: Ukrainian (Ukraine)
##   - vi-VN: Vietnamese (Viet Nam)
c.spellcheck.languages = []

## Padding (in pixels) for the statusbar.
## Type: Padding
c.statusbar.padding = {'top': 1, 'right': 0, 'bottom': 1, 'left': 0}

## Position of the status bar.
## Type: VerticalPosition
## Valid values:
##   - top
##   - bottom
c.statusbar.position = 'bottom'

## List of widgets displayed in the statusbar.
## Type: List of String
## Valid values:
##   - url: Current page URL.
##   - scroll: Percentage of the current page position like `10%`.
##   - scroll_raw: Raw percentage of the current page position like `10`.
##   - history: Display an arrow when possible to go back/forward in history.
##   - tabs: Current active tab, e.g. `2`.
##   - keypress: Display pressed keys when composing a vi command.
##   - progress: Progress bar for the current page loading.
c.statusbar.widgets = [
    'keypress', 'url', 'scroll', 'history', 'tabs', 'progress'
]

## Open new tabs (middleclick/ctrl+click) in the background.
## Type: Bool
c.tabs.background = False

## Mouse button with which to close tabs.
## Type: String
## Valid values:
##   - right: Close tabs on right-click.
##   - middle: Close tabs on middle-click.
##   - none: Don't close tabs using the mouse.
c.tabs.close_mouse_button = 'middle'

## How to behave when the close mouse button is pressed on the tab bar.
## Type: String
## Valid values:
##   - new-tab: Open a new tab.
##   - close-current: Close the current tab.
##   - close-last: Close the last tab.
##   - ignore: Don't do anything.
c.tabs.close_mouse_button_on_bar = 'new-tab'

## Scaling factor for favicons in the tab bar. The tab size is unchanged,
## so big favicons also require extra `tabs.padding`.
## Type: Float
c.tabs.favicons.scale = 1.0

## When to show favicons in the tab bar.
## Type: String
## Valid values:
##   - always: Always show favicons.
##   - never: Always hide favicons.
##   - pinned: Show favicons only on pinned tabs.
c.tabs.favicons.show = 'always'

## Padding (in pixels) for tab indicators.
## Type: Padding
c.tabs.indicator.padding = {'top': 2, 'right': 4, 'bottom': 2, 'left': 0}

## Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
## for a blank page.
## Type: FuzzyUrl
c.url.default_page = 'https://google.com'

## Search engines which can be used via the address bar. Maps a search
## engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
## placeholder. The placeholder will be replaced by the search term, use
## `{{` and `}}` for literal `{`/`}` signs. The search engine named
## `DEFAULT` is used when `url.auto_search` is turned on and something
## else than a URL was entered to be opened. Other search engines can be
## used by prepending the search engine name to the search term, e.g.
## `:open google qutebrowser`.
## Type: Dict
c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}'}

## Page(s) to open at the start.
## Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = ['https://google.com']

## URL parameters to strip with `:yank url`.
## Type: List of String
c.url.yank_ignored_parameters = [
    'ref', 'utm_source', 'utm_medium', 'utm_campaign', 'utm_term',
    'utm_content'
]

## Default zoom level.
## Type: Perc
c.zoom.default = '100%'

## Available zoom levels.
## Type: List of Perc
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
BASE_SPAWN_FZF = 'spawn --userscript ~/.local/bin/floating_st'
config.bind(' o', BASE_SPAWN_FZF + ' fzf_qutebrowser_url')
config.bind(' O', BASE_SPAWN_FZF + ' fzf_qutebrowser_url -t')
config.bind(' c', BASE_SPAWN_FZF + ' fzf_qutebrowser_cmd')

# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# Gruvbox dark, hard scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)

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
