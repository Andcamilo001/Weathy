//
//  WeathyLoginUITest.swift
//  WeathyLoginTests
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import Nimble
import Quick
import Nimble_Snapshots
import SwiftUI
@testable import WeathyLogin

final class WeathyLoginUITest: QuickSpec {
    
    override func spec() {
        
        describe("LoginView") {
            
            it("should match the snapshot of the Login view on iPhone 15") {
                
                let loginView = Login()
                let hostingController = UIHostingController(rootView: loginView)
                hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
                expect(hostingController.view).to(haveValidSnapshot())
            }
        }
    }
}
