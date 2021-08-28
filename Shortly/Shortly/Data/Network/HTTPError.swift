//
//  HTTPError.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public enum HTTPError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
