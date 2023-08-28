//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 01/06/23.
//

import Foundation
import Core
import RealmSwift

//public struct CompleteProfileTransformer: Mapper {
//
//
//    public typealias Request = Any
//    public typealias Response = CompleteProfileDataResponse
//    public typealias Entity = UserEntity
//    public typealias Domain = UserModel
//
//    public init(){}
//
//    public func transformResponseToEntity(request: Any?, response: CompleteProfileDataResponse) -> UserEntity {
//       fatalError()
//
//    }
//
//    public func transformEntityToDomain(entity: UserEntity) -> UserModel {
//
//        return UserModel(
//            user_id: entity.user_id ?? "",
//            user_code: entity.user_code ?? "",
//            role: entity.role ?? "",
//            type: entity.type ?? "",
//            no_type: entity.no_type ?? "",
//            doctor_id: entity.doctor_id ?? "",
//            speciality_id: entity.speciality_id ?? 0,
//            speciality_slug: entity.speciality_slug ?? "",
////                hospital: entity.hospital ?? [],
//            hospital_active: UserHospitalModel(name: entity.hospital_active?.name ?? "", doctor_hospital_id: entity.hospital_active?.doctor_hospital_id ?? 0),
//            name: entity.name ?? "",
//            username: entity.username ?? "",
//            gender: entity.gender ?? "",
//            place_of_birth: entity.place_of_birth ?? "",
//            date_of_birth: entity.date_of_birth ?? "",
//            is_actived: entity.is_actived ?? false,
//            email: entity.email ?? "",
//            phone_number: entity.phone_number ?? "",
//            country_id: entity.country_id ?? "",
//            country_name: entity.country_name ?? "",
//            provinces_id: entity.provinces_id ?? "",
//            provinces_name: entity.provinces_name ?? "",
//            regencies_cities_id: entity.regencies_cities_id ?? "",
//            regencies_cities_name: entity.regencies_cities_name ?? "",
//            villages_id: entity.villages_id ?? "",
//            villages_name: entity.villages_name ?? "",
//            districts_id: entity.districts_id ?? "",
//            districts_name: entity.districts_name ?? "",
//            postal_code: entity.postal_code ?? "",
//            rt: entity.rt ?? "",
//            rw: entity.rw ?? "",
//            home_address: entity.home_address ?? "",
//            current_address: entity.current_address ?? "",
//            current_country_name: entity.current_country_name ?? "",
//            current_country_id: entity.current_country_id ?? "",
//            current_provinces_id: entity.current_provinces_id ?? "",
//            current_provinces_name: entity.current_provinces_name ?? "",
//            current_regencies_cities_id: entity.current_regencies_cities_id ?? "",
//            current_regencies_cities_name: entity.current_regencies_cities_name ?? "",
//            current_villages_id: entity.current_villages_id ?? "",
//            current_villages_name: entity.current_villages_name ?? "",
//            current_districts_id: entity.current_districts_id ?? "",
//            current_districts_name: entity.current_disease_name ?? "",
//            current_postal_code: entity.current_postal_code ?? "",
//            current_rt: entity.current_rt ?? "",
//            current_rw: entity.current_rw ?? "",
//            obgyn: entity.obgyn ?? "",
//            current_disease_name: entity.current_disease_name ?? "",
//            updated_at_current_disease: entity.updated_at_current_disease ?? "",
//            current_ews: entity.current_ews ?? "",
//            updated_at_current_ews: entity.updated_at_current_ews ?? "",
//            created_at: entity.created_at ?? "",
//            thumb: entity.thumb
//        )
//    }
//
//    public func transformResponseToDomain(request: Request?, response: CompleteProfileDataResponse) -> UserModel {
//        fatalError()
//    }
//}
