{
  infra.email = {
    homeManager =
      { pkgs, ... }:
      {
        programs.thunderbird = {
          enable = true;
          # Importing ggp key with `pkgs.thunderbird` doesn't work.
          # Works without any issues with `pkgs.thunderbird-bin`.
          package = pkgs.thunderbird-bin;

          profiles.default = {
            isDefault = true;
            withExternalGnupg = true;
          };

          settings =
            let
              columns = {
                accountCol = mkColumn true 31;
                attachmentCol = mkColumn false 9;
                correspondentCol = mkColumn true 17;
                dateCol = mkColumn true 23;
                deleteCol = mkColumn false 43;
                flaggedCol = mkColumn true 7;
                idCol = mkColumn false 41;
                junkStatusCol = mkColumn false 19;
                locationCol = mkColumn true 39;
                priorityCol = mkColumn false 33;
                receivedCol = mkColumn false 21;
                recipientCol = mkColumn false 15;
                selectCol = mkColumn false 1;
                senderCol = mkColumn false 13;
                sizeCol = mkColumn false 27;
                statusCol = mkColumn false 25;
                subjectCol = mkColumn true 11;
                tagsCol = mkColumn false 29;
                threadCol = mkColumn true 5;
                totalCol = mkColumn false 37;
                unreadButtonColHeader = mkColumn false 3;
                unreadCol = mkColumn false 35;
              };
              mkColumn = visible: ordinal: { inherit visible ordinal; };
            in
            {
              "app.update.auto" = false;
              "calendar.alarms.eventalarmlen" = 0;
              "calendar.alarms.onforevents" = 1;
              "calendar.alarms.onfortodos" = 1;
              "calendar.alarms.playsound" = false;
              "calendar.alarms.todoalarmlen" = 0;
              "calendar.dayendhour" = 24;
              "calendar.event.defaultlength" = 30;
              "calendar.events.defaultActionEdit" = true;
              "calendar.item.editInTab" = true;
              "calendar.task.defaultdue" = "offsetcurrent";
              "calendar.task.defaultdueoffset" = 0;
              "calendar.timezone.local" = "Europe/Brussels";
              "calendar.timezone.useSystemTimezone" = true;
              "calendar.view.visiblehours" = 16;
              "calendar.week.start" = 1;
              "font.name.monospace.x-western" = "Aporetic Sans Mono";
              "font.name.sans-serif.x-western" = "Aporetic Sans Mono";
              "font.name.serif.x-western" = "Aporetic Sans Mono";
              "font.size.monospace.x-western" = 12;
              "font.size.variable.x-western" = 14;
              "intl.date_time.pattern_override.connector_short" = " ";
              "intl.date_time.pattern_override.date_full" = "yyyy.MM.dd";
              "intl.date_time.pattern_override.date_long" = "yyyy.MM.dd";
              "intl.date_time.pattern_override.date_medium" = "yyyy.MM.dd";
              "intl.date_time.pattern_override.date_short" = "yyyy.MM.dd";
              "intl.date_time.pattern_override.time_full" = "HH:mm";
              "intl.date_time.pattern_override.time_long" = "HH:mm";
              "intl.date_time.pattern_override.time_medium" = "HH:mm";
              "intl.date_time.pattern_override.time_short" = "HH:mm";
              "mail.biff.play_sound" = false;
              "mail.biff.show_alert" = false;
              "mail.collect_addressbook" = "jsaddrbook://history.sqlite";
              "mail.default_send_format" = 1; # plain text
              "mail.identity.default.archive_enabled" = true;
              "mail.identity.default.archive_keep_folder_structure" = true;
              "mail.identity.default.auto_quote" = true;
              "mail.identity.default.compose_html" = false;
              "mail.identity.default.doCc" = true; # enable Cc field by default
              "mail.identity.default.fcc_reply_follows_parent" = false;
              "mail.identity.default.protectSubject" = true;
              "mail.identity.default.reply_on_top" = 1;
              "mail.identity.default.sig_bottom" = false;
              "mail.identity.default.sig_on_reply" = false;
              "mail.pane_config.dynamic" = 1; # Wide layout
              "mail.sanitize_date_header" = true;
              "mail.server.default.allow_utf8_accept" = true;
              "mail.server.default.check_all_folders_for_new" = true;
              "mail.server.default.max_articles" = 1000000;
              "mail.shell.checkDefaultClient" = false;
              "mail.show_headers" = 1;
              "mail.threadpane.listview" = 1;
              "mail.uidensity" = 0;
              "mail.uifontsize" = 14;
              "mailnews.database.global.views.conversation.columns" = columns;
              "mailnews.database.global.views.global.columns" = columns;
              "mailnews.default_sort_order" = 2; # descending
              "mailnews.default_sort_type" = 18; # by date
              "mailnews.default_view_flags" = 1; # Threaded view
              "mailnews.headers.showMessageId" = true;
              "mailnews.headers.showOrganization" = true;
              "mailnews.headers.showReferences" = true;
              "mailnews.headers.showUserAgent" = true;
              # Sorting
              # Sort them by the newest reply in thread.
              "mailnews.sort_threads_by_root" = false;
              "mailnews.start_page.enabled" = false;
              "msgcompose.font_face" = "monospace";
              "privacy.donottrackheader.enabled" = true;
              # Disable telemetry
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.prompted" = 2;
              "toolkit.telemetry.rejected" = true;
            };
        };

        xdg.mimeApps.defaultApplications = {
          "message/rfc822" = "thunderbird.desktop";
          "text/calendar" = "thunderbird.desktop";
          "text/x-vcard" = "thunderbird.desktop";
          "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
        };
      };
  };
}
