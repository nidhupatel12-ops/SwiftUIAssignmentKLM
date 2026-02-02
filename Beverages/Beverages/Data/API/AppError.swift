
import Foundation

enum AppError: Error, Equatable {
    case serverError(Int)
    case inavalidUrl
    case unknownError
    case noData
    
    var errorDescription: String? {
        switch self {
        case .inavalidUrl:
            return "Invalid URL"
        case .unknownError :
            return "Unknown Error"
        case .serverError(let statusCode):
            return "Status Code Error (\(statusCode))"
        case .noData:
            return "No Data"
        }
    }
}
