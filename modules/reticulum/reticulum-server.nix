{
  den,
  inputs,
  ...
}:
{
  infra.reticulum-server = {
    homeManager =
      { pkgs, system, ... }:
      let
        lxmf = pkgs.master.python3Packages.lxmf.override {
          propagateRns = true;
        };
      in
      {
        home.packages = with pkgs.master; [
          lxmf
          rns
        ];
        nixpkgs = {
          overlays = [
            (final: _prev: {
              master = import inputs.nixpkgs-master {
                inherit (final) config;
                inherit system;
              };
            })
          ];
        };
      };
    includes = [
      (den.provides.unfree [
        "lxmf"
        "rns"
      ])
    ];
    nixos =
      {
        pkgs,
        system,
        ...
      }:
      {
        imports = [
          ./_rnsh-service.nix
          ./_nomadnet-service.nix
        ];
        networking.firewall = {
          allowedTCPPorts = [
            4242
            6009
          ];

          # For AutoInterface and multicast discovery
          extraCommands = ''
            iptables -A nixos-fw -p udp -m pkttype --pkt-type multicast -m udp -j nixos-fw-accept
            ip6tables -A nixos-fw -p udp -m pkttype --pkt-type multicast -m udp -j nixos-fw-accept
          '';
        };
        nixpkgs = {
          overlays = [
            (final: _prev: {
              master = import inputs.nixpkgs-master {
                inherit (final) config;
                inherit system;
              };
            })
          ];
        };
        # systemd.services.rnsd.serviceConfig.ExecStart = lib.mkForce "${lib.getExe' pkgs.rns "rnsd"} --config $STATE_DIRECTORY --service --verbose";
        services = {
          # services.rnsh = {
          #   enable = true;
          #   allowed_identities = [
          #     "afcdd5bf95ede3ba04cb4a946da866fb"
          #   ];
          #   user = "pol";
          #   createUser = false;
          #   createGroup = false;
          #   rnsd = {
          #     settings = {
          #       reticulum = {
          #         require_shared_instance = true;
          #         is_shared_instance = true;
          #         enable_transport = true;
          #         instance_name = "default";
          #         shared_instance_type = "unix";
          #       };
          #     };
          #   };
          # };
          lxmd = {
            enable = true;

            package = pkgs.master.python3Packages.lxmf.override {
              propagateRns = true;
            };

            rnsd = {
              settings = {
                reticulum = {
                  enable_transport = true;
                  instance_name = "default";
                  is_shared_instance = true;
                  require_shared_instance = true;
                  shared_instance_type = "unix";
                };
              };
            };

            settings = {
              logging = {
                loglevel = 4;
                logtimestamps = false;
              };

              lxmf = {
                announce_at_start = true;
                announce_interval = 60;
                delivery_transfer_max_accepted_size = 1000;
                display_name = "Apollo LXMF Node";
              };

              propagation = {
                announce_at_start = true;
                announce_interval = 60;
                auth_required = false;
                autopeer = true;
                autopeer_maxdepth = 6;
                enable_node = true;
                max_peers = 40;
                node_name = "Apollo Propagation Node";
                propagation_message_max_accepted_size = 1024;
              };
            };
          };

          nomadnet = {
            enable = false;

            peerSettings = {
              display_name = "Apollo Nomadnet Node";
              propagation_node = "7eb50a1dba9d2b17d77feeb84ed545f3"; # LXMF Propagation Node started on <7eb50a1dba9d2b17d77feeb84ed545f3>
            };

            rnsd = {
              settings = {
                reticulum = {
                  enable_transport = true;
                  instance_name = "default";
                  is_shared_instance = true;
                  require_shared_instance = true;
                  shared_instance_type = "unix";
                };
              };
            };

            settings = {
              client = {
                announce_at_start = false;
                enable_client = false;
                notify_on_new_message = false;
                periodic_lxmf_sync = false;
                try_propagation_on_send_fail = false;
                user_interface = null;
              };

              logging = {
                destination = "console";
                loglevel = 4;
              };

              node = {
                announce_at_start = true;
                announce_interval = 60;
                disable_propagation = true;
                enable_node = true;
                file_refresh_interval = 5;
                node_name = "Apollo Nomadnet Node";
                page_refresh_interval = 5;
              };
            };
          };

          rnsd = {
            enable = true;
            enableUdevRules = true;
            extraGroups = [ "dialout" ];
            openMulticastPorts = true;
            package = pkgs.master.rns;

            settings = {
              interfaces = {
                "Berlin IPV4" = {
                  enabled = true;
                  target_host = "82.165.27.170";
                  target_port = 443;
                  type = "BackboneInterface";
                };

                "Bern_IPv4" = {
                  enabled = true;
                  target_host = "45.59.114.96";
                  target_port = 7822;
                  type = "BackboneInterface";
                };

                "Default Interface" = {
                  discoverable = true;
                  enabled = true;
                  type = "AutoInterface";
                };

                "Hispagatos_org_HQ" = {
                  enabled = true;
                  target_host = "reticulum.hispagatos.org";
                  target_port = 4242;
                  type = "BackboneInterface";
                };

                "NL_UTR_Backbone" = {
                  enabled = true;
                  target_host = "rns.fonetic.studio";
                  target_port = 4242;
                  type = "BackboneInterface";
                };

                "RMap World" = {
                  enabled = true;
                  target_host = "rmap.world";
                  target_port = 4242;
                  type = "BackboneInterface";
                };

                "RNode LoRa Interface" = {
                  airtime_limit_long = 10;
                  announce_interval = 420;
                  bandwidth = 250000;
                  codingrate = 5;
                  discoverable = true;
                  discovery_name = "Apollora Node";
                  enabled = true;
                  frequency = 869525000;
                  height = 50;
                  latitude = 50.597463;
                  longitude = 4.323678;
                  mode = "access_point";
                  port = "/dev/ttyACM0";
                  spreadingfactor = 11;
                  txpower = 22;
                  type = "RNodeInterface";
                };

                "Sowerby_Node" = {
                  enabled = true;
                  target_host = "rns.shaun.rocks";
                  target_port = 4242;
                  type = "BackboneInterface";
                };

                # "rns.fyi" = {
                #   enabled = true;
                #   target_host = "rns.fyi";
                #   target_port = 4242;
                #   type = "TCPClientInterface";
                # };
                "rns.not-a-number.io" = {
                  announce_interval = 420;
                  discoverable = true;
                  discovery_name = "Apollo RNS";
                  enabled = true;
                  height = 50;
                  latitude = 50.597463;
                  listen_ip = "0.0.0.0";
                  listen_port = 4242;
                  longitude = 4.323678;
                  mode = "gateway";
                  reachable_on = "rns.not-a-number.io";
                  type = "BackboneInterface";
                };

                "rns.reticulum-wf.nl" = {
                  enabled = true;
                  target_host = "rns.reticulum-wf.nl";
                  target_port = 4242;
                  type = "BackboneInterface";
                };

                "rns.sofia" = {
                  enabled = true;
                  target_host = "193.193.182.147";
                  target_port = 4242;
                  type = "BackboneInterface";
                };

                "valleirug server" = {
                  enabled = true;
                  target_host = "rns.valleirug.nl";
                  target_port = 24242;
                  type = "TCPClientInterface";
                };

                "wintermute" = {
                  enabled = true;
                  target_host = "212.216.248.53";
                  target_port = 4242;
                  type = "BackboneInterface";
                };
              };

              reticulum = {
                blackhole_sources = [
                  "521c87a83afb8f29e4455e77930b973b"
                  "68a4aa91ac350c4087564e8a69f84e86"
                ];

                blackhole_update_interval = 60;
                discover_interfaces = true;
                enable_transport = true;
                instance_name = "default";

                logging = {
                  loglevel = 8;
                  logtimestamps = false;
                };

                panic_on_interface_error = false;
                publish_blackhole = true;
                share_instance = true;
                shared_instance_type = "unix";
              };
            };
          };
        };
      };
  };
}
