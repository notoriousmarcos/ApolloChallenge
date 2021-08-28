//
//  SaveShortURLUseCase.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol SaveShortURLUseCase {
    func execute(_ model: ShortlyURLModel, completion: @escaping (Bool) -> Void)
}
