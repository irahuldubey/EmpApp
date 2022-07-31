//
//  ImageLoader.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import Combine
import UIKit

public final class ImageDownloadManager {

    public static let shared = ImageDownloadManager()

    private let cache: CacheProtocol
    
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    public init(cache: CacheType = .memoryCache) {
        self.cache = cache.cacheProvider
    }

    public func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {(data, response) -> UIImage? in
                 return UIImage(data: data)
            }
            .catch { error in
                return Just(nil)
            }
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
