////
////  ViewController.swift
////  MySwiftTemplate
////
////  Created by apple on 10/5/2017.
////  Copyright © 2017 apple. All rights reserved.
////
//
//import UIKit
//import Alamofire
//
//class NSCandidateListTouchBarItem<CandidateType: AnyObject> : UITabBarItem {
//    var client: (UIView & UITextInput)?
//}
//
//import RealmSwift
////import Kingfisher
//
////MARK:Realm Object定义
//// Define your models like regular Swift classes
//class Dog: Object {
//    @objc dynamic var name = ""
//    @objc dynamic var age = 0
//    let owners = LinkingObjects(fromType: Person.self, property: "dogs")
//}
//
//class Person: Object {
//    @objc dynamic var name = ""
//    @objc dynamic var picture: Data? = nil // optionals supported
//    let dogs = List<Dog>()
//}
//
//class EncryptionObject: Object {
//    @objc dynamic var stringProp = ""
//}
//
//class DemoObject: Object {
//    @objc dynamic var title = ""
//    @objc dynamic var date = NSDate()
//    @objc dynamic var sectionTitle = ""
//}
//
//
class ViewController: BaseViewController {
    
//
//    @IBOutlet weak var mtableview: UITableView!
//
//    var notificationToken: NotificationToken?
    
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        testRealmSwift()
    }
}
//
//extension ViewController : UITableViewDelegate {
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selecte \(indexPath)")
//        //        let cell = tableView.cellForRow(at: indexPath)
//        //        btnTap(cell!)
//        //        TouchIDShared.touchID("来解锁呀")
//
//        //        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "second")
//        //        self.navigationController?.present(secondVC!, animated: true, completion:nil)
//
//        //        request("https://httpbin.org/get")
//        //        testRealmSwift()
//
//    }
//}
//
//
//extension ViewController : UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(indexPath)"
//        self.registerForPreviewing(with: self, sourceView: cell)
//        return cell
//    }
//
//    func testRealmSwift() {
//        //        testRealmSwift1()
//        //        testBacklink()
//        testtNotify()
//    }
//
//    //    func testRealmSwift1() {
//    //        let fileURL = FileManager.default
//    //            .containerURL(forSecurityApplicationGroupIdentifier: "group.io.realm.examples.extension")!
//    //            .appendingPathComponent("Library/Caches/default.realm")
//    //
//    //        let realm = try! Realm()
//    //
//    //        // Get our Realm file's parent directory
//    //        let folderPath = realm.configuration.fileURL!.deletingLastPathComponent().path
//    //
//    //        // Disable file protection for this directory
//    //
//    //
//    //        try! FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.none],ofItemAtPath: folderPath)
//    //
//    //    }
//
//    func clearRealm() {
//        do {
//            let url = Realm.Configuration.defaultConfiguration.fileURL!
//            print("realm url \(url)")
//            try FileManager.default.removeItem(at: url)
//        } catch {
//
//        }
//    }
//
//    func testBacklink(){
//        clearRealm()
//
//        let realm = try! Realm()
//        try! realm.write {
//
//            realm.create(Person.self, value: ["John", [["Fido", 1]]])
//            realm.create(Person.self, value: ["Mary", [["Rex", 2]]])
//        }
//
//        // Log all dogs and their owners using the "owners" inverse relationship
//        let allDogs = realm.objects(Dog.self)
//        for dog in allDogs {
//            let ownerNames = dog.owners.map { $0.name }
//            print("\(dog.name) has \(ownerNames.count) owners (\(ownerNames))")
//        }
//    }
//
//    func testEncrypt() {
//
//        //        do {
//        //            let url = Realm.Configuration.defaultConfiguration.fileURL!
//        //            print("realm url \(url)")
//        //            try FileManager.default.removeItem(at: url)
//        //        } catch {
//        //
//        //        }
//
//        autoreleasepool {
//
//            let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
//            let realm = try! Realm(configuration: configuration)
//
//            // Add an object
//            try! realm.write {
//                let obj = EncryptionObject()
//                obj.stringProp = "abcd"
//                realm.add(obj)
//            }
//        }
//
//        // Opening with wrong key fails since it decrypts to the wrong thing
//        autoreleasepool {
//            do {
//                let configuration = Realm.Configuration(encryptionKey: "1234567890123456789012345678901234567890123456789012345678901234".data(using: String.Encoding.utf8, allowLossyConversion: false))
//                _ = try Realm(configuration: configuration)
//            } catch {
//                log(text: "Open with wrong key: \(error)")
//            }
//        }
//
//        // Opening wihout supplying a key at all fails
//        autoreleasepool {
//            do {
//                _ = try Realm()
//            } catch {
//                log(text: "Open with no key: \(error)")
//            }
//        }
//
//        // Reopening with the correct key works and can read the data
//        autoreleasepool {
//            let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
//            let realm = try! Realm(configuration: configuration)
//            if let stringProp = realm.objects(EncryptionObject.self).first?.stringProp {
//                log(text: "Saved object: \(stringProp)")
//            }
//        }
//
//        func log(text: String) {
//            print(text)
//        }
//
//        func getKey() -> NSData {
//            // Identifier for our keychain entry - should be unique for your application
//            let keychainIdentifier = "io.Realm.EncryptionExampleKey"
//            //允许 有损耗的 false
//            let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
//
//            // First check in the keychain for an existing key
//            var query: [NSString: AnyObject] = [
//                kSecClass: kSecClassKey,
//                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
//                kSecAttrKeySizeInBits: 512 as AnyObject,
//                kSecReturnData: true as AnyObject
//            ]
//
//            // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
//            // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
//            var dataTypeRef: AnyObject?
//
//            var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
//            if status == errSecSuccess {
//                return dataTypeRef as! NSData
//            }
//
//            // No pre-existing key from this application, so generate a new one
//            let keyData = NSMutableData(length: 64)!
//            let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
//            assert(result == 0, "Failed to get random bytes")
//
//            // Store the key in the keychain
//            query = [
//                kSecClass: kSecClassKey,
//                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
//                kSecAttrKeySizeInBits: 512 as AnyObject,
//                kSecValueData: keyData
//            ]
//
//            status = SecItemAdd(query as CFDictionary, nil)
//            assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
//
//            return keyData
//        }
//    }
//
//    func testtNotify() {
//        clearRealm()
//
//        var realm = try! Realm()        // Set realm notification block
//        notificationToken = realm.observe { [unowned self] note, realm in
//            print("changed crud")
//            self.notificationToken?.invalidate()
//        }
//
//        func backgroundAdd() {
//            // Import many items in a background thread
//            DispatchQueue.global().async {
//                // Get new realm and table since we are in a new thread
//                let realm = try! Realm()
//                realm.beginWrite()
//                for _ in 0..<5 {
//                    // Add row via dictionary. Order is ignored.
//                    realm.create(DemoObject.self, value: ["title": randomTitle(), "date": NSDate(), "sectionTitle": randomTitle()])
//                }
//                try! realm.commitWrite()
//            }
//        }
//
//        func add() {
//            try! realm.write {
//                realm.create(DemoObject.self, value: [randomTitle(), NSDate(), randomTitle()])
//            }
//        }
//
//        func randomTitle() -> String {
//            return "Title \(arc4random())"
//        }
//        backgroundAdd()
//    }
//
//    func testSimple() {
//        clearRealm()
//        // Create a standalone object
//        let mydog = Dog()
//
//        // Set & read properties
//        mydog.name = "Rex"
//        mydog.age = 9
//        print("Name of dog: \(mydog.name)")
//
//        // Realms are used to group data together
//        let realm = try! Realm() // Create realm pointing to default file
//
//        // Save your object
//        realm.beginWrite()
//        realm.add(mydog)
//        try! realm.commitWrite()
//
//
//        // Query
//        let results = realm.objects(Dog.self).filter(NSPredicate(format: "name contains 'x'"))
//
//        // Queries are chainable!
//        let results2 = results.filter("age > 8")
//        print("Number of dogs: \(results.count)")
//        print("Dogs older than eight: \(results2.count)")
//
//        // Link objects
//        let person = Person()
//        person.name = "Tim"
//        person.dogs.append(mydog)
//
//        try! realm.write {
//            realm.add(person)
//        }
//
//        // Multi-threading
//        DispatchQueue.global().async {
//            let otherRealm = try! Realm()
//            let otherResults = otherRealm.objects(Dog.self).filter(NSPredicate(format: "name contains 'Rex'"))
//            print("Number of dogs \(otherResults.count)")
//        }
//    }
//
//    func testBasic() {
//        // Use them like regular Swift objects
//        let myDog = Dog()
//        myDog.name = "Rex"
//        myDog.age = 1
//        print("name of dog: \(myDog.name)")
//
//        // Get the default Realm
//        let realm = try! Realm()
//
//        // Query Realm for all dogs less than 2 years old
//        let puppies = realm.objects(Dog.self).filter("age < 2")
//        print("puppies count \(puppies.count)")
//        // => 0 because no dogs have been added to the Realm yet
//
//        //持久化数据
//        try! realm.write {
//            realm.add(myDog)
//        }
//
//        // Queries are updated in realtime
//        print("puppies count \(puppies.count)")
//        // => 1
//
//        // Query and update from any thread
//        DispatchQueue(label: "background").async {
//            autoreleasepool {
//                let realm = try! Realm()
//                let theDog = realm.objects(Dog.self).filter("age == 1").first
//                try! realm.write {
//                    theDog!.age = 3
//                }
//            }
//        }
//    }
//
//    func setDefaultRealmForUser(username: String) {
//        var config = Realm.Configuration()
//
//        // Use the default directory, but replace the filename with the username
//        config.fileURL = config.fileURL!.deletingLastPathComponent()
//            .appendingPathComponent("\(username).realm")
//
//        // Set this as the configuration used for the default Realm
//        Realm.Configuration.defaultConfiguration = config
//
//        //        let config = Realm.Configuration(
//        //            // Get the URL to the bundled file
//        //            fileURL: Bundle.main.url(forResource: "MyBundledData", withExtension: "realm"),
//        //            // Open the file in read-only mode as application bundles are not writeable
//        //            readOnly: true)
//        //
//        //        // Open the Realm with the configuration¡™£
//        //        let realm = try! Realm(configuration: config)
//        //
//        //        // Read some data from the bundled Realm
//        //        let results = realm.objects(Dog.self).filter("age > 5")
//    }
//}
//
//
//extension ViewController : UIPopoverPresentationControllerDelegate {
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        /*
//         case fullScreen
//         case pageSheet
//         case formSheet
//         case currentContext
//         case custom
//         case overFullScreen
//         case overCurrentContext
//         case popover
//         case none
//         */
//        return .none //不适配
//    }
//
//    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
//        return true //点击蒙版popover消失， 默认YES
//    }
//
//    func btnTap(_ sender: UIView) {
//        let testVC = self.storyboard?.instantiateViewController(withIdentifier: "second")
//        //设置显示的大小
//        testVC!.preferredContentSize = CGSize(width: 300, height: 200)
//        //设置presentation时的style
//        testVC!.modalPresentationStyle = .popover
//        //需要通过sourceView来判断位置
//        testVC!.popoverPresentationController?.sourceView = sender
//        // 指定箭头所指区域的矩形框范围（位置和尺寸）,以sourceView的左上角为坐标原点
//        // 这个可以 通过 Point 或  Size 调试位置
//        let bounds = sender.bounds
//        testVC!.popoverPresentationController?.sourceRect = bounds.offsetBy(dx: 20, dy: 30)
//        //箭头方向
//        testVC!.popoverPresentationController?.permittedArrowDirections = .down
//        testVC!.popoverPresentationController?.delegate = self
//        self.navigationController?.present(testVC!, animated: true, completion: {
//            print("present complete")
//        })
//    }
//}
//
//extension ViewController : UIViewControllerPreviewingDelegate {
//    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        let childVC = self.storyboard?.instantiateViewController(withIdentifier: "second")
//        childVC!.preferredContentSize = CGSize(width: 60, height: 200)
//
//        let rect = previewingContext.sourceView.bounds
//        previewingContext.sourceRect = rect.offsetBy(dx: 0, dy: -1)
//        return childVC!
//    }
//
//    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        self.navigationController?.present(viewControllerToCommit, animated: true, completion: {
//            print("present complete")
//        })
//    }
//}


//        super.viewDidLoad()
//        //testMyRequest()
//        //groupRequest()
//        //        setupUI()
////        testRxSwift()
////        testMoya()
//        //testSwift42()
//        test2222()
//
//        //        __NetworkManager.request("http://api.ceshi.xin.com/special_config/ab_test", success: { (result) in
//        //            print("success result \(result ?? "")")
//        //        }) { (result) in
//        //            print("failt result \(result ?? "")")
//        //        }
//    }
//
//    private func testRxSwift() {
//
//        //Observable<Element>是一个观察者模式中被观察的对象，相当于一个事件序列，会向订阅者发送新产生的事件信息。
//
//        //1 Sequence把一系列元素转换为事件序列
//
//        //2 AnonymousObservable继承自Producer，Producer实现了线程调度功能，可以安排线程来执行run方法，因此AnonymousObservable是可以运行在指定线程中Observable。
//
//        //3 Error，顾名思义，是做错误处理的，创建一个不发送任何 item 的 Observable。
//
//        //4 deferred会等到有订阅者的时候再通过工厂方法创建Observable对象，每个订阅者订阅的对象都是内容相同而完全独立的序列
//
//        //5 empty创建一个空的序列。它仅仅发送.Completed消息
//
//        //6 never创建一个序列，该序列永远不会发送消息，.Complete消息也不会发送
//
//        //7 just代表只包含一个元素的序列。它将向订阅者发送两个消息，第一个消息是其中元素的值，另一个是.Completed
//
//        //8 PublishSubject会发送订阅者从订阅之后的事件序列
//
//        //9 ReplaySubject在新的订阅对象订阅的时候会补发所有已经发送过的数据队列，bufferSize是缓存区的大小，决定了补发队列的最大值。如果bufferSize是1，那么新的订阅着出现的时候就会补发上一个事件，如果是2，则补两个，以此类推
//
//        //10 BehaviorSubject在新的订阅对象订阅的时候会发送最近发送的事件，如果没有则发送一个默认值
//
//        //11 variable是基于BehaviorSubject的一层封装，它的优势是：不会被显式终结。即：不会收到.Complete和.Error这类的终结事件，它会主动在析构的时候发送.Complete
//
//        //12 map就是对每个元素都用函数做一次转换，挨个映射一遍
//
//        //13 flatMap将每个Observable发射的数据变换为Observable的集合，然后将其降维排列成一个Observable
//
//        //14 scan对Observable发射的每一项数据应用一个函数，然后按顺序依次发射一个值
//
//        //15 filter只会让符合条件的元素通过
//
//        //16 distinctUntilChanged会废弃掉重复的事件
//
//        //17 take只获取序列中的前n个事件，在满足数量之后会自动.Completed
//
//        //Combination operators是关于序列的运算，可以将多个序列源进行组合，拼装成一个新的事件序列
//        //18 startWith会在队列开始之前插入一个事件元素
//
//        //CombineLatest如果存在两件事件队列，需要同时监听，那么每当有新的事件发生的时候，combineLatest会将每个队列的最新一个元素进行合并
//        //19
//
//        //20 zip合并两条队列，不过它会等到两个队列的元素一一对应地凑齐之后再合并
//
//        //21 merge合并多个Observables的组合成一个
//
//        //22 switchLatest将一个发射多个Observables的Observable转换成另一个单独的Observable，后者发射那些Observables最近发射的数据项
//
//        //23 catchError收到error通知之后，转而发送一个没有错误的序列
//
//        //24 retry，如果原始的Observable遇到错误，重新订阅
//
//        //25 subscribe前面已经接触到了，有新的事件就会触发
//        //subscribeNext subscribeCompleted subscribeError
//        //doOn注册一个操作来监听事件的生命周期
//
//        //26 takeUntil当第二个Observable发送数据之后，丢弃第一个Observable在这之后的所有信息
//
//        //27 takeWhile发送原始Observable的数据，直到一个特定的条件false
//
//        //28 reduce按顺序对Observable发射的每项数据应用一个函数并发射最终的值
//
//        //29 delay延迟操作
//
//        /*
//         Observable - 产生事件
//         Observer - 响应事件
//         Operator - 创建变化组合事件
//         Disposable - 管理绑定（订阅）的生命周期
//         Schedulers - 线程队列调配
//         */
//
//
//        /* 所有的事物都是序列 Single,Completable,Maybe,Driver
//         * Single 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件
//         * Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件
//         * Maybe 是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件
//         * Driver（司机？） 是一个精心准备的特征序列。它主要是为了简化 UI 层的代码
//         //遇到以下情况也可以使用Driver
//
//         任何可被监听的序列都可以被转换为 Driver，只要他满足 3 个条件：
//         不会产生 error 事件
//         一定在 MainScheduler 监听（主线程监听）
//         共享状态变化
//
//         * ControlEvent 专门用于描述 UI 控件所产生的事件
//         不会产生 error 事件
//         一定在 MainScheduler 订阅（主线程订阅）
//         一定在 MainScheduler 监听（主线程监听）
//         共享状态变化
//         *
//         *
//         * Event事件 有 next(Element),completed,error(Swift.Error)
//         */
//        rxSwifttest222();
//
//    }
//    private func rxSwifttest0() {
//        //创建可观察队列
//
//        //相应的方法
//        //        let observable = Observable<Int>.just(5)
//        //        let observable = Observable<String>.of("A","B","C")
//        //        let observable = Observable<String>.from(["A","B","C"])
//        //        let observable = Observable<Int>.empty()
//        //        let observable = Observable<Int>.never()
//
//        //error
//        //        enum MyError : Error {
//        //            case A
//        //            case B
//        //        }
//        //        let observable = Observable<Int>.error(MyError.A)
//
//        //        let observable = Observable<Int>.range(start: 1, count: 5)
//        //        let observable = Observable<Int>.of(1,2,3,4,5)
//        //        let observable = Observable<Int>.repeatElement(1)
//        //        let observable = Observable.generate(initialState: 0, condition: {$0 < 10}, iterate: {$0 + 2})
//
//        //create
//        //        let observable = Observable<String>.create{ observer in
//        //            observer.onNext("hangege.com")
//        //            observer.onCompleted()
//        //            return Disposables.create()
//        //        }
//
//        //deferred
//        //用于标记是奇数、还是偶数
//        //        var isOdd = true
//        //        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
//        //        let factory : Observable<Int> = Observable.deferred {
//        //            //让每次执行这个block时候都会让奇、偶数进行交替
//        //            isOdd = !isOdd
//        //            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
//        //            if isOdd {
//        //                return Observable.of(1, 3, 5 ,7)
//        //            }else {
//        //                return Observable.of(2, 4, 6, 8)
//        //            }
//        //        }
//        //
//        //        //第1次订阅测试
//        //        _ = factory.subscribe { event in
//        //            print("\(isOdd)", event)
//        //        }
//        //
//        //        //第2次订阅测试
//        //        _ = factory.subscribe { event in
//        //            print("\(isOdd)", event)
//        //        }
//
//        //intervale
//        //        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        //        observable.subscribe { event in
//        //            print(event)
//        //        }
//
//        //5秒种后发出唯一的一个元素0
//        //        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
//        //        observable.subscribe { event in
//        //            print(event)
//        //        }
//
//        //延时5秒种后，每隔1秒钟发出一个元素
//        //        let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
//        //        observable.subscribe { event in
//        //            print(event)
//        //        }
//
//    }
//
//    private func rxSwifttest1() {
//        let disposeBag = DisposeBag()
//        //创建观察者
//        let observable = Observable.of("A", "B", "C")
//        //        let subscription = observable.subscribe { event in
//        //                    print(event.element)
//        //                }
//        //        subscription.dispose()
//
//        _ = observable
//            .do(onNext: { element in
//                print("Intercepted Next：", element)
//            }, onError: { error in
//                print("Intercepted Error：", error)
//            }, onCompleted: {
//                print("Intercepted Completed")
//            }, onDispose: {
//                print("Intercepted Disposed")
//            })
//            .subscribe(onNext: { (element) in
//                print(element)
//            }, onError: { (error) in
//                print(error)
//            }, onCompleted: {
//                print("completed")
//            }, onDisposed: {
//                print("disposed")
//            })
//            .disposed(by: disposeBag)
//    }
//
//    private func rxSwifttest2() {
//        //在subscribe和bind方法中创建观察者
//
//        //        let observable = Observable.of("A","b","C")
//        //        observable.subscribe(onNext: { (element) in
//        //            print(element)
//        //        }, onError: { (error) in
//        //            print(error)
//        //        })
//
//        //        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        //        observable
//        //            .map { "当前索引: \($0)"}
//        //            .bind { [weak self](text) in
//        //                 print(text)
//        //        }
//
//        //使用AnyObserver
//        //        let observer: AnyObserver<String> = AnyObserver { (event) in
//        //            switch event {
//        //            case .next(let data):
//        //                print(data)
//        //            case .error(let error):
//        //                print(error)
//        //            case .completed:
//        //                print("Completed")
//        //            }
//        //        }
//        //        let observable = Observable.of("A","B","d","E")
//        //        observable.subscribe(observer)
//
//        //观察者
//        //        let observer: AnyObserver<String> = AnyObserver { (event) in
//        //            print(event)
//        //        }
//        //        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        //        observable
//        //            .map{"当前索引数:\($0)"}
//        //            .bind(to: observer)
//
//
//        //使用binder来创建
//
//    }
//
//    private func rxSwifttest3() {
//        //subjects和variable
//        let disposeBag = DisposeBag()
//
//        //        //创建一个publishSubject
//        //        let subject = PublishSubject<String>()
//        //        //由于当前没有任何订阅者,所以这条消息不会输出到控制台
//        //        subject.onNext("111")
//        //        //第一次订阅subject
//        //        subject.subscribe(onNext: { (string) in
//        //            print("第一次订阅: ",string)
//        //        }, onCompleted: {
//        //            print("第一次订阅: onCompleted")
//        //        }).disposed(by: disposeBag)
//        //
//        //        //当前有一个订阅,则该消息会输出到控制台
//        //        subject.onNext("2222")
//        //
//        //        //第二次订阅subject
//        //        subject.subscribe(onNext: { (string) in
//        //            print("第2次订阅: ",string)
//        //        }, onCompleted: {
//        //            print("第2次订阅: onCompleted")
//        //        }).disposed(by: disposeBag)
//        //
//        //        //当前有2个订阅,则该消息会输出到控制台
//        //        subject.onNext("333")
//        //        //让subject结束
//        //        subject.onCompleted()
//        //
//        //        //subject结束后不会发出.next事件了
//        //        subject.onNext("444")
//        //
//        //        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
//        //        subject.subscribe(onNext: { string in
//        //            print("第3次订阅：", string)
//        //        }, onCompleted:{
//        //            print("第3次订阅：onCompleted")
//        //        }).disposed(by: disposeBag)
//
//
//        //创建一个BehaviorSubject
//        //        let subject = BehaviorSubject(value: "111")
//        //        //第一次订阅该subject
//        //        subject.subscribe { (event) in
//        //            print("第1次订阅: ",event)
//        //        }.disposed(by: disposeBag)
//        //
//        //        //发送next事件
//        //        subject.onNext("222")
//        //        //发送error
//        //        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
//        //        //第2次订阅subject
//        //        subject.subscribe { (event) in
//        //            print("第2次订阅: ",event)
//        //        }.disposed(by: disposeBag)
//
//        //        //创建一个bufferSize为2的ReplaySubject
//        //        let subject = ReplaySubject<String>.create(bufferSize: 2)
//        //
//        //        //连续发送3个next事件
//        //        subject.onNext("111")
//        //        subject.onNext("222")
//        //        subject.onNext("333")
//        //
//        //        //第1次订阅subject
//        //        subject.subscribe { event in
//        //            print("第1次订阅：", event)
//        //            }.disposed(by: disposeBag)
//        //
//        //        //再发送1个next事件
//        //        subject.onNext("444")
//        //
//        //        //第2次订阅subject
//        //        subject.subscribe { event in
//        //            print("第2次订阅：", event)
//        //            }.disposed(by: disposeBag)
//        //
//        //        //让subject结束
//        //        subject.onCompleted()
//        //
//        //        //第3次订阅subject
//        //        subject.subscribe { event in
//        //            print("第3次订阅：", event)
//        //            }.disposed(by: disposeBag)
//
//        //创建一个初始值为111的Variable
//        let variable = Variable("111")
//
//        //修改value值
//        variable.value = "222"
//
//        //第1次订阅
//        variable.asObservable().subscribe {
//            print("第1次订阅：", $0)
//            }.disposed(by: disposeBag)
//
//        //修改value值
//        variable.value = "333"
//
//        //第2次订阅
//        variable.asObservable().subscribe {
//            print("第2次订阅：", $0)
//            }.disposed(by: disposeBag)
//
//        //修改value值
//        variable.value = "444"
//
//    }
//
//    //MARK:变换操作符
//    private func rxSwifttest4() {
//        //创建一个PublishSubject
//        //        let subject = PublishSubject<String>()
//
//        //MARK:buffer
//        //没缓存3个元素则组合起来一起发出
//        //如果1秒钟内不够3个也会发出(有几个发几个,一个也没有的话发空数组
//        //        subject
//        //            .buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
//        //            .subscribe(onNext: {print($0)})
//        //
//        //        subject.onNext("a")
//        //        subject.onNext("b")
//        //        subject.onNext("c")
//
//        //        subject.onNext("1")
//        //        subject.onNext("2")
//
//        //MARK:window
//        //每3个元素作为一个子Observable发出
//        //        subject
//        //        .window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
//        //            .subscribe(onNext: { [weak self] in
//        //                print("subscribe: \($0)")
//        //                $0.asObservable()
//        //                    .subscribe(onNext:{print("element \($0)")})
//        //                .disposed(by: self!.disposeBag)
//        //            })
//        //        .disposed(by: disposeBag)
//        //        subject.onNext("a")
//        //        subject.onNext("b")
//        //        subject.onNext("c")
//        //
//        //        subject.onNext("1")
//        //        subject.onNext("2")
//        //        subject.onNext("3")
//
//        //MARK:map
//        //        Observable.of(1,3,35,26)
//        //            .map { $0 * $0}
//        //            .subscribe(onNext: {print($0)})
//        //            .disposed(by: disposeBag)
//
//        //MARK:flatMap       接收所有的value的值
//        //MARK:flatMapLatest 只接收最新的value的值
//        //MARK:concatMap当前一个 Observable 元素发送完毕后，后一个Observable 才可以开始发出元素
//        //        let subject1 = BehaviorSubject(value: "A")
//        //        let subject2 = BehaviorSubject(value: "1")
//        //
//        //        let varable = Variable.init(subject1)
//        //        varable.asObservable()
//        //            .concatMap{$0}
//        //            .subscribe(onNext:{print($0)})
//        //            .disposed(by: disposeBag)
//        //
//        //        subject1.onNext("B")
//        //        varable.value = subject2
//        //
//        //        subject2.onNext("2")
//        //        subject1.onCompleted()
//        //        subject1.onNext("C")
//        //
//        //        subject2.onNext("3")
//        //        subject1.onNext("D")
//
//        //MARK:scan
//        //        Observable.of(1,3,5,6,2,6)
//        //            .scan(0) {
//        //                acum, elem in
//        //                acum + elem
//        //        }
//        //            .subscribe(onNext:{print($0)})
//        //        .disposed(by: disposeBag)
//
//        //MARK:groupBy
//        //将奇数偶数分成两组
//        //        Observable<Int>.of(0, 1, 2, 3, 4, 5)
//        //            .groupBy(keySelector: { (element) -> String in
//        //                return element % 2 == 0 ? "偶数" : "基数"
//        //            })
//        //            .subscribe { [weak self](event) in
//        //                switch event {
//        //                case .next(let group):
//        //                    group.asObservable().subscribe({ (event) in
//        //                        print("key：\(group.key)    event：\(event)")
//        //                    })
//        //                        .disposed(by: self!.disposeBag)
//        //                default:
//        //                    print("")
//        //                }
//        //            }
//        //            .disposed(by: disposeBag)
//    }
//    //MARK:（过滤操作符：filter、take、skip等）
//    private func rxSwifttest5() {
//        //MARK:filter
//        //        Observable.of(2, 30, 22, 5, 60, 3, 40 ,9)
//        //            .filter {
//        //                $0 > 10
//        //            }
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//
//        //MARK:distinctUntilChanged
//        //        Observable.of(1, 2, 3, 1, 1, 4)
//        //            .distinctUntilChanged()
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//
//        //MARK:single
//        //        Observable.of(1, 2, 3, 4)
//        //            .single{ $0 == 4 }
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        Observable.of("A", "B", "C", "D")
//        //            .single()
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//
//        //MARK:element
//        //        Observable.of(1,2,3,4)
//        //        .elementAt(2)
//        //            .subscribe(onNext: {print($0)})
//        //        .disposed(by: disposeBag)
//
//        //MARK:ignoreElements
//        //        Observable.of(1,2,3,4)
//        //        .ignoreElements()
//        //            .subscribe{print($0)}
//        //        .disposed(by: disposeBag)
//
//        //MARK:take,takeLast
//        //        Observable.of(1,2,3,4)
//        //        .takeLast(2)
//        //        .subscribe(onNext: { print($0) })
//        //        .disposed(by: disposeBag)
//
//        //MARK:skip
//        //        Observable.of(1,2,3,4)
//        //            .skip(2)
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//
//        //MARK:sample
//        //        let source = PublishSubject<Int>()
//        //        let notifier = PublishSubject<String>()
//        //
//        //        source
//        //            .sample(notifier)
//        //        .subscribe(onNext: { print($0) })
//        //        .disposed(by: disposeBag)
//        //
//        //        source.onNext(1)
//        //
//        //        notifier.onNext("A")
//        //
//        //        source.onNext(2)
//        //
//        //        notifier.onNext("B")
//        //        notifier.onNext("C")
//        //
//        //        source.onNext(3)
//        //        source.onNext(4)
//        //
//        //        notifier.onNext("D")
//        //        source.onNext(5)
//        //
//        //        notifier.onError(NSError.init(domain: "", code: 1, userInfo: ["A":"no message"]))
//
//        //MARK:debounce
//        //定义好每个事件里的值以及发送的时间
//        //        let times = [
//        //            [ "value": 1, "time": 0.1 ],
//        //            [ "value": 2, "time": 0.7 ],
//        //            [ "value": 3, "time": 1.1 ],
//        //            [ "value": 4, "time": 1.2 ],
//        //            [ "value": 5, "time": 1.4 ],
//        //            [ "value": 6, "time": 2.1 ],
//        //            [ "value": 7, "time": 2.3 ]
//        //        ]
//        //        //0-0.5 0.5-1.0 1.0-1.5
//        //        //0.1-0.6 0.6-1.1 1.1-1.6
//        //        //生成对应的 Observable 序列并订阅
//        //        Observable.from(times)
//        //            .flatMap { item in
//        //                return Observable.just(Int(item["value"]!)).delaySubscription(Double(item["time"]!), scheduler: MainScheduler.instance)
//        ////                return Observable.of(Int(item["value"]!))
//        ////                    .delaySubscription(Double(item["time"]!),scheduler: MainScheduler.instance)
//        //            }
//        //            .debounce(0.5, scheduler: MainScheduler.instance) //只发出与下一个间隔超过0.5秒的元素
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//
//
//        //MARK:
//
//    }
//
//    //MARK:条件和布尔操作符：amb、takeWhile、skipWhile等）5
//    private func rxSwifttest6() {
//        //MARK:amb
//        //        let subject1 = PublishSubject<Int>()
//        //        let subject2 = PublishSubject<Int>()
//        //        let subject3 = PublishSubject<Int>()
//        //
//        //        subject1
//        //            .amb(subject2)
//        //            .amb(subject3)
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        subject2.onNext(1)
//        //        subject1.onNext(20)
//        //        subject2.onNext(2)
//        //        subject1.onNext(40)
//        //        subject3.onNext(0)
//        //        subject2.onNext(3)
//        //        subject1.onNext(60)
//        //        subject3.onNext(0)
//        //        subject3.onNext(0)
//
//        //MARK:takewhile
//        //        Observable.of(2,3,4,5,6)
//        //        .takeWhile{$0 < 5}
//        //        .subscribe(onNext: { print($0) })
//        //        .disposed(by: disposeBag)
//
//        //MARK:takeUntil
//        //        let source = PublishSubject<String>()
//        //        let notifier = PublishSubject<String>()
//        //
//        //        source
//        //            .takeUntil(notifier)
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        source.onNext("a")
//        //        source.onNext("b")
//        //        source.onNext("c")
//        //        source.onNext("d")
//        //
//        //        //停止接收消息
//        //        notifier.onNext("z")
//        //
//        //        source.onNext("e")
//        //        source.onNext("f")
//        //        source.onNext("g")
//
//        //MARK:skipwhile
//        //        Observable.of(2,3,4,5,6)
//        //            .skipWhile{$0 < 4}
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//
//        //MARK:skipUntil
//        //        let source = PublishSubject<Int>()
//        //        let notifier = PublishSubject<Int>()
//        //
//        //        source
//        //            .skipUntil(notifier)
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        source.onNext(1)
//        //        source.onNext(2)
//        //        source.onNext(3)
//        //        source.onNext(4)
//        //        source.onNext(5)
//        //
//        //        //开始接收消息
//        //        notifier.onNext(0)
//        //
//        //        source.onNext(6)
//        //        source.onNext(7)
//        //        source.onNext(8)
//        //
//        //        //仍然接收消息
//        //        notifier.onNext(0)
//        //
//        //        source.onNext(9)
//    }
//
//    //MARK:结合操作符：startWith、merge、zip等 6
//    private func rxSwifttest7() {
//        //MARK:startWith
//        //        Observable.of("2","3")
//        //        .startWith("a")
//        //        .subscribe(onNext: { print($0) })
//        //        .disposed(by: disposeBag)
//
//        //MARK:merge
//        //        let subject1 = PublishSubject<Int>()
//        //        let subject2 = PublishSubject<Int>()
//        //
//        //        Observable.of(subject1, subject2)
//        //            .merge()
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        subject1.onNext(20)
//        //        subject1.onNext(40)
//        //        subject1.onNext(60)
//        //        subject2.onNext(1)
//        //        subject1.onNext(80)
//        //        subject1.onNext(100)
//        //        subject2.onNext(1)
//
//        //MARK:zip,combineLatest
//        //该方法同样是将多个（两个或两个以上的）Observable 序列元素进行合并。
//        //但与 zip 不同的是，每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并
//        //        let subject1 = PublishSubject<Int>()
//        //        let subject2 = PublishSubject<String>()
//        //
//        //        Observable.combineLatest(subject1,subject2) {
//        //            "\($0)\($1)"
//        //            }.subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //        subject1.onNext(1)
//        //        subject2.onNext("A")
//        //        subject1.onNext(2)
//        //        subject2.onNext("B")
//        //        subject2.onNext("C")
//        //        subject2.onNext("D")
//        //        subject1.onNext(3)
//        //        subject1.onNext(4)
//        //        subject1.onNext(5)
//        //        subject2.onNext("E")
//        //        subject2.onNext("F")
//
//        //MARK:withLatestFrom
//        //        let subject1 = PublishSubject<String>()
//        //        let subject2 = PublishSubject<String>()
//        //
//        //        subject1.withLatestFrom(subject2)
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        subject1.onNext("A")
//        //        subject2.onNext("1")
//        //
//        //        subject1.onNext("B")
//        //        subject1.onNext("C")
//        //        subject2.onNext("2")
//        //
//        //        subject1.onNext("D")
//
//        //MARK:switchLatest
//        let subject1 = BehaviorSubject(value: "A")
//        let subject2 = BehaviorSubject(value: "1")
//
//        let variable = Variable(subject1)
//
//        variable.asObservable()
//            .switchLatest()
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
//
//        subject1.onNext("B")
//        subject1.onNext("C")
//
//        //改变事件源
//        variable.value = subject2
//        subject1.onNext("D")
//        subject1.onNext("F")
//        subject2.onNext("2")
//
//        //改变事件源
//        variable.value = subject1
//        subject2.onNext("3")
//        subject1.onNext("E")
//    }
//
//    //MARK:算数&聚合操作符
//    private func rxSwifttest8() {
//        //MARK:toArray
//        //        Observable.of(1,2,3)
//        //        .toArray()
//        //            .subscribe(onNext:{print($0)})
//        //            .disposed(by: disposeBag)
//
//        //MARK:reduce
//        //        Observable.of(1,2,3,4,5,6)
//        //        .reduce(0, accumulator: +)
//        //        .subscribe(onNext:{print($0)})
//        //        .disposed(by: disposeBag)
//
//        //MARK:concat
//        //这种情况下是和 switchLatest达到了差不多相同的效果
//        let subject1 = BehaviorSubject(value: 1)
//        let subject2 = BehaviorSubject(value: 3)
//        let variable = Variable(subject1)
//        variable.asObservable()
//            .concat()
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
//
//        subject2.onNext(4)
//        subject1.onNext(1)
//        subject1.onNext(1)
//        subject1.onCompleted()
//
//        variable.value = subject2
//        subject2.onNext(2)
//
//    }
//
//    private func rxSwifttest9() {
//        //MARK:publish 该序列不会立刻发送事件，只有在调用 connect 之后才会开始
//        //MARK:replay还可以buffer几个元素
//        //每隔1秒钟发送1个事件
//        //        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(2)
//        //        //第一个订阅者（立刻开始订阅）
//        //        _ = interval.subscribe(onNext: { print("订阅1: \($0)") })
//        //        //相当于把事件消息推迟了两秒
//        //        delay(2) {
//        //            _ = interval.connect()
//        //        }
//        //
//        //        //第二个订阅者（延迟5秒开始订阅）
//        //        delay(5) {
//        //            _ = interval
//        //                .subscribe(onNext: { print("订阅2: \($0)") })
//        //        }
//
//        //MARK:multicast
//        //创建一个Subject（后面的multicast()方法中传入）
//        //        let subject = PublishSubject<Int>()
//        //
//        //        //这个Subject的订阅
//        //        _ = subject
//        //            .subscribe(onNext: { print("Subject: \($0)") })
//        //
//        //        //每隔1秒钟发送1个事件
//        //        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        //            .multicast(subject)
//        //
//        //        //第一个订阅者（立刻开始订阅）
//        //        _ = interval
//        //            .subscribe(onNext: { print("订阅1: \($0)") })
//        //
//        //        //相当于把事件消息推迟了两秒
//        //        delay(2) {
//        //            _ = interval.connect()
//        //        }
//        //
//        //        //第二个订阅者（延迟5秒开始订阅）
//        //        delay(5) {
//        //            _ = interval
//        //                .subscribe(onNext: { print("订阅2: \($0)") })
//        //        }
//
//        //MARK:refCount
//        //每隔1秒钟发送1个事件
//        //        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        //            .publish()
//        //            .refCount()
//        //
//        //        //第一个订阅者（立刻开始订阅）
//        //        _ = interval
//        //            .subscribe(onNext: { print("订阅1: \($0)") })
//        //
//        //        //第二个订阅者（延迟5秒开始订阅）
//        //        delay(5) {
//        //            _ = interval
//        //                .subscribe(onNext: { print("订阅2: \($0)") })
//        //        }
//
//        //MARK:share(replay:)
//        //每隔1秒钟发送1个事件
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//            .share(replay: 5)
//
//        //第一个订阅者（立刻开始订阅）
//        _ = interval
//            .subscribe(onNext: { print("订阅1: \($0)") })
//
//        //第二个订阅者（延迟5秒开始订阅）
//        delay(5) {
//            _ = interval
//                .subscribe(onNext: { print("订阅2: \($0)") })
//        }
//    }
//
//    //MARK:其他操作符9
//    private func rxSwifttest10() {
//        //MARK:delay,delaySubscription
//        //MARK:materialize,dematerialize
//        //        Observable.of(1,3,5,2,23)
//        //            .delaySubscription(3, scheduler: MainScheduler.instance)
//        //            .materialize()
//        //            .dematerialize()
//        //            .subscribe(onNext:{print($0)})
//        //            .disposed(by: disposeBag)
//
//        //MARK:timeout
//        //定义好每个事件里的值以及发送的时间
//        //        let times = [
//        //            [ "value": 1, "time": 0 ],
//        //            [ "value": 2, "time": 0.5 ],
//        //            [ "value": 3, "time": 1.5 ],
//        //            [ "value": 4, "time": 4 ],
//        //            [ "value": 5, "time": 5 ]
//        //        ]
//        //
//        //        //生成对应的 Observable 序列并订阅
//        //        Observable.from(times)
//        //            .flatMap { item in
//        //                return Observable.just(Int(item["value"]!))
//        //                    .delaySubscription(Double(item["time"]!),scheduler: MainScheduler.instance)
//        //            }
//        //            .timeout(2, scheduler: MainScheduler.instance) //超过两秒没发出元素，则产生error事件
//        //            .subscribe(onNext: { element in
//        //                print(element)
//        //            }, onError: { error in
//        //                print(error)
//        //            })
//        //            .disposed(by: disposeBag)
//
//        //MARK:using
//        //一个无限序列（每隔0.1秒创建一个序列数 ）
//        let infiniteInterval$ = Observable<Int>
//            .interval(0.1, scheduler: MainScheduler.instance)
//            .do(
//                onNext: { print("infinite$: \($0)") },
//                onSubscribe: { print("开始订阅 infinite$")},
//                onDispose: { print("销毁 infinite$")}
//        )
//
//        //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
//        let limited$ = Observable<Int>
//            .interval(0.5, scheduler: MainScheduler.instance)
//            .take(2)
//            .do(
//                onNext: { print("limited$: \($0)") },
//                onSubscribe: { print("开始订阅 limited$")},
//                onDispose: { print("销毁 limited$")}
//        )
//
//        //使用using操作符创建序列
//        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
//            return AnyDisposable(infiniteInterval$.subscribe())
//        }, observableFactory: { _ in return limited$ }
//        )
//        _ = o.subscribe()
//
//    }
//    private func rxSwifttest11() {
//        //MARK:catchErrorJustReture
//        //MARK:catchError
//        //        let sequenceThatFails = PublishSubject<String>()
//        //        let recoverySequence = Observable.of("1","3","2")
//        //
//        //        sequenceThatFails
//        ////            .catchErrorJustReturn("错误")
//        //            .catchError({ (error) -> Observable<String> in
//        //                print("Error:",error)
//        //                return recoverySequence
//        //            })
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        sequenceThatFails.onNext("a")
//        //        sequenceThatFails.onNext("b")
//        //        sequenceThatFails.onNext("c")
//        //        sequenceThatFails.onError(MyError.A)
//        //        sequenceThatFails.onNext("d")
//
//        //MARK:retry
//        var count = 1
//        let sequenceThatErrors = Observable<String>.create { (observer) -> Disposable in
//            observer.onNext("a")
//            observer.onNext("b")
//
//            //让第一个订阅时发生错误
//            if count == 1 {
//                observer.onError(MyError.A)
//                print("error encountered")
//                count += 1
//            }
//
//            observer.onNext("c")
//            observer.onNext("d")
//            observer.onCompleted()
//
//            return Disposables.create()
//        }
//        sequenceThatErrors
//            .retry(2)
//            .subscribe(onNext:{print($0)})
//            .disposed(by: disposeBag)
//    }
//
//    //11
//    private func rxSwifttest12() {
//
//        //MARK:debug 打印log
//        //        Observable.of("2","#")
//        //        .startWith("111")
//        //        .debug()
//        //        .subscribe(onNext:{print($0)})
//        //        .disposed(by: disposeBag)
//
//        //MARK:RxSwift.Resources.total
//
//        //        print(RxSwift.Resources.total)
//        //
//        //        let disposeBag = DisposeBag()
//        //
//        //        print(RxSwift.Resources.total)
//        //
//        //        Observable.of("BBB", "CCC")
//        //            .startWith("AAA")
//        //            .subscribe(onNext: { print($0) })
//        //            .disposed(by: disposeBag)
//        //
//        //        print(RxSwift.Resources.total)
//    }
//    //13
//    private func rxSwifttest13() {
//        //MARK:Single
//        //获取第0个频道的歌曲信息
//        //        getPlaylist("1")
//        //            .subscribe { event in
//        //                switch event {
//        //                case .success(let json):
//        //                    print("JSON结果: ", json)
//        //                case .error(let error):
//        //                    print("发生错误: ", error)
//        //                }
//        //            }
//        //            .disposed(by: disposeBag)
//
//        //获取第0个频道的歌曲信息
//        //        getPlaylist("0")
//        //            .subscribe(onSuccess: { json in
//        //                print("JSON结果: ", json)
//        //            }, onError: { error in
//        //                print("发生错误: ", error)
//        //            })
//        //            .disposed(by: disposeBag)
//
//        //MARK:Completable
//        //        cacheLocally()
//        //            .subscribe { completable in
//        //                switch completable {
//        //                case .completed:
//        //                    print("保存成功!")
//        //                case .error(let error):
//        //                    print("保存失败: \(error.localizedDescription)")
//        //                }
//        //            }
//        //            .disposed(by: disposeBag)
//        //
//        //        cacheLocally()
//        //            .subscribe(onCompleted: {
//        //                print("保存成功!")
//        //            }, onError: { error in
//        //                print("保存失败: \(error.localizedDescription)")
//        //            })
//        //            .disposed(by: disposeBag)
//
//        //MARK:Maybe
//        //        generateString()
//        //            .subscribe { maybe in
//        //                switch maybe {
//        //                case .success(let element):
//        //                    print("执行完毕，并获得元素：\(element)")
//        //                case .completed:
//        //                    print("执行完毕，且没有任何元素。")
//        //                case .error(let error):
//        //                    print("执行失败: \(error.localizedDescription)")
//        //
//        //                }
//        //            }
//        //            .disposed(by: disposeBag)
//        //
//        //        generateString()
//        //            .subscribe(onSuccess: { element in
//        //                print("执行完毕，并获得元素：\(element)")
//        //            },
//        //                       onError: { error in
//        //                        print("执行失败: \(error.localizedDescription)")
//        //            },
//        //                       onCompleted: {
//        //                        print("执行完毕，且没有任何元素。")
//        //            })
//        //            .disposed(by: disposeBag)
//
//
//        //MARK:Driver
//    }
//    //UI test
//    private func rxSwifttest20() {
//        //创建文本标签
//        let label = UILabel(frame:CGRect(x:20, y:40, width:300, height:100))
//        self.view.addSubview(label)
//
//        //创建一个计时器（每0.1秒发送一个索引数）
//        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
//
//        //将已过去的时间格式化成想要的字符串，并绑定到label上
//        timer.map(formatTimeInterval)
//            .bind(to: label.rx.attributedText)
//            .disposed(by: disposeBag)
//    }
//
//    //将数字转成对应的富文本
//    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
//        let string = String(format: "%0.2d:%0.2d.%0.1d",
//                            arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
//        //富文本设置
//        let attributeString = NSMutableAttributedString(string: string)
//        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
//        attributeString.addAttribute(NSAttributedString.Key.font,
//                                     value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
//                                     range: NSMakeRange(0, 5))
//        //设置字体颜色
//        attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
//                                     value: UIColor.white, range: NSMakeRange(0, 5))
//        //设置文字背景颜色
//        attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
//                                     value: UIColor.orange, range: NSMakeRange(0, 5))
//        return attributeString
//    }
//    //21
//    private func rxSwifttest21() {
//
////        //创建文本输入框
//        let textField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
//        textField.borderStyle = UITextField.BorderStyle.roundedRect
//        self.view.addSubview(textField)
////
////        //当文本框内容改变时，将内容输出到控制台上
////        textField.rx.text.orEmpty.asObservable()
////            .subscribe(onNext: {
////                print("您输入的是：\($0)")
////            })
////            .disposed(by: disposeBag)
//
////        //创建文本输入框
////        let inputField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
////        inputField.borderStyle = UITextBorderStyle.roundedRect
////        self.view.addSubview(inputField)
////
////        //创建文本输出框
////        let outputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
////        outputField.borderStyle = UITextBorderStyle.roundedRect
////        self.view.addSubview(outputField)
////
////        //创建文本标签
////        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
////        self.view.addSubview(label)
////
////        //创建按钮
////        let button:UIButton = UIButton(type:.system)
////        button.frame = CGRect(x:20, y:230, width:40, height:30)
////        button.setTitle("提交", for:.normal)
////        self.view.addSubview(button)
////
////
////        //当文本框内容改变
////        let input = inputField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
////            .throttle(0.3) //在主线程中操作，0.3秒内值若多次改变，取最后一次
////
////        //内容绑定到另一个输入框中
////        input.drive(outputField.rx.text)
////            .disposed(by: disposeBag)
////
////        //内容绑定到文本标签中
////        input.map{ "当前字数：\($0.count)" }
////            .drive(label.rx.text)
////            .disposed(by: disposeBag)
////
////        //根据内容字数决定按钮是否可用
////        input.map{ $0.count > 5 }
////            .drive(button.rx.isEnabled)
////            .disposed(by: disposeBag)
//    }
//    var tableView:UITableView!
//    //22
//    private func rxSwifttest22() {
//        //创建表格视图
//        self.tableView = UITableView(frame: self.view.frame, style:.plain)
//        //创建一个重用的单元格
//        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        self.view.addSubview(self.tableView!)
//
//        //初始化数据
//        let items = Observable.just([
//            "文本输入框的用法",
//            "开关按钮的用法",
//            "进度条的用法",
//            "文本标签的用法",
//            ])
//
//        //设置单元格数据（其实就是对 cellForRowAt 的封装）
//        items
//            .bind(to: tableView.rx.items) { (tableView, row, element) in
//                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//                cell.textLabel?.text = "\(row)：\(element)"
//                return cell
//            }
//            .disposed(by: disposeBag)
//
//        //获取选中项的索引
//        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
//            print("选中项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
//
//        //获取选中项的内容
//        tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
//            print("选中项的标题为：\(item)")
//        }).disposed(by: disposeBag)
//
//
//        //获取被取消选中项的索引
//        tableView.rx.itemDeselected.subscribe(onNext: {  indexPath in
//            print("被取消选中项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
//
//        //获取被取消选中项的内容
//        tableView.rx.modelDeselected(String.self).subscribe(onNext: { item in
//            print("被取消选中项的的标题为：\(item)")
//        }).disposed(by: disposeBag)
//
//
//        //获取删除项的索引
//        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
//            print("删除项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
//
//        //获取删除项的内容
//        tableView.rx.modelDeleted(String.self).subscribe(onNext: { item in
//            print("删除项的的标题为：\(item)")
//        }).disposed(by: disposeBag)
//
//        //获取移动项的索引
//        tableView.rx.itemMoved.subscribe(onNext: {
//            sourceIndexPath, destinationIndexPath in
//            print("移动项原来的indexPath为：\(sourceIndexPath)")
//            print("移动项现在的indexPath为：\(destinationIndexPath)")
//        }).disposed(by: disposeBag)
//
//
//        //获取插入项的索引
//        tableView.rx.itemInserted.subscribe(onNext: { indexPath in
//            print("插入项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
//
//
//        //获取点击的尾部图标的索引
//        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { indexPath in
//            print("尾部项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
//
//
//        //将要显示cell
//        tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
//            print("将要显示单元格indexPath为：\(indexPath)")
//            print("将要显示单元格cell为：\(cell)\n")
//
//        }).disposed(by: disposeBag)
//
//        //已经显示了cell
//        tableView.rx.didEndDisplayingCell.subscribe(onNext: { cell, indexPath in
//            print("将要显示单元格indexPath为：\(indexPath)")
//            print("将要显示单元格cell为：\(cell)\n")
//
//        }).disposed(by: disposeBag)
//    }
//
//    private func rxSwifttest23() {
//        //创建表格视图
//        self.tableView = UITableView(frame: self.view.frame, style:.plain)
//        //创建一个重用的单元格
//        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        self.view.addSubview(self.tableView!)
//
//        //初始化数据
////        let sections = Observable.just([
////            MySection(header: "", items: [
////                "UILable的用法",
////                "UIText的用法",
////                "UIButton的用法"
////                ])
////            ])
////
////        //创建数据源
////        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
////            //设置单元格
////            configureCell: { ds, tv, ip, item in
////                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
////                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
////                cell.textLabel?.text = "\(ip.row)：\(item)"
////
////                return cell
////        })
////
////        //绑定单元格数据
////        sections
////            .bind(to: tableView.rx.items(dataSource: dataSource))
////            .disposed(by: disposeBag)
//
//        //初始化数据
//        let sections = Observable.just([
//            MySection(header: "基本控件", items: [
//                "UILable的用法",
//                "UIText的用法",
//                "UIButton的用法"
//                ]),
//            MySection(header: "高级控件", items: [
//                "UITableView的用法",
//                "UICollectionViews的用法"
//                ])
//            ])
//
//        //创建数据源
//        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
//            //设置单元格
//            configureCell: { ds, tv, ip, item in
//                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
//                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
//                cell.textLabel?.text = "\(ip.row)：\(item)"
//
//                return cell
//        },
//            //设置分区头标题
//            titleForHeaderInSection: { ds, index in
//                return ds.sectionModels[index].header
//        }
//        )
//        dataSource.titleForFooterInSection = { ds, index in
//            return ds.sectionModels[index].header
//        }
//
//        //绑定单元格数据
//        sections
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//    }
//    //24
//    //搜索栏
//    var searchBar:UISearchBar!
//    private func rxSwifttest24() {
//        //创建表格视图
//        self.tableView = UITableView(frame: self.view.frame.insetBy(dx: 0, dy: 64), style:.plain)
//        //创建一个重用的单元格
//        self.tableView!.register(UITableViewCell.self,
//                                 forCellReuseIdentifier: "Cell")
//        self.view.addSubview(self.tableView!)
//
//        //创建表头的搜索栏
//        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
//                                                   width: self.view.bounds.size.width, height: 56))
//        self.tableView.tableHeaderView =  self.searchBar
//
//        //随机的表格数据
//        let randomResult = refreshButton.rx.tap.asObservable()
//            .throttle(1, scheduler: MainScheduler.instance) //在主线程中操作，1秒内值若多次改变，取最后一次
//            .startWith(()) //加这个为了让一开始就能自动请求一次数据
//            .flatMapLatest{
//                self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
//            }//flatMapLatest 的作用是当在短时间内（上一个请求还没回来）连续点击多次“刷新”按钮，虽然仍会发起多次请求，但表格只会接收并显示最后一次请求。避免表格出现连续刷新的现象
//            .flatMap(filterResult)
//            .share(replay: 1)
//
//        //创建数据源
//        let dataSource = RxTableViewSectionedReloadDataSource
//            <SectionModel<String, Int>>(configureCell: {
//                (dataSource, tv, indexPath, element) in
//                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
//                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
//                return cell
//            })
//
//        //绑定单元格数据
//        randomResult
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//    }
//    //25
//    var collectionView:UICollectionView!
//    private func rxSwifttest25() {
//        //定义布局方式以及单元格大小
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: 100, height: 70)
//
//        //创建集合视图
//        self.collectionView = UICollectionView(frame: self.view.frame.insetBy(dx: 0, dy: 64),
//                                               collectionViewLayout: flowLayout)
//        self.collectionView.backgroundColor = UIColor.white
//
//        //创建一个重用的单元格
//        self.collectionView.register(MyCollectionViewCell.self,
//                                     forCellWithReuseIdentifier: "Cell")
//        self.view.addSubview(self.collectionView!)
//
//        //初始化数据
//        let items = Observable.just([
//            SectionModel(model: "", items: [
//                "Swift",
//                "PHP",
//                "Python",
//                "Java",
//                "javascript",
//                "C#"
//                ])
//            ])
//
//        //创建数据源
//        let dataSource = RxCollectionViewSectionedReloadDataSource
//            <SectionModel<String, String>>(
//                configureCell: { (dataSource, collectionView, indexPath, element) in
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
//                                                                  for: indexPath) as! MyCollectionViewCell
//                    cell.label.text = "\(element)"
//                    return cell}
//        )
//
//        //绑定单元格数据
//        items
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//
//    }
//    var pickerView:UIPickerView!
//    //最简单的pickerView适配器（显示普通文本）
//    private let attrStringPickerAdapter = RxPickerViewAttributedStringAdapter<[String]>(
//        components: [],
//        numberOfComponents: { _,_,_  in 1 },
//        numberOfRowsInComponent: { (_, _, items, _) -> Int in
//            return items.count}
//    ){ (_, _, items, row, _) -> NSAttributedString? in
//        return NSAttributedString(string: items[row],
//                                  attributes: [
//                                    NSAttributedString.Key.foregroundColor: UIColor.orange, //橙色文字
//                                    NSAttributedString.Key.underlineStyle:
//                                        NSUnderlineStyle.double.rawValue, //双下划线
//                                    NSAttributedString.Key.textEffect:
//                                        NSAttributedString.TextEffectStyle.letterpressStyle
//            ])
//    }
//
//    private let viewPickerAdapter = RxPickerViewViewAdapter<[UIColor]>(
//        components: [],
//        numberOfComponents: { _,_,_  in 1 },
//        numberOfRowsInComponent: { (_, _, items, _) -> Int in
//            return items.count}
//    ){ (_, _, items, row, _, view) -> UIView in
//        let componentView = view ?? UIView()
//        componentView.backgroundColor = items[row]
//        return componentView
//    }
//
//
//    private func rxSwifttest26() {
//        //创建pickerView
//        pickerView = UIPickerView()
//        self.view.addSubview(pickerView)
//
//        //绑定pickerView数据
////        Observable.just([["One", "Two", "Tree"],
////                         ["A", "B", "C", "D"]])
//        //绑定pickerView数据
//        Observable.just([UIColor.red, UIColor.orange, UIColor.yellow])
//            .bind(to: pickerView.rx.items(adapter: viewPickerAdapter))
//            .disposed(by: disposeBag)
//
//
//        //建立一个按钮，触摸按钮时获得选择框被选择的索引
//        let button = UIButton(frame:CGRect(x:0, y:0, width:100, height:30))
//        button.center = self.view.center
//        button.backgroundColor = UIColor.blue
//        button.setTitle("获取信息",for:.normal)
//        //按钮点击响应
//        button.rx.tap
//            .bind { [weak self] in
//                self?.getPickerViewValue()
//            }
//            .disposed(by: disposeBag)
//        self.view.addSubview(button)
//
//    }
//
//    private func rxSwifttest27() {
//        //创建URL对象
////        let urlString = "https://www.douban.com/jxxxxxxxx/app/radio/channels"
////        let url = URL(string:urlString)!
//
//        //创建并发起请求
////        request(.get, url)
////            .data()
////            .subscribe(onNext: {
////                data in
////                //数据处理
////                let str = String(data: data, encoding: String.Encoding.utf8)
////                print("返回的数据是：", str ?? "")
////            }, onError: { error in
////                print("请求失败！错误原因：", error)
////            }).disposed(by: disposeBag)
//
//        //创建并发起请求
//
////        requestData(.get, url).subscribe(onNext: {
////            response, data in
////            //数据处理
////            let str = String(data: data, encoding: String.Encoding.utf8)
////            print("返回的数据是：", str ?? "")
////        }).disposed(by: disposeBag)
//
//    }
//
//    private func rxSwifttest222() {
//        //应用重新回到活动状态
//        UIApplication.shared.rx
//            .didBecomeActive
//            .subscribe(onNext: { _ in
//                print("应用进入活动状态。")
//            })
//            .disposed(by: disposeBag)
//
//        //应用从活动状态进入非活动状态
//        UIApplication.shared.rx
//            .willResignActive
//            .subscribe(onNext: { _ in
//                print("应用从活动状态进入非活动状态。")
//            })
//            .disposed(by: disposeBag)
//
//        //应用从后台恢复至前台（还不是活动状态）
//        UIApplication.shared.rx
//            .willEnterForeground
//            .subscribe(onNext: { _ in
//                print("应用从后台恢复至前台（还不是活动状态）。")
//            })
//            .disposed(by: disposeBag)
//
//        //应用进入到后台
//        UIApplication.shared.rx
//            .didEnterBackground
//            .subscribe(onNext: { _ in
//                print("应用进入到后台。")
//            })
//            .disposed(by: disposeBag)
//
//        //应用终止
//        UIApplication.shared.rx
//            .willTerminate
//            .subscribe(onNext: { _ in
//                print("应用终止。")
//            })
//            .disposed(by: disposeBag)
//
//
//        //应用重新回到活动状态
//        UIApplication.shared.rx
//            .state
//            .subscribe(onNext: { state in
//                switch state {
//                case .active:
//                    print("应用进入活动状态。")
//                case .inactive:
//                    print("应用进入非活动状态。")
//                case .background:
//                    print("应用进入到后台。")
//                case .terminated:
//                    print("应用终止。")
//                }
//            })
//            .disposed(by: disposeBag)
//
//
//        //使用sentMessage方法获取Observable
//        self.rx.sentMessage(#selector(ViewController.viewWillAppear(_:)))
//            .subscribe(onNext: { value in
//                print("1")
//            })
//            .disposed(by: disposeBag)
//
//        //使用methodInvoked方法获取Observable
//        self.rx.methodInvoked(#selector(ViewController.viewWillAppear(_:)))
//            .subscribe(onNext: { value in
//                print("3")
//            })
//            .disposed(by: disposeBag)
//
//    }
//
//    //触摸按钮时，获得被选中的索引
//    @objc func getPickerViewValue(){
//
//        let message = String(pickerView.selectedRow(inComponent: 0))
//        let alertController = UIAlertController(title: "被选中的索引为",
//                                                message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//
//
//    //过滤数据
//    func filterResult(data:[SectionModel<String, Int>])
//        -> Observable<[SectionModel<String, Int>]> {
//            return self.searchBar.rx.text.orEmpty
//                //.debounce(0.5, scheduler: MainScheduler.instance) //只有间隔超过0.5秒才发送
//                .flatMapLatest{
//                    query -> Observable<[SectionModel<String, Int>]> in
//                    print("正在筛选数据（条件为：\(query)）")
//                    //输入条件为空，则直接返回原始数据
//                    if query.isEmpty{
//                        return Observable.just(data)
//                    }
//                        //输入条件为不空，则只返回包含有该文字的数据
//                    else{
//                        var newData:[SectionModel<String, Int>] = []
//                        for sectionModel in data {
//                            let items = sectionModel.items.filter{ "\($0)".contains(query) }
//                            newData.append(SectionModel(model: sectionModel.model, items: items))
//                        }
//                        return Observable.just(newData)
//                    }
//            }
//    }
//
//    //获取随机数据
//    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
//        print("正在请求数据......")
//        let items = (0 ..< 5).map {_ in
//            Int(arc4random())
//        }
//        let observable = Observable.just([SectionModel(model: "S", items: items),
//                                          SectionModel(model: "S1", items: items),
//                                          SectionModel(model: "S2", items: items)])
//        return observable.delay(2, scheduler: MainScheduler.instance)
//    }
//
//
//    //获取豆瓣某频道下的歌曲信息
//    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
//        return Single<[String: Any]>.create { single in
//            let url = "https://douban.fm/j/mine/playlist?" + "type=n&channel=\(channel)&from=mainsite"
//
//            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
//                if let error = error {
//                    single(.error(error))
//                    return
//                }
//
//                guard let data = data,
//                    let json = try? JSONSerialization.jsonObject(with: data,options: .mutableLeaves),
//                    let result = json as? [String: Any] else {
//                        single(.error(DataError.cantParseJSON))
//                        return
//                }
//
//                single(.success(result))
//            }
//
//            task.resume()
//
//            return Disposables.create { task.cancel() }
//        }
//    }
//
//    //将数据缓存到本地
//    func cacheLocally() -> Completable {
//        return Completable.create { completable in
//            //将数据缓存到本地（这里掠过具体的业务代码，随机成功或失败）
//            let success = (arc4random() % 2 == 0)
//
//            guard success else {
//                completable(.error(CacheError.failedCaching))
//                return Disposables.create {}
//            }
//
//            completable(.completed)
//            return Disposables.create {}
//        }
//    }
//
//
//    func generateString() -> Maybe<String> {
//        return Maybe<String>.create { maybe in
//            //成功并发出一个元素
//            maybe(.success("hangge.com"))
//            //成功但不发出任何元素
//            maybe(.completed)
//            //失败
//            maybe(.error(StringError.failedGenerate))
//            return Disposables.create {}
//        }
//    }
//
//
//    ///延迟执行
//    /// - Parameters:
//    ///   - delay: 延迟时间（秒）
//    ///   - closure: 延迟执行的闭包
//    public func delay(_ delay: Double, closure: @escaping () -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//            closure()
//        }
//    }
//
//
//    private func testCodable() {
//        print("测试 codable 协议")
//        /*
//         enum BeerStyle : String, Codable {
//         case ipa
//         case stout
//         case kolsch
//         }
//
//         struct Beer : Decodable {
//         let name: String
//         let brewery: String
//         let style: BeerStyle
//         }
//
//         let jsons = """
//         {
//         "name": "Endeavor",
//         "abv": 8.9,
//         "brewery": "Saint Arnold",
//         "style": "ipa"
//         }
//         """.data(using: .utf8)! // our data in native (JSON) format
//         do{
//         let myStruct = try JSONDecoder().decode(Beer.self, from: jsons) // Decoding our data
//         print(myStruct) // decoded!!!!!
//         }catch{
//         print("error \(error)")
//         }*/
//
//        //public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey
//        //public func singleValueContainer() throws -> SingleValueDecodingContainer
//        //两个方法都是container
//
//        //选择正确的解码器
//        //        let decoder = JSONDecoder()
//        //选择正确的容器
//        _ = """
//{
// "fullName": "Federico Zanetello",
// "id": 123456,
// "twitter": "http://twitter.com/zntfdr"
//}
//""".data(using: .utf8)!
//        enum MyStructKeys : String, CodingKey {
//            case fullName = "fullName"
//            case id = "id"
//            case twitter = "twitter"
//        }
//
//        //        //提取数据
//        //        do {
//        ////                let fullName = try decoder.decode(String.self, from: json)
//        ////                let id = try decoder.decode(Int.self, from: json)
//        ////                let twitter = try decoder.decode(URL.self, from: json)
//        //        }catch{
//        //            print("decode fail")
//        //        }
//
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        testCodable()
//        //groupRequest()
//        //groupRequest()
//        //        DispatchQueue.global().sync {
//        //            print("全局队列同步执行")
//        //            DispatchQueue.global().sync {
//        //                print("全局队列 这里应该是崩溃了")
//        //            }
//        //        }
//    }
//
//    //responseType:.string(.utf8)
//    func testMyRequest() {
//        print("request start")
//        __NetworkManager.request("https://httpbin.org/post",
//                                 //requestOption: .sync,
//            success: {
//                (successObj) in
//                print("当前线程1 \(Thread.current == Thread.main ? "main" : "子线程")")
//                print("请求成功1  \(String(describing: successObj))")
//        })
//        { (failObj) in
//            print("请求失败1  \(String(describing: failObj))")
//        }
//
//        //        __NetworkManager.request("https://httpbin.org/post",
//        //                                 requestOption: .sync,
//        //                                 success: {
//        //                                    (successObj) in
//        //                                    print("当前线程 \(Thread.current == Thread.main ? "main" : "子线程")")
//        //                                    print("请求成功  \(String(describing: successObj))")
//        //        })
//        //        { (failObj) in
//        //            print("请求失败  \(String(describing: failObj))")
//        //        }
//
//
//
//
//
//        //分组处理.多组的时候需要每组有自己的group,这一块还没有处理
//        //groupRequest()
//        //        groupRequest()
//        print("request end")
//    }
//
//    func groupRequest() {
//        //        __NetworkManager.batchRequest({
//        //            __NetworkManager.request("https://httpbin.org/post",
//        //                                     requestOption: .batch,
//        //                                     success: {
//        //                                        (successObj) in
//        //                                        print("当前线程 \(Thread.current == Thread.main ? "main" : "子线程")")
//        //                                        print("请求成功  \(String(describing: successObj))")
//        //            })
//        //            { (failObj) in
//        //                print("请求失败  \(String(describing: failObj))")
//        //            }
//        //
//        //            __NetworkManager.request("https://httpbin.org/post",
//        //                                     requestOption: .batch,
//        //                                     success: {
//        //                                        (successObj) in
//        //                                        print("当前线程1 \(Thread.current == Thread.main ? "main" : "子线程")")
//        //                                        print("请求成功1  \(String(describing: successObj))")
//        //            })
//        //            { (failObj) in
//        //                print("请求失败1  \(String(describing: failObj))")
//        //            }
//        //
//        //            __NetworkManager.request("https://httpbin.org/post",
//        //                                     requestOption: .batch,
//        //                                     success: {
//        //                                        (successObj) in
//        //                                        print("当前线程12 \(Thread.current == Thread.main ? "main" : "子线程")")
//        //                                        print("请求成功12  \(String(describing: successObj))")
//        //            })
//        //            { (failObj) in
//        //                print("请求失败12  \(String(describing: failObj))")
//        //            }
//        //
//        //        }) {
//        //            print("batch request complete")
//        //            //            if self.count == 0 {
//        //            //                self.count += 1
//        //            //                self.groupRequest()
//        //            //            }
//        //        }
//    }
//
//    func setupUI() {
//        let animationView = AnimationManager.animateView(frame: CGRect(0, 0, kWidth, 300), style: .pulse)
//        animationView.backgroundColor = UIColor.lightGray
//        view.addSubview(animationView)
//    }
//
//    private func testMoya() {
//        //Moya的请求大致可以看做是：Request->Endpoint->Response的过程，中间的Endpoint是给我们开发者留下的最后的可以修改Reqeust的地方
//        downloadRepositories("ashfurrow")
////        downloadZen()
////        downloadMoyaLogo()
//    }
//
//    func uploadGiphy() {
//        giphyProvider.request(.upload(gif: Giphy.animatedBirdData),
//                              callbackQueue: DispatchQueue.main,
//                              progress: progressClosure,
//                              completion: progressCompletionClosure)
//    }
//
//    func downloadMoyaLogo() {
//        gitHubUserContentProvider.request(.downloadMoyaWebContent("logo_github.png"),
//                                          callbackQueue: DispatchQueue.main,
//                                          progress: progressClosure,
//                                          completion: progressCompletionClosure)
//    }
//
//    // MARK: - Progress Helpers
//
//    lazy var progressClosure: ProgressBlock = { response in
//
//    }
//
//    lazy var progressCompletionClosure: Completion = { result in
//        let color: UIColor
//        switch result {
//        case .success:
//            color = .green
//        case .failure:
//            color = .red
//        }
//    }
//
//    func downloadRepositories(_ username: String) {
//        gitHubProvider.request(.userRepositories(username)) { result in
//            do {
//                let response = try result.dematerialize()
//                let value = try response.mapNSArray()
//                print(value)
//            } catch {
//                let printableError = error as CustomStringConvertible
//                print(printableError)
//            }
//        }
//    }
//
//    private func testSwift42() {
//        print("===========")
//        //1. 定义的枚举遵循CaseIterable协议后, 编译时Swift 会自动合成一个allCases属性，是包含枚举的所有case项的数组
//        //这个allCases的自动合成仅替换没有参数的case值, 但是如果需要你需要所有case值, 可以重写allCases属性自己添加
//        //如果有枚举项标记为unavailable，则默认无法合成allCases，只能依靠自己来手动合成
////
////        enum Gait: CaseIterable {
////            case walk
////            case trot
////            case canter
////            case gallop
////        }
////
////        for gait in Gait.allCases {
////            print(gait)
////        }
//
//        //2.
//        //#warning主要用于提醒你或者别人一些工作还没有完成，Xcode模板常使用#warning标记一些你需要替换成自己代码的方法存根(method stubs)。
//        //#error主要用于如果你发送一个库，需要其他开发者提供一些数据
////        print("只要元素是Equatable的，则集合也默认是Equatable,Hashable,Encodable,Decodable")
//
//        //3. 动态成员查找
//        //@dynamicMemberLookup: 可以让Swift以一种下标方法去进行属性访问
//        //subscript(dynamicMember:)：可以通过所请求属性的字符串名得到，并且可以返回你想要的任何值
//
//        //4. 增强条件的一致性
//        //一个类型的所有元素如果符合Hashable协议，则类型自动符合Hashable协议
//
//
//        //5. 本地集合元素移除removeAll,filter
//        var pythons = ["John", "Michael", "Graham", "Terry", "Eric", "Terry"]
//        pythons.removeAll { $0.hasPrefix("Terry") }
//        print(pythons)
//
//        //6. 随机数字的生成和洗牌
//        //shuffle()和shuffled()方法对数组元素进行重新随机排序
//        //randomElement随机获取一个元素
//
//        //7. 检查序列元素是否符合条件 allSatisfy
//
//        //8. bool值切换toggle
//
//        //优化Equatable 和Hashable
//        //9. 更加安全的hashable, 提供了一个hasher
//        //Hasher中的hash合并算法可以有效的平衡hash的质量和性能，还可以低于阻断式服务攻击，它使用了App启动时生成的随机预处理种子，因此在Swift 4.2中每次启动App时的hash值不一样了，会导致之前一些有序字典或者集合变的无序，当然我们也可以添加环境变量（ SWIFT_DETERMINISTIC_HASHING=1）来关掉这个功能
//
//        //10. canImport和hasTargetEnvironment 替代之前的os
//
//        //11. last(where:) lastIndex(where:)
//
//    }
//
//    private func test2222() {
//
//    }
//
//    subscript(dynamicMember member: String) -> String {
//        let properties = ["name": "Titanjun", "city": "Hang"]
//        return properties[member, default: "0"] //默认值
//    }
//
//}
//
//func downloadZen() {
//    gitHubProvider.request(.zen) { result in
//        var message = "Couldn't access API"
//        if case let .success(response) = result {
//            let jsonString = try? response.mapString()
//            message = jsonString ?? message
//        }
//    }
//}
//
//
//
//extension UILabel {
//    public var fontSize: Binder<CGFloat> {
//        return Binder(self, binding: { (lable, fontsize) in
//            lable.font = UIFont.boldSystemFont(ofSize: fontsize)
//        })
//    }
//}
//extension Reactive where Base: UILabel {
//    public var fontSize: Binder<CGFloat> {
//        return Binder(self.base) {
//            label,fontSize in
//            label.font = UIFont.systemFont(ofSize: fontSize)
//        }
//    }
//}
//class AnyDisposable: Disposable {
//    let _dispose: () -> Void
//
//    init(_ disposable: Disposable) {
//        _dispose = disposable.dispose
//    }
//
//    func dispose() {
//        _dispose()
//    }
//}
//
//enum MyError: Error {
//    case A
//    case B
//}
////与数据相关的错误类型
//enum DataError: Error {
//    case cantParseJSON
//}
////与缓存相关的错误类型
//enum CacheError: Error {
//    case failedCaching
//}
////与缓存相关的错误类型
//enum StringError: Error {
//    case failedGenerate
//}
////自定义Section
//struct MySection {
//    var header: String
//    var items: [Item]
//}
//
//extension MySection : AnimatableSectionModelType {
//    typealias Item = String
//
//    var identity: String {
//        return header
//    }
//
//    init(original: MySection, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}
//
////MARK:UICollectionView
//class MyCollectionViewCell: UICollectionViewCell {
//
//    var label:UILabel!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        //背景设为橙色
//        self.backgroundColor = UIColor.orange
//
//        //创建文本标签
//        label = UILabel(frame: frame)
//        label.textColor = UIColor.white
//        label.textAlignment = .center
//        self.contentView.addSubview(label)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.frame = bounds
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//
////初始化豆瓣FM请求的provider
//let DouBanProvider = MoyaProvider<DouBanAPI>()
//
///** 下面定义豆瓣FM请求的endpoints（供provider使用）**/
////请求分类
//public enum DouBanAPI {
//    case channels  //获取频道列表
//    case playlist(String) //获取歌曲
//}
//
////请求配置
//extension DouBanAPI: TargetType {
//    //服务器地址
//    public var baseURL: URL {
//        switch self {
//        case .channels:
//            return URL(string: "https://www.douban.com")!
//        case .playlist(_):
//            return URL(string: "https://douban.fm")!
//        }
//    }
//
//    //各个请求的具体路径
//    public var path: String {
//        switch self {
//        case .channels:
//            return "/j/app/radio/channels"
//        case .playlist(_):
//            return "/j/mine/playlist"
//        }
//    }
//
//    //请求类型
//    public var method: Moya.Method {
//        return .get
//    }
//
//    //请求任务事件（这里附带上参数）
//    public var task: Task {
//        switch self {
//        case .playlist(let channel):
//            var params: [String: Any] = [:]
//            params["channel"] = channel
//            params["type"] = "n"
//            params["from"] = "mainsite"
//            return .requestParameters(parameters: params,
//                                      encoding: URLEncoding.default)
//        default:
//            return .requestPlain
//        }
//    }
//
//    //是否执行Alamofire验证
//    public var validate: Bool {
//        return false
//    }
//
//    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
//    public var sampleData: Data {
//        return "{}".data(using: String.Encoding.utf8)!
//    }
//
//    //请求头
//    public var headers: [String: String]? {
//        return nil
//    }
