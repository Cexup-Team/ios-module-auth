//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 22/05/23.
//

import Foundation
import Combine
import Alamofire
import Core

public struct ComProRemoteDataSource: DataSource {
   
    
    public typealias Request = Any
    public typealias Response = UserResponse
    
    private let _endpoint: String
    private let _apiKey: String
    
    public init(endpoint: String, apiKey: String) {
        _endpoint = endpoint
        _apiKey = apiKey
    }
    
    public func execute(request: Any?) -> AnyPublisher<UserResponse, Error> {
    
        
        let headers: HTTPHeaders = [
            "x-api-key" : _apiKey,
            "Authorization" : "Bearer \(Prefs.shared.accessTokenPrefs)"
        ]
        
        return Future<UserResponse, Error> { completion in
            if let url = URL(string: _endpoint) {
                AF.request(url, method: .post, parameters: request as? Parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseDecodable(of: CompleteProfileResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            if  200 ... 299 ~= Int(value.code)!{
                                
                                var hospitalRes = [HospitalResponse]()
                                
                                for (_, item) in value.data?.hospital.enumerated() ?? [].enumerated() {
                                    hospitalRes.append(HospitalResponse(name: item.name, doctor_hospital_id: item.doctor_hospital_id))
                                }
                                
                                Prefs.shared.noTypePrefs = value.data?.no_type ?? ""
                                completion(.success(
                                    UserResponse(
                                        user_id: value.data?.user_id,
                                        user_code: value.data?.user_code,
                                        role: value.data?.role,
                                        type: value.data?.type,
                                        no_type: value.data?.no_type,
                                        doctor_id: value.data?.doctor_id,
                                        speciality_id: value.data?.speciality_id,
                                        speciality_slug: value.data?.speciality_slug,
                                        hospital: hospitalRes,
                                        hospital_active: HospitalResponse(name: value.data?.hospital_active?.name, doctor_hospital_id: value.data?.hospital_active?.doctor_hospital_id),
                                        name: value.data?.name,
                                        username: value.data?.username,
                                        gender: value.data?.gender,
                                        place_of_birth: value.data?.place_of_birth,
                                        date_of_birth: value.data?.date_of_birth,
                                        is_actived: value.data?.is_actived ?? false,
                                        email: value.data?.email,
                                        phone_number: value.data?.phone_number,
                                        country_id: String(describing: value.data?.country_id),
                                        country_name: value.data?.country_name,
                                        provinces_id: value.data?.provinces_id,
                                        provinces_name: value.data?.provinces_name,
                                        regencies_cities_id: value.data?.regencies_cities_id,
                                        regencies_cities_name: value.data?.regencies_cities_name,
                                        villages_id: value.data?.villages_id,
                                        villages_name: value.data?.villages_name,
                                        districts_id: value.data?.districts_id,
                                        districts_name: value.data?.districts_name,
                                        postal_code: value.data?.postal_code,
                                        rt: value.data?.rt,
                                        rw: value.data?.rw,
                                        home_address: value.data?.home_address,
                                        current_address: value.data?.current_address,
                                        current_country_name: value.data?.current_country_name,
                                        current_country_id: String(describing: value.data?.current_country_id),
                                        current_provinces_id: value.data?.current_provinces_id,
                                        current_provinces_name: value.data?.current_provinces_name,
                                        current_regencies_cities_id: value.data?.current_regencies_cities_id,
                                        current_regencies_cities_name: value.data?.current_regencies_cities_name,
                                        current_villages_id: value.data?.current_villages_id,
                                        current_villages_name: value.data?.current_villages_name,
                                        current_districts_id: value.data?.current_districts_id,
                                        current_districts_name: value.data?.current_disease_name,
                                        current_postal_code: value.data?.current_postal_code,
                                        current_rt: value.data?.current_rt,
                                        current_rw: value.data?.current_rw,
                                        obgyn: value.data?.obgyn,
                                        current_disease_name: value.data?.current_disease_name,
                                        updated_at_current_disease: value.data?.updated_at_current_disease,
                                        current_ews: value.data?.current_ews,
                                        updated_at_current_ews: value.data?.updated_at_current_ews,
                                        created_at: value.data?.created_at,
                                        thumb: value.data?.thumb
                                    )
                                ))
                            }else{
                                completion(.failure(URLError.custom(value.message)))
                            }

                        case .failure(_):
                            completion(.failure(URLError.invalidRequest))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
