//
//  FetchShortURLUseCase.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol FetchShortURLUseCase {
    typealias Result = Swift.Result<ShortlyURLModel, FetchShortURLError>
    func execute(_ model: FetchShortURLUseCaseModel, completion: @escaping (Result) -> Void)
}

public struct FetchShortURLUseCaseModel: Model {
    public var url: String

    public init(url: String) {
        self.url = url
    }
}

public struct FetchShortURLUseResponse: Model {
    public let ok: Bool
    public let error_code: Int?
    public let error: String?
    public let result: ShortlyURLModel?
}
