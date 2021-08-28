//
//  RemoteFetchShortURLUseCase.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public class RemoteFetchShortURLUseCase: FetchShortURLUseCase {
    private let url: URL
    private let httpClient: HTTPGetClient

    public init(url: URL, httpClient: HTTPGetClient) {
        self.url = url
        self.httpClient = httpClient
    }

    public func execute(_ model: FetchShortURLUseCaseModel, completion: @escaping (FetchShortURLUseCase.Result) -> Void) {
        httpClient.get(to: url, with: model.toData()) { [weak self] result in
            guard self != nil else { return completion(.failure(.unknown)) }
            switch result {
                case .success(let data):
                    guard let model: FetchShortURLUseResponse = data?.toModel() else {
                        return completion(.failure(.unknown))
                    }

                    self?.parseResponseToResult(model, completion: completion)
                case .failure:
                    completion(.failure(.unknown))
            }
        }
    }

    private func parseResponseToResult(_ response: FetchShortURLUseResponse, completion: @escaping (FetchShortURLUseCase.Result) -> Void) {
        if response.ok, let shortURL = response.result  {
            completion(.success(shortURL))
        } else if let error = response.error_code {
            completion(.failure(FetchShortURLError(rawValue: error) ?? .unknown))
        } else {
            completion(.failure(.unknown))
        }
    }
}
