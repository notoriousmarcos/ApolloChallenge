//
//  ShortlyViewModelTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 29/08/21.
//

import XCTest
import Combine
@testable import Shortly

class ShortlyViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testShortlyViewModel_fetchAll_shouldReturnAllURLsToView() {

        var fetchAllCalledCount = 0
        let sut = ShortlyViewModel(
            fetchAllURLs: { completion in
                fetchAllCalledCount += 1
                completion([ShortlyURLModel(code: "KCveN",
                                            shortLink: "shrtco.de/KCveN",
                                            fullShortLink: "https://shrtco.de/KCveN",
                                            shortLink2: "9qr.de/KCveN",
                                            fullShortLink2: "https://9qr.de/KCveN",
                                            shareLink: "shrtco.de/share/KCveN",
                                            fullShareLink: "https://shrtco.de/share/KCveN",
                                            originalLink: "http://example.org/very/long/link.html")])
            },
            saveURL: { _,_  in },
            fetchURL: { _,_  in },
            removeURL: { _,_  in })

        // Act
        sut.onAppear()

        _ = sut.$shortlyURLViewModels.sink { urls in
            XCTAssertEqual(urls.count, 1)
        }

        // Assert
        XCTAssertEqual(fetchAllCalledCount, 1)
    }

    func testShortlyViewModel_remove_shouldReturnAllURLsToView() {
        var allURLs = [ShortlyURLModel(code: "KCveN",
                                       shortLink: "shrtco.de/KCveN",
                                       fullShortLink: "https://shrtco.de/KCveN",
                                       shortLink2: "9qr.de/KCveN",
                                       fullShortLink2: "https://9qr.de/KCveN",
                                       shareLink: "shrtco.de/share/KCveN",
                                       fullShareLink: "https://shrtco.de/share/KCveN",
                                       originalLink: "http://example.org/very/long/link.html")]
        var fetchAllCalledCount = 0
        let sut = ShortlyViewModel(
            fetchAllURLs: { completion in
                fetchAllCalledCount += 1
                completion(allURLs)
            },
            saveURL: { _,_  in },
            fetchURL: { _,_  in },
            removeURL: { model, completion in
                XCTAssertEqual(model.code, "KCveN")
                allURLs = []
                completion(true)
            })

        // Act
        sut.onAppear()
        sut.deleteURL(ShortlyURLViewModel(code: "KCveN",
                                          shortLink: "shrtco.de/KCveN",
                                          originalLink: "http://example.org/very/long/link.html"))

        _ = sut.$shortlyURLViewModels.sink { urls in
            XCTAssertEqual(urls.count, 0)
        }

        // Assert
        XCTAssertEqual(fetchAllCalledCount, 2)
    }

    func testShortlyViewModel_fetch_shouldReturnAllURLsToView() {
        let url = ShortlyURLModel(code: "KCveN",
                              shortLink: "shrtco.de/KCveN",
                              fullShortLink: "https://shrtco.de/KCveN",
                              shortLink2: "9qr.de/KCveN",
                              fullShortLink2: "https://9qr.de/KCveN",
                              shareLink: "shrtco.de/share/KCveN",
                              fullShareLink: "https://shrtco.de/share/KCveN",
                              originalLink: "http://example.org/very/long/link.html")
        var allURLs = [ShortlyURLModel]()
        let useCaseModel = FetchShortURLUseCaseModel(url: "http://example.org/very/long/link.html")
        var fetchAllCalledCount = 0
        var isGeneratingBehaviour = [Bool]()
        let sut = ShortlyViewModel(
            fetchAllURLs: { completion in
                fetchAllCalledCount += 1
                completion(allURLs)
            },
            saveURL: { model, completion in
                XCTAssertEqual(model, url)
                allURLs = [url]
                completion(true)
            },
            fetchURL: { model, completion in
                XCTAssertEqual(model, useCaseModel)
                completion(url)
            },
            removeURL: { _,_ in })

        // Act
        sut.onAppear()
        let sub = sut.$isGeneratingURL.sink { isGenerating in
            isGeneratingBehaviour.append(isGenerating)
        }

        sut.createURL("http://example.org/very/long/link.html")

        _ = sut.$shortlyURLViewModels.sink { urls in
            XCTAssertEqual(urls.count, 1)
        }

        sub.cancel()

        // Assert
        XCTAssertEqual(fetchAllCalledCount, 2)
        XCTAssertEqual(isGeneratingBehaviour, [false, true, false])
    }
}
