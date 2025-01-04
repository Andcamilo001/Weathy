//
//  WeathyLoginFunctionalTest.swift
//  WeathyLoginTests
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import Quick
import Nimble
@testable import WeathyLogin

class WeathyLoginFunctionalTest: QuickSpec {
    
    override func spec() {
        
        var viewModel: LoginViewModel!
        var mockRepository: MockLoginRepository!
        
        describe("LoginViewModel") {
            
            WeathyLoginFunctionalTest.beforeEach {
                mockRepository = MockLoginRepository()
                viewModel = LoginViewModel(repository: mockRepository)
            }
            
            afterEach {
                viewModel = nil
                mockRepository = nil
            }
            
            context("cuando el correo electrónico y la contraseña son válidos") {
                
                it("el botón de login debe estar habilitado") {
                    let validEmail = "test@example.com"
                    let validPassword = "password123"
                    expect(viewModel.isLoginButtonEnabled(email: validEmail, password: validPassword)).to(beTrue())
                }
                
                it("debe iniciar sesión correctamente y establecer el usuario") {
                    // Arrange
                    let validEmail = "test@example.com"
                    let validPassword = "password123"
                    let expectedUser = User(email: validEmail)
                    
                    mockRepository.mockLoginResult = .success(expectedUser)
                    
                    // Act
                    viewModel.login(email: validEmail, password: validPassword)
                    
                    // Assert
                    expect(viewModel.user).to(equal(expectedUser))
                    expect(viewModel.emailAuth).to(beTrue())
                    expect(viewModel.isLoading).to(beFalse())
                }
                
            }
            
            context("cuando el correo electrónico o la contraseña son inválidos") {
                
                it("el botón de login debe estar deshabilitado para un correo inválido") {
                    let invalidEmail = "invalid-email"
                    let validPassword = "password123"
                    expect(viewModel.isLoginButtonEnabled(email: invalidEmail, password: validPassword)).to(beFalse())
                }
                
                it("el botón de login debe estar deshabilitado para una contraseña inválida") {
                    let validEmail = "test@example.com"
                    let invalidPassword = "short"
                    expect(viewModel.isLoginButtonEnabled(email: validEmail, password: invalidPassword)).to(beFalse())
                }
                
                it("debe mostrar un mensaje de error si el login falla") {
                    // Arrange
                    let validEmail = "test@example.com"
                    let validPassword = "password123"
                    let errorMessage = "Invalid credentials"
                    
                    mockRepository.mockLoginResult = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    
                    // Act
                    viewModel.login(email: validEmail, password: validPassword)
                    
                    // Assert
                    expect(viewModel.messageError).to(equal(errorMessage))
                    expect(viewModel.isLoading).to(beFalse())
                }
                
            }
            
            context("cuando se obtiene el usuario actual") {
                
                it("debe establecer el usuario actual si existe uno") {
                    // Arrange
                    let expectedUser = User(email: "test@example.com")
                    mockRepository.mockCurrentUser = expectedUser
                    
                    // Act
                    viewModel.getCurrentUser()
                    
                    // Assert
                    expect(viewModel.user).to(equal(expectedUser))
                }
                
                it("debe ser nil si no hay un usuario actual") {
                    // Arrange
                    mockRepository.mockCurrentUser = nil
                    
                    // Act
                    viewModel.getCurrentUser()
                    
                    // Assert
                    expect(viewModel.user).to(beNil())
                }
                
            }
            
        }
    }
}
