//
//  HTTPError.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public enum HTTPError: Int, Error {
    case timeOut = 408
    case badRequest = 400
    case serverError = 500
    case unauthorized = 401
    case forbidden = 403
    case unknown = -1
}
