//
//  MemoryCacheProvider.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import UIKit

internal final class MemoryCacheProvider: CacheProtocol {
    /*
     To limit the amount of objects our cache should hold, set the countLimit property to anything higher than 0.
     0 means no limit, so the cache will keep storing objects indefinitely (unless the system really needs some memory, that is).
     */
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit // Automatic eviction
        return cache
    }()
    
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private let config: CacheConfig
    private var loggingEnabled: Bool

    init(config: CacheConfig = CacheConfig.defaultConfig, loggingEnabled: Bool = false) {
        self.config = config
        self.loggingEnabled = loggingEnabled
    }

    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}

internal extension MemoryCacheProvider {
    
    func image(for url: URL) -> UIImage? {
        consoleOutput("MemoryCacheProvider: Query cache for url \(url.absoluteURL)")
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            consoleOutput("MemoryCacheProvider: CacheHit for url \(url.absoluteURL)")
            return decodedImage
        }
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            consoleOutput("MemoryCacheProvider: CacheHit for url \(url.absoluteURL)")
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(decodedImage as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        consoleOutput("MemoryCacheProvider: CacheMiss url \(url.absoluteURL)")
        return nil
    }

    func insertImage(_ image: UIImage?, for url: URL) {
        consoleOutput("MemoryCacheProvider: Cache store for url \(url.absoluteURL)")
        guard let image = image else {
            return removeImage(for: url)
        }
        let decompressedImage = image.decodedImage()
        imageCache.setObject(image, forKey: url as AnyObject, cost: 1)
        decodedImageCache.setObject(decompressedImage as AnyObject, forKey: url as AnyObject, cost: decompressedImage.diskSize)
    }

    func removeImage(for url: URL) {
        consoleOutput("MemoryCacheProvider: Remove image for url \(url.absoluteURL)")
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }

    func removeAllImages() {
        consoleOutput("MemoryCacheProvider: Purse Cache")
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }
}

extension MemoryCacheProvider {
    private func consoleOutput(_ items: Any...) {
        guard loggingEnabled else { return }
        debugPrint(items)
    }
}
