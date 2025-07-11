#!/bin/bash
# sys_info_page: program to output a system information page

PROGNAME=$(basename $0)
TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %Z")
TIMESTAMP="Generated $CURRENT_TIME, by $USER"

report_uptime () {
  cat <<- _EOF_
    <h2>System Uptime</h2>
    <pre>$(uptime)</pre>
_EOF_
  return
}

report_disk_space () {
  cat <<- _EOF_
    <h2>Disk Space Utilization</h2>
    <pre>$(df -h)</pre>
_EOF_
  return
}

report_home_space () {
  if [[ $(id -u) -eq 0 ]]; then
    cat <<- _EOF_
      <h2>Home Space Utilization (All Users)</h2>
      <pre>$(du -sh /home/*)</pre>
_EOF_
  else
    cat <<- _EOF_
      <h2>Home Space Utilization (${USER})</h2>
      <pre>$(du -sh $HOME)</pre>
_EOF_
  fi
  return
}

usage () {
  echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
  return
}

write_html_page () {
  cat <<- _EOF_
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>$TITLE</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f9f9f9;
      color: #333;
      margin: 40px;
      line-height: 1.6;
    }
    h1 {
      color: #1e90ff;
      border-bottom: 2px solid #ccc;
      padding-bottom: 10px;
    }
    h2 {
      color: #333;
      margin-top: 30px;
      border-left: 5px solid #1e90ff;
      padding-left: 10px;
    }
    pre {
      background-color: #f4f4f4;
      border: 1px solid #ddd;
      padding: 15px;
      border-radius: 5px;
      overflow-x: auto;
      font-family: monospace;
    }
    p {
      color: #555;
      font-style: italic;
    }
  </style>
</head>
<body>
  <h1>$TITLE</h1>
  <p>$TIMESTAMP</p>
  $(report_uptime)
  $(report_disk_space)
  $(report_home_space)
</body>
</html>
_EOF_
  return
}

interactive=
filename=

while [[ -n $1 ]]; do
  case $1 in
    -f | --file)       shift
                       filename=$1
                       ;;
    -i | --interactive) interactive=1
                       ;;
    -h | --help)       usage
                       exit
                       ;;
    *)                 usage >&2
                       exit 1
                       ;;
  esac
  shift
done

# interactive mode
if [[ -n $interactive ]]; then
  while true; do
    read -p "Enter name of output file: " filename
    if [[ -e $filename ]]; then
      read -p "'$filename' exists. Overwrite? [y/n/q] > "
      case $REPLY in
        Y|y) break
             ;;
        Q|q) echo "Program terminated."
             exit
             ;;
        *)   continue
             ;;
      esac
    else
      break
    fi
  done
fi

# output html page
if [[ -n $filename ]]; then
  if touch $filename && [[ -f $filename ]]; then
    write_html_page > $filename
    xdg-open $filename &
  else
    echo "$PROGNAME: Cannot write file '$filename'" >&2
    exit 1
  fi
else
  write_html_page > sys_info_page.html
  xdg-open sys_info_page.html &
fi
