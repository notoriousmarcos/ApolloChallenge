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
}
