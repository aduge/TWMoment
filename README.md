# TWMoment
swift仿微信朋友圈

1. 基于swift 4.2，Xcode 10.1 实现，没有采用第三方库。  
2. 网络请求和图片请求采用GCD方式。
3. 图片缓存，请求图片时，先查找本地沙盒文件系统，如果存在就直接读取，如果还不存在，就启动线程进行下载，下载完毕后存入磁盘中，最后在主线程设置图片。  
4. TableView原生下拉刷信。
5. 源码地址：https://github.com/aduge/TWMoment.git，方便查看提交记录。
6. 添加了单元测试。