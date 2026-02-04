
import Foundation
import Network

protocol NetworkMonitorProtocol {
    func isConnectedToInternet() async -> Bool
}

final class NetworkMonitor: NetworkMonitorProtocol {
    func isConnectedToInternet() async -> Bool {
        await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                continuation.resume(returning: path.status == .satisfied)
                monitor.cancel()
            }
            monitor.start(queue: .main)
        }
    }
}
