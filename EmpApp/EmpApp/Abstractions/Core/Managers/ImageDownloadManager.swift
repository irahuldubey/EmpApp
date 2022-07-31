//
//  ImageLoader.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import Combine
import UIKit

internal final class ImageDownloadManager {

    internal static let shared = ImageDownloadManager()

    private let cacheProvider: CacheProviderProtocol
    
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    internal init(cacheType: CacheType = .diskCache(dir: "EMPCACHE")) {
        self.cacheProvider = CacheFactory.cacheProvider(type: cacheType)
    }

    internal func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let imageData = cacheProvider.load(key: url.absoluteString),
            let imageFromData: UIImage = UIImage(data: imageData) {
            return Just(imageFromData).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {(data, response) -> UIImage? in
                 return UIImage(data: data)
            }
            .catch { error in
                return Just(nil)
            }
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let image = image, let imageData = image.pngData() as? NSData else { return }
                cacheProvider.save(key: url.absoluteString, value: imageData)
            })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    internal func clearCache() {
        cacheProvider.clearCache()
    }
}
