//
//  File.swift
//  
//
//  Created by Kota Kawanishi on 2023/01/26.
//

import Foundation

public protocol HTTPRequestType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headerFields: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var validation: ValidationType { get }
    var timeInterval: TimeInterval? { get }
    var authorization: Authorization { get }
}

public enum HttpMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum ValidationType {
    case none
    case successCodes
    case successAndRedirectCodes
    case customCodes([Int])

    var statusCodes: [Int] {
        switch self {
        case .successCodes:
            return Array(200..<300)
        case .successAndRedirectCodes:
            return Array(200..<400)
        case .customCodes(let codes):
            return codes
        case .none:
            return []
        }
    }
}

public enum Authorization {
    case none
    case basic(String)
    case bearer(String)
    case custom(String)

    public var value: [String: String]? {
        let header = "Authorization"
        switch self {
        case .none: return nil
        case .basic(let value): return [header : "Basic \(value)"]
        case .bearer(let value): return [header : "Bearer \(value)"]
        case .custom(let customValue): return [header : customValue]
        }
    }
}
