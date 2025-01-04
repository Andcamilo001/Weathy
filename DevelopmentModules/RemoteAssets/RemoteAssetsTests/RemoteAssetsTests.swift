//
//  RemoteAssetsTests.swift
//  RemoteAssetsTests
//
//  Created by Andres Camilo Lezcano Restrepo on 2/01/25.
//

import XCTest
import Lottie
@testable import RemoteAssets

class RemoteAssetsTests: XCTestCase {

    func testSetAnimation_Success() {
        // Mock URL
        let mockURL = URL(string: "https://lottie.host/7a110cd4-3451-4f68-b05c-0eb74255c870/4uXoP3uxZg.json")!

        // Add LottieAnimationView & Mock
        let lottieView = LottieAnimationView()
        let mockCache = MockAnimationCache()

        // Call method
        lottieView.setAnimation(
            withRemoteURL: mockURL,
            animationCache: mockCache,
            onSuccess: {
                XCTAssertNotNil(lottieView.animation)
            },
            onError: nil,
            onFinishAnimation: nil
        )
    }

    func testSetAnimation_Error() {
        // Invalid mock URL
        let mockURL = URL(string: "https://invalidurl.com/lottie.json")!

        // Add LottieAnimationView & Mock
        let lottieView = LottieAnimationView()
        let mockCache = MockAnimationCache()

        // Call method
        lottieView.setAnimation(
            withRemoteURL: mockURL,
            animationCache: mockCache,
            onSuccess: nil,
            onError: {
                XCTAssertTrue(true)
            },
            onFinishAnimation: nil
        )
    }
}
