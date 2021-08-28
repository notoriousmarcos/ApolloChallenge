//
//  FetchAllShortURLUseCase.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol FetchAllShortURLUseCase {
    typealias Result = Swift.Result<[ShortlyURLModel], Error>
    func execute(completion: @escaping (Result) -> Void)
}
