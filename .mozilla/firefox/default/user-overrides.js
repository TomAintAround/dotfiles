// 0710
user_pref("network.trr.mode", 2);

// 0712
user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");
user_pref("network.trr.custom_uri", "https://dns.quad9.net/dns-query");

// 0830
user_pref("browser.search.separatePrivateDefault", false);
user_pref("browser.search.separatePrivateDefault.ui.enabled", false);

// 1006
user_pref("browser.shell.shortcutFavicons", true);

// 5003
user_pref("signon.rememberSignons", false);

// 5017
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

// Disable Mozilla account
user_pref("identity.fxaccounts.enabled", false);

// Block autoplay
user_pref("media.autoplay.default", 5);

// Enabling userChrome customization
user_pref("toolkit.legacyuserprofilecustomizations.stylesheets", true);

// Enable Hardware Acceleration
user_pref("gfx.webrender.all", true);
user_pref("media.ffmpeg.vaapi.enabled", true);

// Make firefox boot faster
user_pref("widget.use-xdg-desktop-portal.settings", 0);
