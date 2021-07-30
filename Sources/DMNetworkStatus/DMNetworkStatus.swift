import Network
import RxSwift

@available(iOS 12.0, *)
open class DMNetworkStatus {
    public static let shared = DMNetworkStatus()

    private init() { }

    public var isWifiConnected: Observable<Bool> {
        return Observable<Bool>.create { observer in
            let monitor = NWPathMonitor(requiredInterfaceType: .wifi)
            let queue = DispatchQueue(label: "wifi-queue")
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
            }
            monitor.start(queue: queue)

            return Disposables.create {
                monitor.cancel()
            }
        }
    }

    public var isCellularConnected: Observable<Bool> {
        return Observable<Bool>.create { observer in
            let monitor = NWPathMonitor(requiredInterfaceType: .cellular)
            let queue = DispatchQueue(label: "cellular-queue")
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
            }
            monitor.start(queue: queue)

            return Disposables.create {
                monitor.cancel()
            }
        }
    }

    public var isEthernetConnected: Observable<Bool> {
        return Observable<Bool>.create { observer in
            let monitor = NWPathMonitor(requiredInterfaceType: .wiredEthernet)
            let queue = DispatchQueue(label: "ethernet-queue")
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
            }
            monitor.start(queue: queue)

            return Disposables.create {
                monitor.cancel()
            }
        }
    }

    public var isNetworkConnected: Observable<Bool> {
        return Observable.combineLatest(isWifiConnected, isCellularConnected, isEthernetConnected)
            .map { $0 || $1 || $2 }
            .distinctUntilChanged()
    }
}
