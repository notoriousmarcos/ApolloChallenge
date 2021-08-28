//
//  NativeHTTPPostClientTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) -> (URLResponse, Data?, Error?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let (response, data, error) = Self.requestHandler?(request) else {
            XCTFail("RequestHandler Shouldn't be nil")
            return
        }

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        //
    }
}

class NativeHTTPPostClient: HTTPPostClient {

    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func post(to url: URL, with data: Data?, completion: @escaping (HTTPPostClient.Result) -> Void) {
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

    func makeRequest(_ url: URL, data: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data

        return request
    }
}

class NativeHTTPPostClientTests: XCTestCase {

    let url = URL(string: "https://api.shrtco.de/v2/shorten")!

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()

    func testNativeHTTPPostClient_init_ShouldRetainProperties() {
        // Arrange
        let sut = NativeHTTPPostClient(session: session)

        // Assert
        XCTAssertNotNil(sut.session)
    }

    func testNativeHTTPPostClient_makePostRequest_ShouldReturnASuccessPost() {
        // Arrange
        let sut = NativeHTTPPostClient(session: session)
        let validData = Data()
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), validData, nil)
        }

        sut.post(to: url, with: validData) { result in
            switch result {
                case .success(let data):
                    XCTAssertEqual(data, validData)
                case .failure:
                    XCTFail("Should return a valid data")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPPostClient_makePostRequest_ShouldReturnUnauthorized() {
        // Arrange
        let sut = NativeHTTPPostClient(session: session)
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: 401), nil, nil)
        }

        sut.post(to: url, with: nil) { result in
            switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .unauthorized)
                case .success:
                    XCTFail("Should return an Error")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func testNativeHTTPPostClient_makeInvalidPostRequest_ShouldReturnUnknown() {
        // Arrange
        let sut = NativeHTTPPostClient(session: session)
        let validData = Data()
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: -1), validData, nil)
        }

        sut.post(to: url, with: validData) { result in
            switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .unknown)
                case .success:
                    XCTFail("Should return an Error")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    private func createErrorResponseForRequest(_ request: URLRequest, code: Int) -> URLResponse {
        HTTPURLResponse(url: request.url!,
                        statusCode: code,
                        httpVersion: nil,
                        headerFields: request.allHTTPHeaderFields)!
    }
}
