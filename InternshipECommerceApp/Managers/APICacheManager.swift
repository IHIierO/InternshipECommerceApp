//
//  APICacheManager.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import Foundation

// Manager in memory session scoped API caches
final class APICacheManager {
    // API URL: Data
    
    private var cacheDictionary: [Endpoint: NSCache<NSString, NSData>] = [:]
    
    private var cache = NSCache<NSString, NSData>()
    
    init() {
        setupCache()
    }
    
    // MARK: - Public
    
    public func cacheResponse(for endpoint: Endpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: Endpoint, url: URL?, data: Data){
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private
    private func setupCache() {
        Endpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}
