//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 04/01/23.
//

import Foundation
import Core
import RealmSwift
import Combine

public struct UserLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = UserEntity
    
    private let _realm: Realm
    
    public init(realm: Realm){
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[UserEntity], Error> {
        fatalError()
    }
    
    public func add(entities: [UserEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for usr in entities {
                        _realm.add(usr, update: .all)
                    }
                    completion(.success(true))
                }
            }catch {
                completion(.failure(DataBaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String?) -> AnyPublisher<UserEntity, Error> {
        return Future<UserEntity, Error> { completion in
            let usr: Results<UserEntity> = {
                _realm.objects(UserEntity.self)
            }()
            
            guard let user = usr.first else {
                completion(.failure(DataBaseError.requestFailed))
                return
            }
            
            completion(.success(user))
            
        }.eraseToAnyPublisher()
    }
    
    public func addOne(entity: UserEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.add(entity, update: .all)
                    completion(.success(true))
                }
            }catch {
                completion(.failure(DataBaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: UserEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    
    
}
