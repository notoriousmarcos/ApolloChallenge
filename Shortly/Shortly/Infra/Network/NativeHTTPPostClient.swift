//
//  NativeHTTPPostClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public class NativeHTTPPostClient: HTTPPostClient {

    public let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func post(to url: URL, with data: Data?, completion: @escaping (HTTPPostClient.Result) -> Void) {
        let task = session.dataTask(with: makeRequest(url, data: data)) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(.badRequest))
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                let error = HTTPError(rawValue: httpResponse.statusCode) ?? .unknown
                return completion(.failure(error))
            }

            completion(.success(data))
        }

        task.resume()

    }

    private func makeRequest(_ url: URL, data: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data

        return request
    }
}
