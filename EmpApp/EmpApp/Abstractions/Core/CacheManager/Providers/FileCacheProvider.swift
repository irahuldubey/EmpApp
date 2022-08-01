//
//  FileCacheProvider.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

class FileCacheProvider: CacheProviderProtocol {
    
    private let cacheDirectory: String
    private let manager: FileManager
    
    init(cacheDir: String, manager: FileManager = FileManager.default) {
        cacheDirectory = cacheDir
        self.manager = manager
    }
    
    func loadData(key: String) -> Data? {
        guard let path = fileURL(fileName: key) else {
            return nil
        }
        var data: Data?
        do {
            data = try Data(contentsOf: path)
        } catch {
            debugPrint("FileCacheProvider - Failed to create object \(error)")
        }
        return data
    }
    
    func saveData(key: String, value: NSData?) {
        guard let path = fileURL(fileName: key) else { return }
        guard let newValue = value as Data? else {
            try? manager.removeItem(at: path)
            return
        }
        do {
            try newValue.write(to: path, options: .atomic)
        } catch {
            debugPrint("FileCacheProvider Failed to write data on file \(error)")
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
            debugPrint("FileCacheProvider Cannot fetch from cache \(error)")
            return nil
        }
        return cachesDir?.appendingPathComponent(escapedName)
    }
    
    private func cachesDirectory() throws -> URL? {
        var cachesDir: URL? = nil
        do {
            cachesDir = try manager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(cacheDirectory, isDirectory: true)
        } catch {
            throw error
        }
        guard let directory = cachesDir else { return nil }
        do {
            try manager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
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
            debugPrint("FileCacheProvider to fetch from dirctory \(error)")
        }
        guard let dir = cachesDir else {
            return
        }
        do {
            try manager.removeItem(at: dir)
        } catch {
            debugPrint("FileCacheProvider deleting files from the caches directory: \(error)")
        }
    }

     func burstCache() {
        deleteCacheDirectory()
    }
}
