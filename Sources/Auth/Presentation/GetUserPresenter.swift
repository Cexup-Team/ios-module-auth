//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 11/06/23.
//

import Foundation
import Combine
import Core

public class GetUserPresenter<UserUseCase: UseCase>: ObservableObject
where
UserUseCase.Request == Any,
UserUseCase.Response == UserModel
{
    private var cancellableSet: Set<AnyCancellable> = []
    
    private let _userUseCase: UserUseCase
    
    @Published public var item: UserModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isSuccess: Bool = false
    @Published public var isError: Bool = false
    
    public init(userUseCase: UserUseCase){
        _userUseCase = userUseCase
    }
    
    public func getUser(){
        _userUseCase.execute(request: "")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    
                case .finished:
                    self.errorMessage = ""
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellableSet)
    }
}
