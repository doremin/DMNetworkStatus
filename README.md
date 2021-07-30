# DMNetworkStatus

* DMNetworkStatus is a NWPathMonitor wrapper library for checking network status easily.

## Swift Package Manager

```swift
https://github.com/doremin/DMNetworkStatus
```

## Usage

```swift
import DMNetworkStatus

_ = DMNetworkStatus.shared.isWifiConnected
            .map { "wifi: \($0)" }
            .bind(to: wifi.rx.text)
```



### Supported Interface Type

* isWifiConnected: Observable of Boolean Type that emits true when wi-fi is connected
* isCellularConnected: Observable of Boolean Type that emits true when cellular is connected
* isEthernetConnected: Observable of Boolean Type that emits true when ethernet is connected

* isNetworkConnected: Observable of Boolean Type that emits true when any of above is connected
