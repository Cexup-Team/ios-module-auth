//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 11/01/23.
//

import Foundation
import Core
import Combine

public struct GetUserRepository<
    UserLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
UserLocaleDataSource.Request == Any,
UserLocaleDataSource.Response == UserEntity,
Transformer.Request == Any,
Transformer.Response == UserResponse,
Transformer.Entity == UserEntity,
Transformer.Domain == UserModel {
    
    public typealias Request = Any
    public typealias Response = UserModel
    
    private let _localeDataSource: UserLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: UserLocaleDataSource,
        mapper: Transformer
    ){
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<UserModel, Error> {
        return _localeDataSource.get(id: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
    
    
}
