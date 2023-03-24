//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 29/01/23.
//

import Foundation
import Combine
import Core


public class ConSignUpPresenter<UserUseCase: UseCase>: ObservableObject
where
UserUseCase.Request == Any,
UserUseCase.Response == Bool
{
    private var cancellables: Set<AnyCancellable> = []
    
    private let _userUseCase: UserUseCase
    
    @Published public var item: Bool = false
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isLogin: Bool = false
    
    
    
    @Published public var name = ""
    @Published public var email = ""
    @Published public var password = ""
    @Published public var confrimPassword = ""
    
    @Published public var nameMessage = ""
    @Published public var emailMessage = ""
    @Published public var passwordMessage = ""
    @Published public var confrimPasswordMessage = ""
    
    public let namePlaceholder = "Full Name (Based on KTP)"
    public let emailPlaceholder = "Email Address"
    public let passwordPlaceholder = "Password"
    public let confrimPasswordPlaceholder = "Confrim Password"
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    private var isValidEmailPubliser: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                return email.isEmpty || isValidEmailAddress(emailAddressString: email)
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password.isEmpty || password.count >= 6
            }
            .eraseToAnyPublisher()
    }
    
    private var isConfrimPasswordEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confrimPassword)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { password, confrimPassword in
                return confrimPassword.isEmpty || password == confrimPassword
            }
            .eraseToAnyPublisher()
    }
    
    
    
    public init(
        userUseCase: UserUseCase
    ){
        _userUseCase = userUseCase
        
        
        isPasswordEmptyPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Password must be at least 6 characters long "
            }
            .assign(to:\.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        isValidEmailPubliser
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Email not valid"
            }
            .assign(to: \.emailMessage, on: self)
            .store(in: &cancellableSet)
        
        isConfrimPasswordEqualPublisher
            .receive(on: RunLoop.main)
            .map{ valid in
                valid ? "" : "Confirm password doesn't match"
            }
            .assign(to: \.confrimPasswordMessage, on: self)
            .store(in: &cancellableSet)
    }
    
    public func register(request: UserUseCase.Request) {
        isLoading = true
        _userUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLogin = true
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
        
}

