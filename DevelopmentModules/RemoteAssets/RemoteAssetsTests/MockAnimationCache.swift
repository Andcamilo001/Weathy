//
//  MockAnimationCache.swift
//  RemoteAssetsTests
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import Foundation
import Lottie
import SwiftUI


class MockAnimationCache: AnimationCacheProvider {
    
    private var cache = [String: Lottie.LottieAnimation]()
    
    func animation(forKey: String) -> Lottie.LottieAnimation? {
        return cache[forKey]
    }
    
    func setAnimation(_ animation: Lottie.LottieAnimation, forKey: String) {
        cache[forKey] = animation
    }
    
    func clearCache() {
        cache.removeAll()
    }
}
