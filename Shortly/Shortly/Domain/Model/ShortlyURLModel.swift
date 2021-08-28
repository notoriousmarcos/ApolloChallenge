//
//  ShortlyURLModel.swift
//  Shortly
//
//  Created by marcos.brito on 27/08/21.
//

import Foundation

public struct ShortlyURLModel: Model {
    public enum CodingKeys: String, CodingKey {
        case code = "code"
        case shortLink = "short_link"
        case fullShortLink = "full_short_link"
        case shortLink2 = "short_link2"
        case fullShortLink2 = "full_short_link2"
        case shareLink = "share_link"
        case fullShareLink = "full_share_link"
        case originalLink = "original_link"
    }

    public let code: String
    public let shortLink: String
    public let fullShortLink: String
    public let shortLink2: String
    public let fullShortLink2: String
    public let shareLink: String
    public let fullShareLink: String
    public let originalLink: String

    public init(code: String,
                shortLink: String,
                fullShortLink: String,
                shortLink2: String,
                fullShortLink2: String,
                shareLink: String,
                fullShareLink: String,
                originalLink: String) {
        self.code = code
        self.shortLink = shortLink
        self.fullShortLink = fullShortLink
        self.shortLink2 = shortLink2
        self.fullShortLink2 = fullShortLink2
        self.shareLink = shareLink
        self.fullShareLink = fullShareLink
        self.originalLink = originalLink
    }
}
