//
//  NativeHTTPGetClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public class NativeHTTPGetClient: HTTPGetClient {

    public let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func get(to url: URL, with data: Data?, completion: @escaping (HTTPGetClient.Result) -> Void) {
        let task = session.dataTask(with: makeRequest(url, data: data)) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(.badRequest))
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    let error = HTTPError(rawValue: httpResponse.statusCode) ?? .unknown
                    return completion(.failure(error))
                }

                completion(.success(data))
            }
        }

        task.resume()

    }

    func getURLWithParams(_ url: URL, params: [String: Any]?) -> URL {
        guard let params = params else {
            return url
        }

        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = params.map({ param in
            URLQueryItem(name: param.key, value: param.value as? String)
        })
        return urlComponents?.url ?? url
    }

    private func makeRequest(_ url: URL, data: Data?) -> URLRequest {

        var request = URLRequest(url: getURLWithParams(url, params: data?.toJson()))

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
