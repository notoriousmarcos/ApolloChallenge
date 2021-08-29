//
//  ShortlyURL.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import Foundation

public struct ShortlyURLViewModel {
    public let code: String
    public let shortLink: String
    public let originalLink: String

    public init(
        code: String,
        shortLink: String,
        originalLink: String
    ) {
        self.code = code
        self.shortLink = shortLink
        self.originalLink = originalLink
    }
}
