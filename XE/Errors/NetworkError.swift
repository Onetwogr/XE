//
//  NetworkError.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import Foundation

// Enum representing different types of network errors
enum NetworkError: Error {
    case noConnection
    case timeout
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int)
    case unauthorized
    case forbidden
    case notFound
    case invalidRequest
    case serviceUnavailable
    case rateLimited
    case unknown
}
