//
//  DataExtension.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
