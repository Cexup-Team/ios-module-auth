//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 29/01/23.
//

import Foundation
import Combine
import Core


public class ConSignUpPresenter<UserUseCase: UseCase, DelAccUseCase: UseCase>: ObservableObject
where
UserUseCase.Request == Any,
UserUseCase.Response == Bool,
DelAccUseCase.Request == Any,
DelAccUseCase.Response == Bool
{
    private var cancellables: Set<AnyCancellable> = []
    
    private let _userUseCase: UserUseCase
    private let _delAccUseCase: DelAccUseCase
    
    @Published public var item: Bool = false
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isSuccess: Bool = false
    @Published public var isError: Bool = false
    @Published public var isLogin: Bool = false
    @Published public var isValidForm: Bool = false
    @Published public var selectionSignUp: Int? = nil
    @Published public var showSignUp: Bool = false
    
    
    @Published public var delAccItem: Bool?
    @Published public var delAccAction: Bool?
    @Published public var delAccErrorMessage: String = ""
    @Published public var delAccIsLoading: Bool = false
    @Published public var delAccIsSuccess: Bool = false
    @Published public var delAccIsError: Bool = false
    
    @Published public var genderItem = [
        slcItemModel(id: 1, name: "Male"),
        slcItemModel(id: 2, name: "Female"),
    ]
    
    
    @Published public var name = ""
    @Published public var email = ""
    @Published public var dateOfBirth = ""
    @Published public var gender = ""
    @Published public var password = ""
    @Published public var confrimPassword = ""
    
    @Published public var nameMessage = ""
    @Published public var emailMessage = ""
    @Published public var dateOfBirthMessage = ""
    @Published public var genderMessage = ""
    @Published public var passwordMessage = ""
    @Published public var confrimPasswordMessage = ""
    
    public let namePlaceholder = "Full Name (Based on KTP)"
    public let emailPlaceholder = "Email Address"
    public let dateOfBirthPlaceholder = "Date Of Birth"
    public let genderPlaceholder = "Gender"
    public let passwordPlaceholder = "Password"
    public let confrimPasswordPlaceholder = "Confrim Password"
    
    @Published public var genderShowModel = false
    @Published public var filterDateOfBirth = Date()
    @Published public var checkPrivacyPolicy = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published public var nameTextField = false {
        didSet {
            guard nameTextField != oldValue else { return }
            if nameTextField {
                emailTextField = false
                passwordTextField = false
                confirmPasswordTextField = false
                dateOfBirthTextField = false
                genderTextField = false
            }
        }
    }
    
    @Published public var emailTextField = false {
        didSet {
            guard emailTextField != oldValue else { return }
            if emailTextField {
                nameTextField = false
                passwordTextField = false
                confirmPasswordTextField = false
                dateOfBirthTextField = false
                genderTextField = false
            }
        }
    }
    
    @Published public var dateOfBirthTextField = false {
        didSet {
            guard dateOfBirthTextField != oldValue else { return }
            if dateOfBirthTextField {
                nameTextField = false
                passwordTextField = false
                confirmPasswordTextField = false
                emailTextField = false
                genderTextField = false
            }
        }
    }
    
    @Published public var genderTextField = false {
        didSet {
            guard genderTextField != oldValue else { return }
            if genderTextField {
                nameTextField = false
                passwordTextField = false
                confirmPasswordTextField = false
                emailTextField = false
                dateOfBirthTextField = false
                
            }
        }
    }
    
    @Published public var passwordTextField = false {
        didSet {
            guard passwordTextField != oldValue else { return }
            if passwordTextField {
                nameTextField = false
                emailTextField = false
                confirmPasswordTextField = false
                dateOfBirthTextField = false
                genderTextField = false
            }
        }
    }
    
    @Published public var confirmPasswordTextField = false {
        didSet {
            guard confirmPasswordTextField != oldValue else { return }
            if confirmPasswordTextField {
                nameTextField = false
                emailTextField = false
                passwordTextField = false
                dateOfBirthTextField = false
                genderTextField = false
            }
        }
    }
    
    

    
    private var isFilterDateOfBirth: AnyPublisher<String, Never> {
        $filterDateOfBirth
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { dateOfBirth in
                return dateFormatterDateOfBirthFromDate(dateVal: dateOfBirth)
            }
            .eraseToAnyPublisher()
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
    
    private var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
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
    
    private var isPassAndConfEmptyPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confrimPassword)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { password, confirmPassword in
                return !password.isEmpty && !confirmPassword.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var isEmptyNameAndGender: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($name, $gender)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { name, gender in
                return !name.isEmpty && !gender.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidFormPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isEmptyNameAndGender, isPassAndConfEmptyPublisher, isValidEmailPubliser, isConfrimPasswordEqualPublisher)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { nameEmail, pass, email, passConf in
                return nameEmail && pass && email && passConf
            }
            .eraseToAnyPublisher()
    }


    
    
    public init(
        userUseCase: UserUseCase,
        delAccUseCase: DelAccUseCase
    ){
        _userUseCase = userUseCase
        _delAccUseCase = delAccUseCase
        
        isFilterDateOfBirth
            .receive(on: RunLoop.main)
            .assign(to: \.dateOfBirth, on: self)
            .store(in: &cancellableSet)
        
        
        isValidPasswordPublisher
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
        
        isValidFormPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidForm, on: self)
            .store(in: &cancellableSet)
    }
    
    public func setDefaultTextField(){
        name = ""
        email = ""
        dateOfBirth = ""
        gender = ""
        password = ""
        confrimPassword = ""
        
        nameMessage = ""
        emailMessage = ""
        dateOfBirthMessage = ""
        genderMessage = ""
        passwordMessage = ""
        confrimPasswordMessage = ""
        
        nameTextField = false
        emailTextField = false
        dateOfBirthTextField = false
        genderTextField = false
        passwordTextField = false
        confirmPasswordTextField = false
        
    }
    
    public func register(request: UserUseCase.Request) {
        isLoading = true
        isError = false
        isSuccess = false

        _userUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isSuccess = true
                    self.showSignUp = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    
    public func delAcc(request: DelAccUseCase.Request) {
        delAccIsLoading = true
        delAccIsError = false
        delAccIsSuccess = false
        
        _delAccUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.delAccErrorMessage = error.localizedDescription
                    self.delAccIsError = true
                    self.delAccIsLoading = false
                    self.delAccAction = false
                case .finished:
                    self.delAccIsSuccess = true
                    self.delAccIsLoading = false
                }
            }, receiveValue: { item in
                self.delAccItem = item
                self.delAccAction = true
            })
            .store(in: &cancellables)
    }

        
}

