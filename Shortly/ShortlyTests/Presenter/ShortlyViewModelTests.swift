//
//  ShortlyViewModelTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 29/08/21.
//

import XCTest
import Combine
@testable import Shortly

class ShortlyViewModel: ObservableObject, ShortlyViewModelProtocol {

    @Published public var shortlyURLs: [ShortlyURLViewModel] = []

    private var fetchAllURLs: FetchAllAction

    init(fetchAllURLs: @escaping FetchAllAction) {
        self.fetchAllURLs = fetchAllURLs
    }

    public func onAppear() {
        self.getAllURLs()
    }

    private func getAllURLs() {
        self.fetchAllURLs { [weak self] urls in
            self?.shortlyURLs = urls.compactMap {
                ShortlyURLViewModel(code: $0.code,
                                    shortLink: $0.shortLink,
                                    originalLink: $0.originalLink)
            }
        }
    }
}

protocol ShortlyViewModelProtocol {
    typealias FetchAllAction = (([ShortlyURLModel]) -> Void) -> Void

    func onAppear()
}

class ShortlyViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testShortlyViewModel_fetchAll_shouldReturnAllURLsToView() {

        var fetchAllCalledCount = 0
        let sut = ShortlyViewModel(fetchAllURLs: { completion in
            fetchAllCalledCount += 1
            completion([ShortlyURLModel(code: "KCveN",
                                        shortLink: "shrtco.de/KCveN",
                                        fullShortLink: "https://shrtco.de/KCveN",
                                        shortLink2: "9qr.de/KCveN",
                                        fullShortLink2: "https://9qr.de/KCveN",
                                        shareLink: "shrtco.de/share/KCveN",
                                        fullShareLink: "https://shrtco.de/share/KCveN",
                                        originalLink: "http://example.org/very/long/link.html")])
        })

        // Act
        sut.onAppear()

        _ = sut.$shortlyURLs.sink { urls in
            XCTAssertEqual(urls.count, 1)
        }

        // Assert
        XCTAssertEqual(fetchAllCalledCount, 1)

    }
}
