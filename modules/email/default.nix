{
  unify.modules.email.home =
    { pkgs, ... }:
    {
      programs.thunderbird = {
        enable = true;
        # Importing ggp key with `pkgs.thunderbird` doesn't work.
        # Works without any issues with `pkgs.thunderbird-bin`.
        package = pkgs.thunderbird-bin;
        settings =
          let
            mkColumn = visible: ordinal: { inherit visible ordinal; };
            columns = {
              selectCol = mkColumn false 1;
              threadCol = mkColumn true 5;
              flaggedCol = mkColumn true 7;
              attachmentCol = mkColumn false 9;
              subjectCol = mkColumn true 11;
              unreadButtonColHeader = mkColumn false 3;
              senderCol = mkColumn false 13;
              recipientCol = mkColumn false 15;
              correspondentCol = mkColumn true 17;
              junkStatusCol = mkColumn false 19;
              receivedCol = mkColumn false 21;
              dateCol = mkColumn true 23;
              statusCol = mkColumn false 25;
              sizeCol = mkColumn false 27;
              tagsCol = mkColumn false 29;
              accountCol = mkColumn true 31;
              priorityCol = mkColumn false 33;
              unreadCol = mkColumn false 35;
              totalCol = mkColumn false 37;
              locationCol = mkColumn true 39;
              idCol = mkColumn false 41;
              deleteCol = mkColumn false 43;
            };
          in
          {
            "app.update.auto" = false;

            "intl.date_time.pattern_override.date_short" = "yyyy.MM.dd";
            "intl.date_time.pattern_override.date_medium" = "yyyy.MM.dd";
            "intl.date_time.pattern_override.date_long" = "yyyy.MM.dd";
            "intl.date_time.pattern_override.date_full" = "yyyy.MM.dd";
            "intl.date_time.pattern_override.time_short" = "HH:mm";
            "intl.date_time.pattern_override.time_medium" = "HH:mm";
            "intl.date_time.pattern_override.time_long" = "HH:mm";
            "intl.date_time.pattern_override.time_full" = "HH:mm";
            "intl.date_time.pattern_override.connector_short" = " ";

            "mail.biff.play_sound" = false;
            "mail.biff.show_alert" = false;
            "mail.default_send_format" = 1; # plain text
            "mail.identity.default.archive_enabled" = true;
            "mail.identity.default.archive_keep_folder_structure" = true;
            "mail.identity.default.auto_quote" = true;
            "mail.identity.default.compose_html" = false;
            "mail.identity.default.doCc" = true; # enable Cc field by default
            "mail.identity.default.protectSubject" = true;
            "mail.identity.default.reply_on_top" = 1;
            "mail.identity.default.sig_on_reply" = false;
            "mail.identity.default.sig_bottom" = false;
            "mail.identity.default.fcc_reply_follows_parent" = false;
            "mail.pane_config.dynamic" = 1; # Wide layout
            "mail.sanitize_date_header" = true;
            "mail.server.default.allow_utf8_accept" = true;
            "mail.server.default.max_articles" = 1000000;
            "mail.server.default.check_all_folders_for_new" = true;
            "mail.shell.checkDefaultClient" = false;
            "mail.show_headers" = 1;
            "mail.threadpane.listview" = 1;
            "mail.uifontsize" = 14;
            "mail.uidensity" = 0;
            "mail.collect_addressbook" = "jsaddrbook://history.sqlite";

            "privacy.donottrackheader.enabled" = true;

            "mailnews.database.global.views.conversation.columns" = columns;
            "mailnews.database.global.views.global.columns" = columns;
            "mailnews.start_page.enabled" = false;

            # Sorting
            # Sort them by the newest reply in thread.
            "mailnews.sort_threads_by_root" = false;
            "mailnews.default_sort_order" = 2; # descending
            "mailnews.default_sort_type" = 18; # by date
            "mailnews.default_view_flags" = 1; # Threaded view

            "mailnews.headers.showMessageId" = true;
            "mailnews.headers.showOrganization" = true;
            "mailnews.headers.showReferences" = true;
            "mailnews.headers.showUserAgent" = true;

            "msgcompose.font_face" = "monospace";

            "calendar.timezone.local" = "Europe/Brussels";
            "calendar.week.start" = 1;
            "calendar.view.visiblehours" = 16;
            "calendar.dayendhour" = 24;
            "calendar.alarms.eventalarmlen" = 0;
            "calendar.alarms.onforevents" = 1;
            "calendar.alarms.onfortodos" = 1;
            "calendar.alarms.playsound" = false;
            "calendar.alarms.todoalarmlen" = 0;
            "calendar.event.defaultlength" = 30;
            "calendar.events.defaultActionEdit" = true;
            "calendar.item.editInTab" = true;
            "calendar.task.defaultdueoffset" = 0;
            "calendar.task.defaultdue" = "offsetcurrent";
            "calendar.timezone.useSystemTimezone" = true;

            # Disable telemetry
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.rejected" = true;
            "toolkit.telemetry.prompted" = 2;

            "font.name.monospace.x-western" = "Aporetic Sans Mono";
            "font.size.monospace.x-western" = 12;
            "font.name.sans-serif.x-western" = "Aporetic Sans Mono";
            "font.size.variable.x-western" = 14;
            "font.name.serif.x-western" = "Aporetic Sans Mono";
          };
        profiles.default = {
          isDefault = true;
          withExternalGnupg = true;
        };
      };

      xdg.mimeApps.defaultApplications = {
        "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
        "message/rfc822" = "thunderbird.desktop";
        "text/calendar" = "thunderbird.desktop";
        "text/x-vcard" = "thunderbird.desktop";
      };
    };
}
