
import Foundation

enum AppError: Error, Equatable {
    case serverError(Int)
    case invalidUrl
    case unknownError
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
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
