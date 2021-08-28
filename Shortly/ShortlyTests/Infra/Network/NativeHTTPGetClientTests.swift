//
//  NativeHTTPGetClientTests.swift
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

class NativeHTTPGetClientTests: XCTestCase {

    let url = URL(string: "https://api.shrtco.de/v2/shorten")!

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()

    func testNativeHTTPGetClient_init_ShouldRetainProperties() {
        // Arrange
        let sut = NativeHTTPGetClient(session: session)

        // Assert
        XCTAssertNotNil(sut.session)
    }

    func testNativeHTTPGetClient_makeGetRequest_ShouldReturnASuccessGet() {
        // Arrange
        let sut = NativeHTTPGetClient(session: session)
        let validData = Data()
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), validData, nil)
        }

        sut.get(to: url, with: validData) { result in
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

    func testNativeHTTPGetClient_makeGetRequest_ShouldReturnUnauthorized() {
        // Arrange
        let sut = NativeHTTPGetClient(session: session)
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: 401), nil, nil)
        }

        sut.get(to: url, with: nil) { result in
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

    func testNativeHTTPGetClient_makeInvalidGetRequest_ShouldReturnUnknown() {
        // Arrange
        let sut = NativeHTTPGetClient(session: session)
        let validData = Data()
        let exp = expectation(description: "Waiting for Request")

        MockURLProtocol.requestHandler = { request in
            return (self.createErrorResponseForRequest(request, code: -1), validData, nil)
        }

        sut.get(to: url, with: validData) { result in
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
