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
        return Future<Bool, Error> { completion in
            do {
                let user = _realm.objects(UserEntity.self).first!
                try _realm.write {
                    user.type = entity.type
                    user.no_type = entity.no_type
                    user.name = entity.name
                    user.username = entity.username
                    user.gender = entity.gender
                    user.place_of_birth = entity.place_of_birth
                    user.date_of_birth = entity.date_of_birth
                    user.is_actived = entity.is_actived
                    user.phone_number = entity.phone_number
                    user.country_id = entity.country_id
                    user.country_name = entity.country_name
                    user.provinces_id = entity.provinces_id
                    user.provinces_name = entity.provinces_name
                    user.regencies_cities_id = entity.regencies_cities_id
                    user.regencies_cities_name = entity.regencies_cities_name
                    user.villages_id = entity.villages_id
                    user.villages_name = entity.villages_name
                    user.districts_id = entity.districts_id
                    user.districts_name = entity.districts_name
                    user.postal_code = entity.postal_code
                    user.rt = entity.rt
                    user.rw = entity.rw
                    user.home_address = entity.home_address
                    user.current_address = entity.current_address
                    user.current_country_name = entity.current_country_name
                    user.current_country_id = entity.current_country_id
                    user.current_provinces_id = entity.current_provinces_id
                    user.current_provinces_name = entity.current_provinces_name
                    user.current_regencies_cities_id = entity.current_regencies_cities_id
                    user.current_regencies_cities_name = entity.current_regencies_cities_name
                    user.current_villages_id = entity.current_villages_id
                    user.current_villages_name = entity.current_villages_name
                    user.current_districts_id = entity.current_districts_id
                    user.current_districts_name = entity.current_districts_name
                    user.current_postal_code = entity.current_postal_code
                    user.current_rt = entity.current_rt
                    user.current_rw = entity.current_rw
                    completion(.success(true))
                }
            }catch {
                completion(.failure(DataBaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
