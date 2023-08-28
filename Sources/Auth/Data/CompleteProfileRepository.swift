//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 01/06/23.
//

import Foundation
import Core
import Combine

public struct CompleteProfileRepository<
    UserLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper> : Repository
where
UserLocaleDataSource.Request == Any,
UserLocaleDataSource.Response == UserEntity,
RemoteDataSource.Request == Any,
RemoteDataSource.Response == UserResponse,
Transformer.Request == Any,
Transformer.Response == UserResponse,
Transformer.Entity == UserEntity,
Transformer.Domain == UserModel

{
    public typealias Request = Any
    public typealias Response = UserModel
    
    private let _localeDataSource: UserLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: UserLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ){
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }

    public func execute(request: Request?) -> AnyPublisher<UserModel, Error> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .flatMap { _localeDataSource.update(id: 0, entity: $0) }
            .filter { $0 }
            .flatMap{ _ in _localeDataSource.get(id: "")
                    .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
    }
        
}

