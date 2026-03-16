{ pkgs, ... }:

let
  esc = builtins.fromJSON ''"\u001b"'';

  shadow = "${esc}[38;5;12m";
  mid = "${esc}[38;5;14m";
  light = "${esc}[38;5;15m";
  maroon = "${esc}[38;5;1m";
  gold = "${esc}[38;5;11m";
  rst = "${esc}[0m";

  # https://www.asciiart.eu/image-to-ascii
  penroseLogo = pkgs.writeText "penrose-logo.txt" ''
                          ${mid}#${shadow}@@@@@@@@@
                         ${mid}###${shadow}@@@@@@@@@
                        ${mid}#####${shadow}@@@@@@@@@
                       ${mid}#######${shadow}@@@@@@@@@
                      ${mid}#########${shadow}@@@@@@@@@
                     ${mid}###########${shadow}@@@@@@@@@
                    ${mid}#############${shadow}@@@@@@@@@
                   ${mid}###############${shadow}@@@@@@@@@
                  ${mid}########${light}%%${mid}#######${shadow}@@@@@@@@@
                 ${mid}########${light}%%%%${mid}#######${shadow}@@@@@@@@@
                ${mid}########${light}%%%%%%${mid}#######${shadow}@@@@@@@@@
               ${mid}########${light}%%%%%%%%${mid}########${shadow}@@@@@@@@
              ${mid}########${light}%%%%%%%%%${mid} ########${shadow}@@@@@@@@@
             ${mid}########${light}%%%%%%%%%${rst}   ${mid}########${shadow}@@@@@@@@@
            ${mid}########${light}%%%%%%%%%${rst}     ${mid}########${shadow}@@@@@@@@@
           ${mid}########${light}%%%%%%%%%${rst}       ${mid}########${shadow}@@@@@@@@@
          ${mid}########${light}%%%%%%%%%${rst}         ${mid}########${shadow}@@@@@@@@@
         ${mid}########${light}%%%%%%%%%${rst}           ${mid}########${shadow}@@@@@@@@@
        ${mid}########${light}%%%%%%%%%${shadow}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
       ${mid}########${light}%%%%%%%%%${shadow}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ${mid}########${light}%%%%%%%%%${shadow}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     ${mid}########${light}%%%%%%%%%${shadow}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    ${mid}########${light}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     ${mid}######${light}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      ${mid}####${light}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ${mid}##${light}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${rst}
                    ${light}P E N R O S E  -  5 1 2${rst}
  '';
  # ${light}P E N R O S E  -  5 1 2${rst}
in
{
  programs.fastfetch = {
    enable = true;
    settings = {

      logo = {
        source = "${penroseLogo}";
        padding = {
          top = 1;
          right = 6;
        };
      };

      # what a pain in the ass
      display = {
        # ❯ char separator for display
        separator = " ${shadow}❯${rst} ";

        # title & keys coloration
        color = {
          keys = "31";
          title = "31";
        };

        # display bar style
        bar = {
          char = {
            elapsed = "■";
            total = " ";
          };

          width = 12;
        };
      };

      # all that shit
      modules = [

        # spacer
        {
          type = "custom";
          format = "";
        }

        "title"

        {
          type = "custom";
          format = "${gold}STATUS: OPERATIONAL${rst}";
        }

        "separator"

        {
          type = "os";
          key = "UNIT";
        }
        {
          type = "de";
          key = "ENVR";
        }
        {
          type = "wm";
          key = "MNGR";
        }
        {
          type = "uptime";
          key = "UPTM";
        }
        "break"
        {
          type = "command";
          key = "TIME";
          text = "date '+%H:%M:%S'";
        }
        {
          type = "shell";
          key = "SHLL";
        }
        {
          type = "terminal";
          key = "TERM";
        }
        {
          type = "font";
          key = "FONT";
          format = "IBM Plex Mono | Geist";
        }

        "break"

        {
          type = "cpu";
          key = "PROC";
          temp = true;
          format = "{1} | {7} | {8}";
        }
        {
          type = "gpu";
          key = "GRPH";
          hideType = "all";
        }
        {
          type = "memory";
          key = "MEMR";
        }

        "break"

        {
          type = "command";
          key = "SYS ";
          text = ''
            df -BG --output=pcent,used,size / |
            awk  'NR==2 {gsub(/G|%/,"");
                  filled=int($1/5);
                  bar="\033[38;5;2m";
                  for(i=0;i<filled;i++) bar=bar"■";
                  bar=bar"\033[0m";
                  for(i=filled;i<20;i++)
                  bar=bar" ";
                  print "[" bar "] " $2 "/" $3 " GiB (\033[32m" $1 "%\033[0m)"}' '';
        }
        {
          type = "command";
          key = "GAME";
          text = ''
            df -BG --output=pcent,used,size /mnt/b |
            awk  'NR==2 {gsub(/G|%/,"");
                  filled=int($1/5);
                  bar="\033[38;5;2m";
                  for(i=0;i<filled;i++) bar=bar"■";
                  bar=bar"\033[0m";
                  for(i=filled;i<20;i++) bar=bar" ";
                  print "[" bar "] " $2 "/" $3 " GiB (\033[32m" $1 "%\033[0m)"}' '';
        }
        {
          type = "command";
          key = "MUSC";
          text = ''
            df -BG --output=pcent,used,size /mnt/music |
            awk  'NR==2 {gsub(/G|%/,"");
                  filled=int($1/5);
                  bar="\033[38;5;2m";
                  for(i=0;i<filled;i++) bar=bar"■";
                  bar=bar"\033[0m";
                  for(i=filled;i<20;i++) bar=bar" ";
                  print "[" bar "] " $2 "/" $3 " GiB (\033[32m" $1 "%\033[0m)"}' '';
        }
        {
          type = "command";
          key = "STOR";
          text = ''
            df -BG --output=pcent,used,size /mnt/store |
            awk  'NR==2 {gsub(/G|%/,"");
                  filled=int($1/5);
                  bar="\033[38;5;2m";
                  for(i=0;i<filled;i++) bar=bar"■";
                  bar=bar"\033[0m";
                  for(i=filled;i<20;i++) bar=bar" ";
                  print "[" bar "] " $2 "/" $3 " GiB (\033[32m" $1 "%\033[0m)"}' '';
        }

        "break"
        {
          type = "media";
          key = "PLAY";
        }

        "break"

        {
          type = "colors";
          symbol = "square";
          block = {
            width = 2;
          };
        }
      ];
    };
  };
}
