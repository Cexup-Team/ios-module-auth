//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 04/01/23.
//

import Foundation
import Core
import RealmSwift

public struct UserTransformer: Mapper {


    public typealias Request = Any
    public typealias Response = UserResponse
    public typealias Entity = UserEntity
    public typealias Domain = UserModel
    
    public init(){}
    
    public func transformResponseToEntity(request: Any?, response: UserResponse) -> UserEntity {
        let userEntity = UserEntity()
        
        let userHospitalEntity = List<HospitalEntity>()
        let hospitalActiveEntity = HospitalEntity()
        
        
        hospitalActiveEntity.name = response.hospital_active?.name
        hospitalActiveEntity.doctor_hospital_id = response.hospital_active?.doctor_hospital_id
        
        for (_, item) in response.hospital.enumerated() {
            let hospitalEntity = HospitalEntity()
            
            hospitalEntity.name = item.name
            hospitalEntity.doctor_hospital_id = item.doctor_hospital_id
            
            userHospitalEntity.append(hospitalEntity)
        }
        
        userEntity.user_id = response.user_id
        userEntity.user_code = response.user_code
        userEntity.role = response.role
        userEntity.type = response.type
        userEntity.no_type = response.no_type
        userEntity.doctor_id = response.doctor_id
        userEntity.speciality_id = response.speciality_id
        userEntity.speciality_slug = response.speciality_slug
        userEntity.hospital = userHospitalEntity
        userEntity.hospital_active = hospitalActiveEntity
        userEntity.name = response.name
        userEntity.username = response.username
        userEntity.gender = response.gender
        userEntity.place_of_birth = response.place_of_birth
        userEntity.date_of_birth = response.date_of_birth
        userEntity.is_actived = response.is_actived
        userEntity.email = response.email
        userEntity.phone_number = response.phone_number
        userEntity.country_id = response.country_id
        userEntity.country_name = response.country_name
        userEntity.provinces_id = response.provinces_id
        userEntity.provinces_name = response.provinces_name
        userEntity.regencies_cities_id = response.regencies_cities_id
        userEntity.regencies_cities_name = response.regencies_cities_name
        userEntity.villages_id = response.villages_id
        userEntity.villages_name = response.villages_name
        userEntity.districts_id = response.districts_id
        userEntity.districts_name = response.districts_name
        userEntity.postal_code = response.postal_code
        userEntity.rt = response.rt
        userEntity.rw = response.rw
        userEntity.home_address = response.home_address
        userEntity.current_address = response.current_address
        userEntity.current_country_name = response.current_country_name
        userEntity.current_country_id = response.current_country_id
        userEntity.current_provinces_id = response.current_provinces_id
        userEntity.current_provinces_name = response.current_provinces_name
        userEntity.current_regencies_cities_id = response.current_regencies_cities_id
        userEntity.current_regencies_cities_name = response.current_regencies_cities_name
        userEntity.current_villages_id = response.current_villages_id
        userEntity.current_villages_name = response.current_villages_name
        userEntity.current_districts_id = response.current_districts_id
        userEntity.current_districts_name = response.current_districts_name
        userEntity.current_postal_code = response.current_postal_code
        userEntity.current_rt = response.current_rt
        userEntity.current_rw = response.current_rw
        userEntity.obgyn = response.obgyn
        userEntity.current_disease_name = response.current_disease_name
        userEntity.updated_at_current_disease = response.updated_at_current_disease
        userEntity.current_ews = response.current_ews
        userEntity.updated_at_current_ews = response.updated_at_current_ews
        userEntity.created_at = response.created_at
        userEntity.thumb = response.thumb
        
        return userEntity
        
    }
    
    public func transformEntityToDomain(entity: UserEntity) -> UserModel {
        
        var hospitalModel = [HospitalModel]()
        
        for (_, item) in entity.hospital.enumerated() {
            hospitalModel.append(HospitalModel(name: item.name, doctor_hospital_id: item.doctor_hospital_id))
        }
        
        return UserModel(
            user_id: entity.user_id ?? "",
            user_code: entity.user_code ?? "",
            role: entity.role ?? "",
            type: entity.type ?? "",
            no_type: entity.no_type ?? "",
            doctor_id: entity.doctor_id ?? "",
            speciality_id: entity.speciality_id ?? 0,
            speciality_slug: entity.speciality_slug ?? "",
            hospital: hospitalModel,
            hospital_active: HospitalModel(name: entity.hospital_active?.name ?? "", doctor_hospital_id: entity.hospital_active?.doctor_hospital_id ?? 0),
            name: entity.name ?? "",
            username: entity.username ?? "",
            gender: entity.gender ?? "",
            place_of_birth: entity.place_of_birth ?? "",
            date_of_birth: entity.date_of_birth ?? "",
            is_actived: entity.is_actived ?? false,
            email: entity.email ?? "",
            phone_number: entity.phone_number ?? "",
            country_id: entity.country_id ?? "",
            country_name: entity.country_name ?? "",
            provinces_id: entity.provinces_id ?? "",
            provinces_name: entity.provinces_name ?? "",
            regencies_cities_id: entity.regencies_cities_id ?? "",
            regencies_cities_name: entity.regencies_cities_name ?? "",
            villages_id: entity.villages_id ?? "",
            villages_name: entity.villages_name ?? "",
            districts_id: entity.districts_id ?? "",
            districts_name: entity.districts_name ?? "",
            postal_code: entity.postal_code ?? "",
            rt: entity.rt ?? "",
            rw: entity.rw ?? "",
            home_address: entity.home_address ?? "",
            current_address: entity.current_address ?? "",
            current_country_name: entity.current_country_name ?? "",
            current_country_id: entity.current_country_id ?? "",
            current_provinces_id: entity.current_provinces_id ?? "",
            current_provinces_name: entity.current_provinces_name ?? "",
            current_regencies_cities_id: entity.current_regencies_cities_id ?? "",
            current_regencies_cities_name: entity.current_regencies_cities_name ?? "",
            current_villages_id: entity.current_villages_id ?? "",
            current_villages_name: entity.current_villages_name ?? "",
            current_districts_id: entity.current_districts_id ?? "",
            current_districts_name: entity.current_districts_name ?? "",
            current_postal_code: entity.current_postal_code ?? "",
            current_rt: entity.current_rt ?? "",
            current_rw: entity.current_rw ?? "",
            obgyn: entity.obgyn ?? "",
            current_disease_name: entity.current_disease_name ?? "",
            updated_at_current_disease: entity.updated_at_current_disease ?? "",
            current_ews: entity.current_ews ?? "",
            updated_at_current_ews: entity.updated_at_current_ews ?? "",
            created_at: entity.created_at ?? "",
            thumb: entity.thumb
        )
    }
    
    public func transformResponseToDomain(request: Request?, response: UserResponse) -> UserModel {
        fatalError()
    }
}
