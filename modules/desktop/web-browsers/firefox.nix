{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nur.url = "github:nix-community/NUR";
  };

  den.aspects.desktop = {
    homeManager =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [
          inputs.nur.overlays.default
        ];

        programs.firefox =
          let
            defaultFont = "Aporetic Sans Mono";
          in
          {
            enable = true;
            package = pkgs.firefox.override { pkcs11Modules = [ pkgs.eid-mw ]; };
            nativeMessagingHosts = [
              pkgs.browserpass
              pkgs.web-eid-app
            ];
            profiles.default = {
              id = 0;
              isDefault = true;
              name = "Default";
              extensions.packages = [
                pkgs.nur.repos.rycee.firefox-addons.belgium-eid
                pkgs.nur.repos.rycee.firefox-addons.browserpass
                # pkgs.nur.repos.rycee.firefox-addons.bypass-paywalls-clean
                # pkgs.nur.repos.rycee.firefox-addons.enhancer-for-youtube
                pkgs.nur.repos.rycee.firefox-addons.private-relay
                pkgs.nur.repos.rycee.firefox-addons.foxyproxy-standard
                pkgs.nur.repos.rycee.firefox-addons.french-dictionary
                pkgs.nur.repos.rycee.firefox-addons.istilldontcareaboutcookies
                pkgs.nur.repos.rycee.firefox-addons.kristofferhagen-nord-theme
                pkgs.nur.repos.rycee.firefox-addons.multi-account-containers
                pkgs.nur.repos.rycee.firefox-addons.privacy-badger
                pkgs.nur.repos.rycee.firefox-addons.refined-saved-replies
                pkgs.nur.repos.rycee.firefox-addons.simple-tab-groups
                pkgs.nur.repos.rycee.firefox-addons.tournesol
                pkgs.nur.repos.rycee.firefox-addons.ublock-origin
                pkgs.nur.repos.rycee.firefox-addons.violentmonkey
                pkgs.nur.repos.rycee.firefox-addons.web-eid
              ];
              search = {
                default = "google";
                force = true;
                engines = {
                  "autonomous-system-number-search" = {
                    urls = [ { template = "https://bgp.tools/search?q={searchTerms}"; } ];
                    icon = "https://bgp.tools/favicon-32x32.png";
                    updateInterval = 24 * 60 * 60 * 1000; # every day
                    definedAliases = [ "@asn" ];
                  };

                  "nix-packages" = {
                    urls = [
                      {
                        template = "https://search.nixos.org/packages";
                        params = [
                          {
                            name = "type";
                            value = "packages";
                          }
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];

                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = [ "@np" ];
                  };

                  "nixpkgs-prs" = {
                    urls = [ { template = "https://nixpk.gs/pr-tracker.html?pr={searchTerms}"; } ];
                    icon = "https://nixos.org/favicon.png";
                    updateInterval = 24 * 60 * 60 * 1000; # every day
                    definedAliases = [ "@npr" ];
                  };

                  "nixos-wiki" = {
                    urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
                    icon = "https://wiki.nixos.org/favicon.png";
                    updateInterval = 24 * 60 * 60 * 1000; # every day
                    definedAliases = [ "@nw" ];
                  };

                  "noogle-dev-search" = {
                    urls = [ { template = "https://noogle.dev/?term=%22{searchTerms}%22"; } ];
                    icon = "https://noogle.dev/favicon.png";
                    updateInterval = 24 * 60 * 60 * 1000; # every day
                    definedAliases = [
                      "@ngd"
                      "@nog"
                    ];
                  };

                  "bing".metaData.hidden = true;
                  "duckduckgo".metaData.hidden = true;
                  "amazonnl".metaData.hidden = true;
                  "ebay".metaData.hidden = true;
                  "google".metaData.alias = "@g";
                };
              };
              settings = {
                "app.update.auto" = false;
                # 0000: disable about:config warning **
                "browser.aboutConfig.showWarning" = false;
                "browser.urlbar.update2.engineAliasRefresh" = true;
                "browser.shell.checkDefaultBrowser" = false;
                "browser.startup.homepage" = "";
                "cookiebanners.service.mode" = 2;
                # Enable HTTPS-Only Mode
                "dom.security.https_only_mode" = true;
                "dom.security.https_only_mode_ever_enabled" = true;
                # Privacy settings
                "privacy.donottrackheader.enabled" = true;
                "privacy.trackingprotection.enabled" = true;
                "privacy.trackingprotection.socialtracking.enabled" = true;
                "privacy.partition.network_state.ocsp_cache" = true;
                # Disable all sorts of telemetry
                "browser.newtabpage.activity-stream.feeds.telemetry" = false;
                "browser.newtabpage.activity-stream.telemetry" = false;
                "browser.fullscreen.autohide" = false;
                "browser.newtabpage.activity-stream.topSitesRows" = 0;
                "browser.urlbar.quickactions.enabled" = true;
                "browser.safebrowsing.malware.enabled" = false;
                "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter";
                "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
                "browser.urlbar.trimURLs" = false;
                "browser.ping-centre.telemetry" = false;
                "browser.urlbar.suggest.bookmark" = false;
                "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
                "browser.urlbar.suggest.quicksuggest.sponsored" = false;
                "browser.urlbar.suggest.searches" = false;
                "toolkit.telemetry.archive.enabled" = false;
                "toolkit.telemetry.bhrPing.enabled" = false;
                "toolkit.telemetry.enabled" = false;
                "toolkit.telemetry.firstShutdownPing.enabled" = false;
                "toolkit.telemetry.hybridContent.enabled" = false;
                "toolkit.telemetry.newProfilePing.enabled" = false;
                "toolkit.telemetry.reportingpolicy.firstRun" = false;
                "toolkit.telemetry.shutdownPingSender.enabled" = false;
                "toolkit.telemetry.unified" = false;
                "toolkit.telemetry.updatePing.enabled" = false;

                # As well as Firefox 'experiments'
                "experiments.activeExperiment" = false;
                "experiments.enabled" = false;
                "experiments.supported" = false;
                "network.allow-experiments" = false;
                # Disable Pocket Integration
                "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                "extensions.pocket.enabled" = false;
                "extensions.pocket.api" = "";
                "extensions.pocket.oAuthConsumerKey" = "";
                "extensions.pocket.showHome" = false;
                "extensions.pocket.site" = "";
                # Allow copy to clipboard
                "dom.events.asyncClipboard.clipboardItem" = true;
                "trailhead.firstrun.didSeeAboutWelcome" = true;
                "widget.use-xdg-desktop-portal.file-picker" = 1;
                "widget.use-xdg-desktop-portal.location" = 1;
                "widget.use-xdg-desktop-portal.mime-handler" = 1;
                "widget.use-xdg-desktop-portal.open-uri" = 1;
                "widget.use-xdg-desktop-portal.settings" = 1;

                "privacy.donottrackheader.value" = 1;
                "findbar.modalHighlight" = true;
                "datareporting.healthreport.uploadEnabled" = false;

                # override fonts
                "font.minimum-size.x-western" = 12;
                "font.size.fixed.x-western" = 14;
                "font.size.monospace.x-western" = 14;
                "font.size.variable.x-western" = 14;
                "font.name.monospace.x-western" = "${defaultFont}";
                "font.name.sans-serif.x-western" = "${defaultFont}";
                "font.name.serif.x-western" = "${defaultFont}";
                "browser.display.use_document_fonts" = 0;
                "layout.css.system-ui.enabled" = false;
                "font.language.group" = "x-western";
                "font.default.x-western" = "sans-serif";

                # Disable mailto popup
                "network.protocol-handler.external.mailto" = false;

                # Don't use the built-in password manager.
                "signon.rememberSignons" = false;

                # Increase the number of pages Firefox keeps in history.
                "places.history.expiration.max_pages" = 128 * 1024 * 1024;

                # Enable hardware video decoding (requires VAAPI support in the GPU driver and the presence of the `vainfo` (libva-utils) utility in the system).
                "media.ffmpeg.vaapi.enabled" = true;

                # 0320: disable recommendation pane in about:addons (uses Google Analytics) **
                "extensions.getAddons.showPane" = false;

                # 0321: disable recommendations in about:addons' Extensions and Themes panes [FF68+] **
                "extensions.htmlaboutaddons.recommendations.enabled" = false;

                # 0322: disable personalized Extension Recommendations in about:addons and AMO [FF65+]
                "browser.discovery.enabled" = false;

                # 0601: disable link prefetching
                "network.prefetch-next" = false;
                # 0602: disable DNS prefetching
                "network.dns.disablePrefetch" = true;
                "network.dns.disablePrefetchFromHTTPS" = true;
                # 0603: disable predictor / prefetching **
                "network.predictor.enabled" = false;
                "network.predictor.enable-prefetch" = false; # [FF48+] [DEFAULT: false]
                # 0604: disable link-mouseover opening connection to linked server
                "network.http.speculative-parallel-limit" = 0;
                # 0605: disable mousedown speculative connections on bookmarks and history [FF98+] **
                "browser.places.speculativeConnect.enabled" = false;
                # 0702: set the proxy server to do any DNS lookups when using SOCKS
                "network.proxy.socks_remote_dns" = true;
              };
            };
          };
      };
  };
}
