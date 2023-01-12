//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 04/01/23.
//

import Foundation
import Combine
import Core

public class AuthPresenter<UserUseCase: UseCase>: ObservableObject
where
UserUseCase.Request == Any,
UserUseCase.Response == UserModel
{
    private var cancellables: Set<AnyCancellable> = []
    
    private let _userUseCase: UserUseCase
    
    @Published public var item: UserModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isLogin: Bool = false
    
    public init(
        userUseCase: UserUseCase
    ){
        _userUseCase = userUseCase
    }
    
    public func login(request: UserUseCase.Request) {
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
                    self.isLoading = false
                    self.isLogin = true
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
        
}
