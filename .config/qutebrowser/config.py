config.load_autoconfig()
#config.set("colors.webpage.darkmode.enabled", True)
c.fonts.default_size = '12pt'
config.bind(',gr',
            'config-cycle content.user_stylesheets ~/packages/solarized-everything/css/gruvbox/gruvbox-all-sites.css ""')
config.source('gruvbox.py')
