//
//  ErrorResponse.swift
//  DrinkIt
//
//  Created by Santi Nieves on 8/7/25.
//

import Foundation

protocol Response: Codable {
    var errors: [ErrorResponse]? { get }
}

// MARK: - Error
struct ErrorResponse: Codable {
    let code: String
    let field: String?
    let data: String?
}

extension ErrorResponse: LocalizedError {
    public var errorDescription: String? {
        return code
    }
}
