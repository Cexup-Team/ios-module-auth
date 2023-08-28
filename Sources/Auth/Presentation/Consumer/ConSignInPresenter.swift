//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 28/01/23.
//

import Foundation
import Combine
import Core

public class ConSignInPresenter<UserUseCase: UseCase>: ObservableObject
where
UserUseCase.Request == Any,
UserUseCase.Response == UserModel
{
    private var cancellables: Set<AnyCancellable> = []
    
    private let _userUseCase: UserUseCase
    
    @Published public var item: UserModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isSuccess: Bool = false
    @Published public var isError: Bool = false
    @Published public var isLogin: Bool = false
    @Published public var isNavLogin: Int? = nil
    
    
    @Published public var user: UserModel? = nil
    @Published public var loadingState: Bool = false
    
    @Published public var email = ""
    @Published public var password = ""
    
    @Published public var emailMessage = ""
    @Published public var passwordMessage = ""
    
    public let emailPlaceholder = "Email or Phone number"
    public let passwordPlaceholder = "Password"
    
    
    @Published public var emailTextField = false {
        didSet {
            guard emailTextField != oldValue else { return }
            if emailTextField {
                passwordTextField = false
            }
        }
    }
    
    @Published public var passwordTextField = false {
        didSet {
            guard passwordTextField != oldValue else { return }
            if passwordTextField {
                emailTextField = false
            }
        }
    }
    
    private var isValidEmailPubliser: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                return email.isEmpty || isValidEmailAddress(emailAddressString: email)
            }
            .eraseToAnyPublisher()
    }

    
    public init(
        userUseCase: UserUseCase
    ){
        _userUseCase = userUseCase
    }
    
    public func resetTextField(){
        self.email = ""
        self.password = ""
        self.emailMessage = ""
        self.passwordMessage = ""
        self.emailTextField = false
        self.passwordTextField = false
    }
    
    public func setDefaultTextField(){
        email = ""
        password = ""

        emailMessage = ""
        passwordMessage = ""
        
        emailTextField = false
        passwordTextField = false
    }
    
    public func login(request: UserUseCase.Request) {
        self.isLoading = true
        self.isSuccess = false
        self.isError = false
        
        _userUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
//                    self.isLogin = true
                    self.isLoading = false
                    self.isSuccess = true
                }
            }, receiveValue: { item in
                self.item = item
//                self.isNavLogin = 1
            })
            .store(in: &cancellables)
    }
        
}
