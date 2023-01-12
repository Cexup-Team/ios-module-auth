//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 09/01/23.
//

import Foundation
import Combine
import Alamofire
import Core

public struct LoginRemoteDataSource: DataSource {
   
    
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
            "x-api-key" : _apiKey
        ]
        
        return Future<UserResponse, Error> { completion in
            if let url = URL(string: _endpoint) {
                AF.request(url, method: .post, parameters: request as? Parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseDecodable(of: LoginResponse.self) { response in
                        
                        switch response.result {
                        case .success(let value):
                            if Int(value.code) == 200 {
                                Prefs.shared.accessTokenPrefs = value.data!.access_token!
                                completion(.success(value.data!.user!))
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
