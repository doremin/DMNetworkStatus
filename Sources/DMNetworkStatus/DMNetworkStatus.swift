import Network
import RxSwift

@available(iOS 12.0, *)
open class DMNetworkStatus: ReactiveCompatible {
    public init() { }
}

@available(iOS 12.0, *)
extension Reactive where Base == DMNetworkStatus {
    var isWifiConnected: Observable<Bool> {
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

    var isCellularConnected: Observable<Bool> {
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

    var isEthernetConnected: Observable<Bool> {
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

    var isNetworkConnected: Observable<Bool> {
        return Observable.combineLatest(isWifiConnected, isCellularConnected, isEthernetConnected)
            .map { $0 || $1 || $2 }
            .distinctUntilChanged()
    }
}
