//
//  FileCacheProvider.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

internal class FileCacheProvider: CacheProviderProtocol {
    
    private var loggingEnabled: Bool
    private let cacheDirectory: String
    
    internal init(cacheDir: String, enableLogging: Bool = true) {
        cacheDirectory = cacheDir
        loggingEnabled = enableLogging
    }
    
    internal func load(key: String) -> Data? {
        guard let path = fileURL(fileName: key) else {
            return nil
        }
        var data: Data?
        do {
            data = try Data(contentsOf: path)
        } catch {
            consoleOutput("FileCacheProvider - Failed to create object", error)
        }
        return data
    }
    
    internal func save(key: String, value: NSData?) {
        guard let path = fileURL(fileName: key) else { return }
        guard let newValue = value as Data? else {
            try? FileManager.default.removeItem(at: path)
            return
        }
        do {
            try newValue.write(to: path, options: .atomic)
        } catch {
            consoleOutput("FileCacheProvider Failed to write data on file", error)
        }
    }
    
    private func fileURL(fileName name: String) -> URL? {
        guard let escapedName = name.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            return nil
        }
        
        var cachesDir: URL?
        do {
            cachesDir = try cachesDirectory()
        } catch {
            consoleOutput("FileCacheProvider Cannot fetch from cache", error)
            return nil
        }
        return cachesDir?.appendingPathComponent(escapedName)
    }
    
    private func cachesDirectory() throws -> URL? {
        var cachesDir: URL? = nil
        do {
            cachesDir = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(cacheDirectory, isDirectory: true)
        } catch {
            throw error
        }
        guard let directory = cachesDir else { return nil }
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw error
        }
        return directory
    }
    
    private func deleteCacheDirectory() {
        var cachesDir: URL?
        do {
            cachesDir = try cachesDirectory()
        } catch {
            consoleOutput("FileCacheProvider to fetch from dirctory", error)
            return
        }
        guard let dir = cachesDir else {
            return
        }
        do {
            try FileManager.default.removeItem(at: dir)
        } catch {
            consoleOutput("FileCacheProvider deleting files from the caches directory: ", error)
        }
    }
    
    private func consoleOutput(_ items: Any...) {
        guard loggingEnabled else { return }
        debugPrint(items)
    }
    
    public func clearCache() {
        deleteCacheDirectory()
    }
}
