//
//  Model.swift
//  Shortly
//
//  Created by marcos.brito on 27/08/21.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
