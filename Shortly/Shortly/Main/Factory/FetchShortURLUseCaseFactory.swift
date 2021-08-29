//
//  Facory.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import Foundation

public protocol FetchShortURLUseCaseFactoryProtocol {
    func make() -> FetchShortURLUseCase
}

public struct FetchShortURLUseCaseFactory: FetchShortURLUseCaseFactoryProtocol {
    public func make() -> FetchShortURLUseCase {
        let httpClient = NativeHTTPGetClient()
        let url = URL(string: "https://api.shrtco.de/v2/shorten")!
        return RemoteFetchShortURLUseCase(url: url, httpClient: httpClient)
    }
}
