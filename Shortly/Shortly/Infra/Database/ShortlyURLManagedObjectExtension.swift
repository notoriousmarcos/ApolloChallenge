//
//  ShortlyURLManagedObjectExtension.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import CoreData

public extension ShortlyURLManagedObject {
    func setupWithShortlyModel(_ shortly: ShortlyURLModel) {
        self.setValue(shortly.code, forKey: "code")
        self.setValue(shortly.shortLink, forKey: "short_link")
        self.setValue(shortly.fullShortLink, forKey: "full_short_link")
        self.setValue(shortly.shortLink2, forKey: "short_link2")
        self.setValue(shortly.fullShortLink2, forKey: "full_short_link2")
        self.setValue(shortly.shareLink, forKey: "share_link")
        self.setValue(shortly.fullShareLink, forKey: "full_share_link")
        self.setValue(shortly.originalLink, forKey: "original_link")
        self.setValue(Date(), forKey: "timestamp")
    }

    func toShortlyURLModel() -> ShortlyURLModel? {
        guard let code = code,
              let short_link = short_link,
              let full_short_link = full_short_link,
              let short_link2 = short_link2,
              let full_short_link2 = full_short_link2,
              let share_link = share_link,
              let full_share_link = full_share_link,
              let original_link = original_link else {
            return nil
        }
        return ShortlyURLModel(code: code,
                               shortLink: short_link,
                               fullShortLink: full_short_link,
                               shortLink2: short_link2,
                               fullShortLink2: full_short_link2,
                               shareLink: share_link,
                               fullShareLink: full_share_link,
                               originalLink: original_link)
    }
}
