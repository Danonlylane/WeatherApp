## 天气查询APP开发报告

### 1. 预期页面

- 首页：

  <img src="https://tva1.sinaimg.cn/large/008i3skNgy1guv7kfnxvsj60gs0ykgme02.jpg" style="zoom:33%;" />

- 搜索页：

  <img src="https://tva1.sinaimg.cn/large/008i3skNgy1guv7jt6d7tj60gy0yogm902.jpg" style="zoom:33%;" />

- 页面分析：

  - 首页：右上角是一个button，按下之后跳转到搜索页。采用Apple自带的矢量搜索图标。它的下方是一个Label，显示当前城市温度，中间是一个天气状况的图片，根据查询城市不同的天气显示不同的天气图片。最下方显示的是当前的城市
  - 搜索页：最上一行是由两个Label组成，一个固定是“当前城市”，右边就显示和首页左下角相同的城市名字。这两个Label放在一个Stack View里面。中间是一个Text Field，最下方是一个查询天气的按钮。中间的Text Field和下面的button放在一个垂直的Stack View里面。

- 首页跳转搜索页的方法：

  - 选中首页的搜索框，control拖进搜索页，选中第三个Present Modally，意思就是从下到上弹出页面。第一个shou的意思就是从右到左弹出的意思。

    <img src="https://tva1.sinaimg.cn/large/008i3skNgy1guv84sgvt6j60u00ve3zx02.jpg" style="zoom:25%;" />

  - 弹出搜索框显示全屏：

    - 先选中左边连接点，再将Presentation改为Full Screen

    <img src="https://tva1.sinaimg.cn/large/008i3skNgy1guv88vio4fj60u00x2ta002.jpg" style="zoom:25%;" />

- 安装第三方库

  - 使用第三方库Alamofire

  - 1. 安装好cocospods之后，命令行进入当前目录下面，然后`pod init`初始化一个profile文件，在文件里面引入要安装的第三方库，保存，回到命令行`pod install`

  - 创建搜索页对应的class，点击new，选中Cocoa Touch Class进行创建

    <img src="https://tva1.sinaimg.cn/large/008i3skNgy1guvfxd76m2j60u00lwta902.jpg" style="zoom:35%;" />

  



### 2. 功能实现：

#### 2.1 获取用户当前位置

- 1. 在首页对应的class引入CoreLocation这个包，实例化一个位置管理器

  ```swift
  //位置管理器
  let locationManager = CLLocationManager()
  
  //页面加载时
  locationManager.requestWhenInUseAuthorization()
  ```

- 2. 在Info.plist里面添加如下描述，才可以使用定位服务

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1guv8omeyw5j611e04udgi02.jpg" style="zoom:25%;" />





- 3. 使用delegate获取用户当前城市位置

  ```swift
  // 协议：CLLocationManagerDelegate
  // locationManager.delegate = self这句话的意思就是locationManager的代理就是这个类本身
  // 因为要代理协议，重写里面的方法才能使用这个协议
  class ViewController: UIViewController, CLLocationManagerDelegate{
   
      let locationManager = CLLocationManager()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
          
          locationManager.requestWhenInUseAuthorization()
          
          locationManager.delegate = self
          locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
          locationManager.requestLocation()
      }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      }
    
    	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      }
  ```

  

- 4. 然后将首页的访问地理位置获得的城市名传递给搜索页的当前城市

  ```swift
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
          // 在跳转之前，需要准备一些数据
          if let vc = segue.destination as? QueryViewController { // 判断跳转的是否是搜索页
              vc.currentCity = weather.city
              vc.delegate = self
          }
      }
  ```

- 5. 跳转到搜索页之后，用户点击输入框，输入城市名，这时候要把用户输入的城市名返回给首页，这里先在搜索页定义一个协议

  ```
  protocol QueryViewControllerDelegate {
      func didChangeCity(city: String)
  }
  ```

- 6.然后在首页用和第3步的步骤代理这个协议进行反向传值

- 7.拿到城市文本和天气信息之后显示在首页
