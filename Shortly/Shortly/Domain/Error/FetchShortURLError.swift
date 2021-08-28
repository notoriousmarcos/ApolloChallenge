//
//  FetchShortURLError.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public enum FetchShortURLError: Int, Error {
    case emptyURL = 1
    case invalidURL = 2
    case rateLimitReached = 3
    case ipBlocked = 4
    case shortCodeInUse = 5
    case unknown = 6
    case missingParams = 9
    case disallowedLink = 10
}
