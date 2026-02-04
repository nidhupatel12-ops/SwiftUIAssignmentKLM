
@testable import Beverages

final class MockNetworkMonitor : NetworkMonitorProtocol {
    var isReachable: Bool = true
    
    func isConnectedToInternet() async -> Bool {
      return isReachable
    }
}
