# System_Info_Generator
# 🖥️ System Information Page Generator (Shell Script)

This repository contains a Bash script that generates a comprehensive and beautifully formatted **HTML system information report**.

The script runs on both **Linux (Ubuntu)** and **macOS** with two variant versions available. It gathers real-time system data like uptime, disk usage, and user home directory space usage, and outputs them in a styled HTML page for easy viewing in any browser.

---

## 📌 Features

- 📄 Generates a clean, readable **HTML report** with system details
- 🕒 Displays **system uptime** using the `uptime` command
- 💾 Shows **disk space usage** using `df -h`
- 🏠 Reports **home directory usage**:
  - For root users: Shows space used by all users in `/home/`
  - For regular users: Shows only their own home usage
- 🧠 Interactive mode support (asks before overwriting files)
- 📁 Supports custom output filename using `-f` flag
- 🚀 Opens the generated HTML file automatically in the default browser
- ✅ Works on both **macOS** and **Ubuntu Linux**
- 💅 Stylish HTML output with CSS for improved readability

---

## 🧪 Sample Output

The output HTML page includes:

- Title: `System Information Report For <hostname>`
- Timestamp: Date, time, and user who generated the report
- System Uptime section
- Disk Space Utilization section
- Home Space Utilization section

Example:
```html
<h2>System Uptime</h2>
<pre>14:10  up 1 day,  3:22, 2 users, load averages: 1.22 1.12 1.09</pre>
