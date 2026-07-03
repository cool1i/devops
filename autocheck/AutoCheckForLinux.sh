#!/bin/bash
# ---------------------------------------------------------
# 通用Linux服务器巡检脚本（增强版，兼容麒麟等国产系统）
# 功能: CPU/内存/磁盘/网络/进程/端口/启动时间/登录用户/历史IO/日志/安全等
# 输出: <项目名>_YYYYMMDD_HHMMSS.html
# 用户: root 或运维用户
# ---------------------------------------------------------

# 交互输入项目名称
read -p "请输入巡检项目名称: " PROJECT_NAME

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
REPORT="${PROJECT_NAME}_${TIMESTAMP}.html"

# HTML头部
cat <<EOF > $REPORT
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>${PROJECT_NAME} 巡检报告</title>
<style>
body { font-family: Arial, sans-serif; line-height: 1.5; }
h2 { background-color: #f2f2f2; padding: 5px; }
pre { background-color: #eee; padding: 10px; overflow-x: auto; }
</style>
</head>
<body>
<h1>${PROJECT_NAME} 巡检报告</h1>
<p>生成时间: $(date)</p>
<hr>
EOF

# -----------------------------
add_section() {
    TITLE=$1
    CONTENT=$2
    echo "<h2>$TITLE</h2>" >> $REPORT
    echo "<pre>$CONTENT</pre>" >> $REPORT
}

# ========== 系统基本信息 ==========
add_section "主机名" "$(hostname)"
add_section "内核版本" "$(uname -r)"
add_section "操作系统版本" "$(cat /etc/os-release 2>/dev/null)"
add_section "CPU 架构" "$(lscpu 2>/dev/null | grep 'Architecture')"
add_section "CPU 信息" "$(lscpu 2>/dev/null | grep 'Model name')"
add_section "物理 CPU 数" "$(lscpu | grep 'Socket(s)' | awk '{print $2}')"
add_section "逻辑 CPU 数" "$(nproc)"

# ========== CPU ==========
CPU_USAGE=$(top -b -n1 | grep "Cpu(s)" | awk '{usage=100-$8; printf "%.2f", usage}')
add_section "CPU 使用率" "CPU 总使用率: $CPU_USAGE%"
add_section "CPU 负载" "$(uptime)"
add_section "CPU 上下文切换" "$(vmstat 1 5)"

# ========== 内存 ==========
add_section "内存使用情况" "$(free -h)"
add_section "Swap 使用情况" "$(swapon -s)"
add_section "历史内存使用 (sar)" "$(sar -r 1 3 2>/dev/null || echo 'sar 未安装')"

# ========== 磁盘 ==========
add_section "磁盘使用情况" "$(df -hT)"
add_section "磁盘分区情况" "$(lsblk)"
add_section "磁盘 inode 使用" "$(df -i)"
add_section "磁盘 IO (iostat)" "$(iostat -dx 1 3 2>/dev/null || echo 'iostat 未安装')"
add_section "历史 IO (sar)" "$(sar -b 1 3 2>/dev/null || echo 'sar 未安装')"

# ========== 网络 ==========
add_section "网络流量统计" "$(cat /proc/net/dev | grep -v lo)"
add_section "网络连接状态" "$(ss -s)"
add_section "路由表" "$(ip route)"
add_section "防火墙状态" "$(iptables -L 2>/dev/null || firewall-cmd --state 2>/dev/null || echo '无防火墙或命令不可用')"

# ========== 进程 ==========
add_section "Top 5 CPU 占用进程" "$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6)"
add_section "Top 5 内存占用进程" "$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6)"
add_section "僵尸进程" "$(ps aux | awk '{ if ($8 ~ /Z/) print }')"

# ========== 系统信息 ==========
add_section "系统启动时间" "$(uptime -s)"
add_section "系统运行时长" "$(uptime -p)"
add_section "当前登录用户" "$(who)"
add_section "历史登录用户" "$(last -n 10)"

# ========== 安全 ==========
add_section "关键端口监听" "$(ss -tunlp | grep -E ':22|:80|:443|:1521|:3306|:8080')"
add_section "密码策略" "$(cat /etc/login.defs | grep PASS)"
add_section "sudoers 配置" "$(grep -v '^#' /etc/sudoers | grep ALL)"
add_section "系统服务状态" "$(systemctl list-unit-files --type=service --state=enabled)"
add_section "异常登录尝试" "$(grep 'Failed password' /var/log/secure 2>/dev/null | tail -n 20 || journalctl -u sshd -n 20 2>/dev/null)"

# ========== 系统日志 ==========
add_section "系统最近错误日志" "$(dmesg | tail -n 20)"
add_section "系统严重错误 (journalctl)" "$(journalctl -p 3 -n 20 2>/dev/null || echo 'journalctl 不可用')"
add_section "关键日志 (error/warn)" "$(grep -iE 'error|fail|warn' /var/log/messages 2>/dev/null | tail -n 20 || echo '无相关日志')"

# ========== 其他常用检查 ==========
add_section "时区与时间同步" "$(timedatectl 2>/dev/null || date)"
add_section "NTP 状态" "$(chronyc tracking 2>/dev/null || ntpq -p 2>/dev/null || echo 'NTP 未配置')"
add_section "SELinux 状态" "$(getenforce 2>/dev/null || echo '未安装 SELinux')"
add_section "系统负载测试 (vmstat)" "$(vmstat 1 5)"
add_section "硬件信息 (dmidecode)" "$(dmidecode -t system 2>/dev/null | grep -E 'Manufacturer|Product' || echo 'dmidecode 未安装')"

# HTML尾部
cat <<EOF >> $REPORT
<hr>
<p>巡检完成</p>
</body>
</html>
EOF

echo "HTML巡检报告生成完成: $REPORT"

