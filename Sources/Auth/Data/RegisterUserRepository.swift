//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 29/01/23.
//

import Foundation
import Core
import Combine

public struct RegisterUserRepository<
    RemoteDataSource: DataSource
> : Repository
where
RemoteDataSource.Request == Any,
RemoteDataSource.Response == Bool {
  
    
    
    public typealias Request = Any
    public typealias Response = Bool
    
    private let _remoteDataSource: RemoteDataSource
 
    public init(
        remoteDataSource: RemoteDataSource
    ){
        _remoteDataSource = remoteDataSource
    }
    
    public func execute(request: Any?) -> AnyPublisher<Bool, Error> {
        return _remoteDataSource.execute(request: request)
            .eraseToAnyPublisher()
    }
}
