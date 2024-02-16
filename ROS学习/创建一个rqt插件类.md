### 创建一个rqt插件类

首先要找到一个插件基类，然后继承该插件基类，然后再用pluginlib注册到插件库里

```
PLUGINLIB_EXPORT_CLASS(rm_device_analyzer::rmEcatAnalyzer, diagnostic_aggregator::Analyzer)
```

- 首先要实现一个analyzer
- 然后再实现一个analyzer_aggregator，接收相关topic的诊断信息，analyzer发布分析出来的消息，然后由rqt_minitor来查看

