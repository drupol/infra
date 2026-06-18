{
  den,
  inputs,
  ...
}:
{
  den.aspects.reticulum-server = {
    includes = [
      (den.provides.unfree [
        "lxmf"
        "rns"
      ])
    ];

    nixos =
      { pkgs, system, ... }:
      {
        imports = [
          inputs.infra-private.nixosModules.reticulum-server
          ./_rnsd-service.nix
          ./_lxmd-service.nix
          ./_rnsh-service.nix
          ./_nomadnet-service.nix
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

        services.nomadnet = {
          enable = true;
          peerSettings = {
            display_name = "Apollo Nomadnet User";
            propagation_node = "f37b7ae147df4fdfebc72b030fd88c44";
          };
          settings = {
            logging = {
              loglevel = 4;
            };
            client = {
              enable_client = false;
              announce_at_start = false;
              notify_on_new_message = false;
              user_interface = null;
              periodic_lxmf_sync = false;
              try_propagation_on_send_fail = false;
            };
            node = {
              enable_node = true;
              announce_at_start = true;
              announce_interval = 420;
              disable_propagation = true;
              node_name = "Apollo Nomadnet Node";
              page_refresh_interval = 5;
              file_refresh_interval = 5;
            };
          };
          rnsd = {
            settings = {
              reticulum = {
                require_shared_instance = true;
                is_shared_instance = true;
                enable_transport = true;
                instance_name = "default";
                shared_instance_type = "unix";
              };
            };
          };
        };

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

        services.rnsd = {
          enable = true;
          package = pkgs.rns;
          settings = {
            reticulum = {
              enable_transport = true;
              share_instance = true;
              instance_name = "default";
              shared_instance_type = "unix";
              discover_interfaces = true;
              panic_on_interface_error = true;
              publish_blackhole = true;
              blackhole_sources = [
                "521c87a83afb8f29e4455e77930b973b"
                "68a4aa91ac350c4087564e8a69f84e86"
              ];
              blackhole_update_interval = 60;
              logging = {
                loglevel = 3;
                logtimestamps = false;
              };
            };
            interfaces = {
              "Default Interface" = {
                type = "AutoInterface";
                enabled = true;
                discoverable = true;
              };
              "RNode LoRa Interface" = {
                type = "RNodeInterface";
                enabled = true;
                discoverable = true;
                port = "/dev/ttyACM0";
                frequency = 869525000;
                bandwidth = 250000;
                txpower = 22;
                spreadingfactor = 11;
                codingrate = 5;
                latitude = 50.597463;
                longitude = 4.323678;
                height = 50;
                discovery_name = "Apollora Node";
                announce_interval = 420;
                airtime_limit_long = 10;
              };
              "rns.not-a-number.io" = {
                type = "BackboneInterface";
                enabled = true;
                mode = "gateway";
                discoverable = true;
                listen_ip = "0.0.0.0";
                listen_port = 4242;
                reachable_on = "rns.not-a-number.io";
                discovery_name = "Apollo RNS";
                announce_interval = 420;
                latitude = 50.597463;
                longitude = 4.323678;
                height = 50;
              };
              "RMap World" = {
                type = "TCPClientInterface";
                enabled = true;
                target_host = "rmap.world";
                target_port = 4242;
              };
              "rns.fyi" = {
                type = "TCPClientInterface";
                enabled = true;
                target_host = "rns.fyi";
                target_port = 4242;
              };
              "Berlin IPV4" = {
                type = "BackboneInterface";
                enabled = true;
                target_host = "82.165.27.170";
                target_port = 443;
              };
              "rns.sofia" = {
                type = "BackboneInterface";
                enabled = true;
                target_host = "193.193.182.147";
                target_port = 4242;
              };
            };
          };
          extraGroups = [ "dialout" ];
        };

        services.lxmd = {
          enable = true;
          settings = {
            propagation = {
              enable_node = true;
              node_name = "Apollo Propagation Node";
              announce_interval = 420;
              announce_at_start = false;
              autopeer = true;
              autopeer_maxdepth = 6;
              propagation_message_max_accepted_size = 1024;
              max_peers = 40;
              auth_required = false;
            };

            lxmf = {
              display_name = "Apollo LXMF Node";
              announce_at_start = false;
              announce_interval = 420;
              delivery_transfer_max_accepted_size = 1000;
            };

            logging = {
              loglevel = 3;
              logtimestamps = false;
            };
          };
          rnsd = {
            settings = {
              reticulum = {
                require_shared_instance = true;
                is_shared_instance = true;
                enable_transport = true;
                instance_name = "default";
                shared_instance_type = "unix";
              };
            };
          };
          package = pkgs.python3Packages.lxmf.override {
            propagateRns = true;
          };
        };

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
      };

    homeManager =
      { pkgs, ... }:
      let
        lxmf = pkgs.python3Packages.lxmf.override {
          propagateRns = true;
        };
      in
      {
        home.packages =
          with pkgs;
          [
            rns
          ]
          ++ [ lxmf ];
      };
  };
}
