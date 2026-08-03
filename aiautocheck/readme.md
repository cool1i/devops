# AI Auto Inspection

> 用友 NC / NC Cloud / BIP + 数据库（Oracle、DM、MySQL、PostgreSQL、Kingbase、Vastbase）AI 自动巡检平台

## 项目简介

AI Auto Inspection 是一套面向企业运维的智能巡检脚本，支持自动采集服务器、数据库、中间件及用友 NC 系统运行状态，并结合 AI 对巡检结果进行分析，自动生成健康评分、风险诊断、优化建议及巡检报告。

项目目标：

- 自动巡检（One Click）
- AI 智能分析
- 自动生成巡检报告
- 自动发现风险
- 自动输出优化建议
- 支持持续巡检

---

# 功能规划

## 系统巡检

支持 Linux（CentOS、Rocky、AlmaLinux、openEuler、银河麒麟、统信UOS 等）

### CPU

- CPU型号
- CPU核心数
- CPU利用率
- Load Average
- CPU Top进程

### 内存

- 总内存
- 已使用内存
- 空闲内存
- Swap使用率
- OOM检查

### 磁盘

- 磁盘容量
- 使用率
- inode使用率
- 大文件扫描
- IO等待
- 磁盘健康状态

### 网络

- 网络带宽
- TCP连接数
- TIME_WAIT数量
- CLOSE_WAIT数量
- 网络错误统计
- DNS解析测试

### 系统

- 系统版本
- 内核版本
- 启动时间
- 时区
- NTP同步状态
- 文件句柄
- 最大进程数
- SELinux
- Firewalld

---

# 数据库巡检

支持

- Oracle
- 达梦 DM8
- MySQL
- PostgreSQL
- Kingbase
- Vastbase

## Oracle

### 基础信息

- 数据库版本
- 实例状态
- Listener状态
- 数据库角色
- RAC状态
- DataGuard状态

### 存储

- Tablespace使用率
- Undo使用率
- Temp使用率
- ASM空间
- FRA空间

### 性能

- Top SQL
- 等待事件
- Buffer Cache命中率
- Library Cache命中率
- PGA
- SGA
- Session数量
- Process数量

### 风险检查

- Block Session
- 死锁
- 无效对象
- Alert Log异常
- Archive异常
- RMAN备份状态
- Datafile状态
- ASM Disk状态

---

## 达梦 DM

支持

- 数据库状态
- 会话数
- 锁等待
- Buffer命中率
- 表空间
- 日志
- 慢SQL
- Backup状态
- Archive状态

---

## MySQL

支持

- 主从状态
- 慢SQL
- InnoDB状态
- Buffer Pool
- 连接数
- 锁等待
- Binlog
- 主键缺失检查

---

# NC系统巡检

支持

- NC65
- NC Cloud
- YonBIP

---

## Java

检查内容：

- Java版本
- JVM参数
- Heap
- GC次数
- GC耗时
- Full GC
- Thread数量
- DeadLock检测

---

## WebSphere

支持检查

- JVM
- Cluster
- DCS
- Session
- Heap
- 日志异常
- JDBC连接池
- JMS

---

## Tomcat

支持

- Connector
- ThreadPool
- Heap
- Session
- Access Log
- Error Log

---

## Nginx

支持

- 配置检查
- HTTPS
- HTTP2
- Brotli
- Gzip
- KeepAlive
- Proxy
- SSL证书
- Rewrite

---

## Redis

检查

- Memory
- Hit Rate
- 慢查询
- AOF
- RDB
- 主从状态
- Sentinel

---

## Kafka

检查

- Broker状态
- Topic
- Consumer Lag
- ISR
- Controller
- 副本同步

---

## RabbitMQ

检查

- Queue
- Exchange
- Connection
- Channel
- Memory
- Disk Alarm

---

# NC专项检查

## 数据源

- 数据源连接
- 连接池
- 泄漏检测

## License

检查授权状态

## 上传目录

检查

- upload
- temp
- logs

权限及容量

---

## 日志分析

自动分析

- ERROR
- Exception
- OutOfMemory
- Deadlock
- Timeout
- Connection Refused

自动输出风险摘要

---

# AI 智能分析

巡检完成后，将所有结果交由 AI 进行分析。

AI 自动完成：

- 健康评分（100分制）
- 风险等级
- 根因分析
- 风险排序
- 优化建议
- 运维建议
- SQL优化建议
- JVM优化建议
- 参数优化建议

输出示例：

```
综合评分：92

风险等级：低

存在问题：

1. Oracle TEMP使用率92%

建议：

增加Temp Tablespace容量。

----------------------------

2. JVM Heap使用率96%

建议：

优化Heap配置。

----------------------------

3. 存在3条慢SQL

建议：

建立索引。

预计响应时间可下降35%。
```

---

# 自动生成报告

支持输出

- Markdown
- HTML
- Word
- PDF

报告内容包括：

- 巡检摘要
- 健康评分
- 风险分析
- 巡检详情
- 优化建议
- 趋势分析

---

# 项目结构

```
ai-auto-inspection/
│
├── scripts/
│   ├── linux/
│   ├── oracle/
│   ├── dm/
│   ├── mysql/
│   ├── postgres/
│   ├── kingbase/
│   ├── vastbase/
│   ├── nc/
│   ├── middleware/
│   └── common/
│
├── templates/
│
├── reports/
│
├── config/
│
├── docs/
│
├── output/
│
├── logs/
│
├── README.md
└── LICENSE
```

---

# Roadmap

## v1.0

- Linux巡检
- Oracle巡检
- 达梦巡检
- NC巡检
- HTML报告

---

## v2.0

- AI智能分析
- 自动评分
- Word报告
- PDF报告

---

## v3.0

- Web页面
- 定时巡检
- 微信机器人通知
- 企业微信通知
- 钉钉通知

---

## v4.0

- AI自动诊断
- AI自动修复建议
- MCP工具集成
- RAG知识库
- 历史趋势分析

---

# 开源协议

MIT License

---

# 作者

**AI Auto Inspection**

Enterprise AI Operations Platform

让巡检更智能，让运维更简单。