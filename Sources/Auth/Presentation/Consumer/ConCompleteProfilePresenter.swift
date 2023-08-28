//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 29/01/23.
//

import Foundation
import Combine
import Core


public class ConCompleteProfilePresenter<ConComProUseCase: UseCase, UserUseCase: UseCase>: ObservableObject
where
ConComProUseCase.Request == Any,
ConComProUseCase.Response == UserModel,
UserUseCase.Request == Any,
UserUseCase.Response == UserModel
{
    private var cancellableSet: Set<AnyCancellable> = []
    
    private let _conComProUseCase: ConComProUseCase
    private let _userUseCase: UserUseCase
    
    @Published public var item: UserModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isSuccess: Bool = false
    @Published public var isError: Bool = false
    
    @Published public var userItem: UserModel?
    @Published public var userErrorMessage: String = ""
    @Published public var isValidFormFirstPage: Bool = false
    @Published public var isValidFormSecondPage: Bool = false
    @Published public var isValidFormThirdPage: Bool = false
    @Published public var navSelection: Int? = nil
    @Published public var sameAs: Bool = false
    
    
    @Published public var isOpenProvince: Bool = false
    @Published public var isOpenRegency: Bool = false
    @Published public var isOpenDistrict: Bool = false
    @Published public var isOpenVillage: Bool = false
    @Published public var isOpenPostalCode: Bool = false
    @Published public var isOpenRt: Bool = false
    @Published public var isOpenRw: Bool = false
    

    @Published public var isOpenCurrentProvince: Bool = false
    @Published public var isOpenCurrentRegency: Bool = false
    @Published public var isOpenCurrentDistrict: Bool = false
    @Published public var isOpenCurrentVillage: Bool = false
    @Published public var isOpenCurrentPostalCode: Bool = false
    @Published public var isOpenCurrentRt: Bool = false
    @Published public var isOpenCurrentRw: Bool = false
    @Published public var isOpenCurrentAddress: Bool = false
    
    
    
    @Published public var provinceItem = [
        slcItemModel(id: 1, name: "Jawa Tengah"),
        slcItemModel(id: 2, name: "Jawa Barat"),
        slcItemModel(id: 3, name: "Jawa Timur"),
        slcItemModel(id: 4, name: "Jakarta"),
        slcItemModel(id: 5, name: "Aceh")
    ]
    

    // State
    @Published public var name = "-"
    @Published public var gender = "-"
    @Published public var phoneNumber = ""
    @Published public var placeOfBirth = ""
    @Published public var dateOfBirth = "-"
    @Published public var address = ""
    @Published public var identityType = ""
    @Published public var identityNumber = ""
    
    @Published public var countryId = "1"
    @Published public var countryName = "Indonesia"
    @Published public var provinceId = ""
    @Published public var provinceName = ""
    @Published public var regencyId = ""
    @Published public var regencyName = ""
    @Published public var districtId = ""
    @Published public var districtName = ""
    @Published public var villageId = ""
    @Published public var villageName = ""
    @Published public var postalCode = ""
    @Published public var rt = ""
    @Published public var rw = ""
    
    
    @Published public var currentCountryId = "1"
    @Published public var currentCountryName = "Indonesia"
    @Published public var currentProvinceId = ""
    @Published public var currentProvinceName = ""
    @Published public var currentRegencyId = ""
    @Published public var currentRegencyName = ""
    @Published public var currentDistrictId = ""
    @Published public var currentDistrictName = ""
    @Published public var currentVillageId = ""
    @Published public var currentVillageName = ""
    @Published public var currentPostalCode = ""
    @Published public var currentRt = ""
    @Published public var currentRw = ""
    @Published public var currentAddress = ""
    
    
    
    // Message
    @Published public var nameMessage = ""
    @Published public var genderMessage = ""
    @Published public var phoneNumberMessage = ""
    @Published public var placeOfBirthMessage = ""
    @Published public var dateOfBirthMessage = ""
    @Published public var addressMessage = ""
    @Published public var identityTypeMessage = ""
    @Published public var identityNumberMessage = ""
    
    @Published public var countryNameMessage = ""
    @Published public var provinceNameMessage = ""
    @Published public var regencyNameMessage = ""
    @Published public var districtNameMessage = ""
    @Published public var villageNameMessage = ""
    @Published public var postalCodeMessage = ""
    @Published public var rtMessage = ""
    @Published public var rwMessage = ""
    
    
    @Published public var currentCountryNameMessage = ""
    @Published public var currentProvinceNameMessage = ""
    @Published public var currentRegencyNameMessage = ""
    @Published public var currentDistrictNameMessage = ""
    @Published public var currentVillageNameMessage = ""
    @Published public var currentPostalCodeMessage = ""
    @Published public var currentRtMessage = ""
    @Published public var currentRwMessage = ""
    @Published public var currentAddressMessage = ""
    
    // Show Model
    @Published public var genderShowModel = false
    @Published public var identityShowModel = false
    
    @Published public var provinceShowModel = false
    @Published public var regencyShowModel = false
    @Published public var districtShowModel = false
    @Published public var villageShowModel = false
    
    
    @Published public var currentProvinceShowModel = false
    @Published public var currentRegencyShowModel = false
    @Published public var currentDistrictShowModel = false
    @Published public var currentVillageShowModel = false

    // Placeholder
    public let namePlaceholder = "Full Name (Based on KTP)"
    public let genderPlaceholder = "Gender"
    public let phoneNumberPlaceholder = "Phone Number"
    public let placeOfBirthPlaceholder = "Place Of Birth"
    public let dateOfBirthPlaceholder = "Date Of Birth"
    public let addressPlaceholder = "Address"
    public let identityTypePlaceholder = "Identity Type"
    public let identityNumberPlaceholder = "Identity Number"
    
    public let countryNamePlaceholder = "Country"
    public let provinceNamePlaceholder = "Province"
    public let regencyNamePlaceholder = "Regency"
    public let districtNamePlaceholder = "District"
    public let villageNamePlaceholder = "Village"
    public let postalCodePlaceholder = "Postal Code"
    public let rtPlaceholder = "RT"
    public let rwPlaceholder = "RW"
    
    public let currentCountryNamePlaceholder = "Current Country"
    public let currentProvinceNamePlaceholder = "Current Province"
    public let currentRegencyNamePlaceholder = "Current Regency"
    public let currentDistrictNamePlaceholder = "Current District"
    public let currentVillageNamePlaceholder = "Current Village"
    public let currentPostalCodePlaceholder = "Current Postal Code"
    public let currentRtPlaceholder = "Current RT"
    public let currentRwPlaceholder = "Current RW"
    public let currentAddressPlaceholder = "Current Address"
    
    // TextField
    @Published public var nameTextField = false {
        didSet {
            guard nameTextField != oldValue else { return }
            if nameTextField {
                genderTextField = false
                phoneTextField = false
                dateOfBirthTextField = false
                placeOfBirthTextField = false
                addressTextField = false
                identityTypeTextField = false
                identityNumberTextField = false
            }
        }
    }
    
    @Published public var genderTextField = false {
        didSet {
            guard genderTextField != oldValue else { return }
            
            if genderTextField {
                nameTextField = false
                phoneTextField = false
                dateOfBirthTextField = false
                placeOfBirthTextField = false
                addressTextField = false
                identityTypeTextField = false
                identityNumberTextField = false
            }
        }
    }
    
    @Published public var phoneTextField = false {
        didSet {
            guard phoneTextField != oldValue else { return }
            if phoneTextField {
                genderTextField = false
                nameTextField = false
                dateOfBirthTextField = false
                placeOfBirthTextField = false
                addressTextField = false
                identityTypeTextField = false
                identityNumberTextField = false
            }
        }
    }
    
    
    @Published public var dateOfBirthTextField = false {
        didSet {
            guard dateOfBirthTextField != oldValue else { return }
            if dateOfBirthTextField {
                genderTextField = false
                nameTextField = false
                phoneTextField = false
                placeOfBirthTextField = false
                addressTextField = false
                identityTypeTextField = false
                identityNumberTextField = false
            }
        }
    }
    
    
    @Published public var placeOfBirthTextField = false {
        didSet {
            guard placeOfBirthTextField != oldValue else { return }
            if placeOfBirthTextField {
                genderTextField = false
                nameTextField = false
                phoneTextField = false
                dateOfBirthTextField = false
                addressTextField = false
                identityTypeTextField = false
                identityNumberTextField = false
            }
        }
    }
    
    @Published public var addressTextField = false {
        didSet {
            guard addressTextField != oldValue else { return }
            if addressTextField {
                genderTextField = false
                nameTextField = false
                phoneTextField = false
                dateOfBirthTextField = false
                placeOfBirthTextField = false
                identityTypeTextField = false
                identityNumberTextField = false
            }
        }
    }
    
    @Published public var identityTypeTextField = false {
        didSet {
            guard identityTypeTextField != oldValue else { return }
            if identityTypeTextField {
                genderTextField = false
                nameTextField = false
                phoneTextField = false
                dateOfBirthTextField = false
                placeOfBirthTextField = false
                addressTextField = false
                identityNumberTextField = false
            }
        }
    }
    
    @Published public var identityNumberTextField = false {
        didSet {
            guard identityNumberTextField != oldValue else { return }
            if identityNumberTextField {
                genderTextField = false
                nameTextField = false
                phoneTextField = false
                dateOfBirthTextField = false
                placeOfBirthTextField = false
                addressTextField = false
                identityTypeTextField = false
            }
        }
    }
    
    
    @Published public var countryNameTextField = false {
        didSet {
            if countryNameTextField {
                provinceNameTextField = false
                regencyNameTextField = false
                districtNameTextField = false
                villageNameTextField = false
                postalCodeNameTextField = false
                rtNameTextField = false
                rwNameTextField = false
            }
        }
    }
    
    @Published public var provinceNameTextField = false {
        didSet {
            guard provinceNameTextField != oldValue else { return }
            if provinceNameTextField {
                countryNameTextField = false
                regencyNameTextField = false
                districtNameTextField = false
                villageNameTextField = false
                postalCodeNameTextField = false
                rtNameTextField = false
                rwNameTextField = false
            }
        }
    }
    
    @Published public var regencyNameTextField = false {
        didSet {
            guard regencyNameTextField != oldValue else { return }
            if regencyNameTextField {
                countryNameTextField = false
                provinceNameTextField = false
                districtNameTextField = false
                villageNameTextField = false
                postalCodeNameTextField = false
                rtNameTextField = false
                rwNameTextField = false
            }
        }
    }
    
    
    @Published public var districtNameTextField = false {
        didSet {
            guard districtNameTextField != oldValue else { return }
            if districtNameTextField {
                countryNameTextField = false
                provinceNameTextField = false
                regencyNameTextField = false
                villageNameTextField = false
                postalCodeNameTextField = false
                rtNameTextField = false
                rwNameTextField = false
            }
        }
    }
    
    
    @Published public var villageNameTextField = false {
        didSet {
            guard villageNameTextField != oldValue else { return }
            if villageNameTextField {
                countryNameTextField = false
                provinceNameTextField = false
                regencyNameTextField = false
                districtNameTextField = false
                postalCodeNameTextField = false
                rtNameTextField = false
                rwNameTextField = false
            }
        }
    }
    
    @Published public var postalCodeNameTextField = false {
        didSet {
            guard postalCodeNameTextField != oldValue else { return }
            if postalCodeNameTextField {
                countryNameTextField = false
                provinceNameTextField = false
                regencyNameTextField = false
                districtNameTextField = false
                villageNameTextField = false
                rtNameTextField = false
                rwNameTextField = false
            }
        }
    }
    
    @Published public var rtNameTextField = false {
        didSet {
            guard rtNameTextField != oldValue else { return }
            if rtNameTextField {
                countryNameTextField = false
                provinceNameTextField = false
                regencyNameTextField = false
                districtNameTextField = false
                villageNameTextField = false
                postalCodeNameTextField = false
                rwNameTextField = false
            }
        }
    }
    
    @Published public var rwNameTextField = false {
        didSet {
            guard rwNameTextField != oldValue else { return }
            if rwNameTextField {
                countryNameTextField = false
                provinceNameTextField = false
                regencyNameTextField = false
                districtNameTextField = false
                villageNameTextField = false
                postalCodeNameTextField = false
                rtNameTextField = false
            }
        }
    }
    
    
    @Published public var currentCountryNameTextField = false {
        didSet {
            if currentCountryNameTextField {
                currentProvinceNameTextField = false
                currentRegencyNameTextField = false
                currentDistrictNameTextField = false
                currentVillageNameTextField = false
                currentPostalCodeNameTextField = false
                currentRtNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    @Published public var currentProvinceNameTextField = false {
        didSet {
            guard currentProvinceNameTextField != oldValue else { return }
            if currentProvinceNameTextField {
                currentCountryNameTextField = false
                currentRegencyNameTextField = false
                currentDistrictNameTextField = false
                currentVillageNameTextField = false
                currentPostalCodeNameTextField = false
                currentRtNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    @Published public var currentRegencyNameTextField = false {
        didSet {
            guard currentRegencyNameTextField != oldValue else { return }
            if currentRegencyNameTextField {
                currentCountryNameTextField = false
                currentProvinceNameTextField = false
                currentDistrictNameTextField = false
                currentVillageNameTextField = false
                currentPostalCodeNameTextField = false
                currentRtNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    
    @Published public var currentDistrictNameTextField = false {
        didSet {
            guard currentDistrictNameTextField != oldValue else { return }
            if currentDistrictNameTextField {
                currentCountryNameTextField = false
                currentProvinceNameTextField = false
                currentRegencyNameTextField = false
                currentVillageNameTextField = false
                currentPostalCodeNameTextField = false
                currentRtNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    
    @Published public var currentVillageNameTextField = false {
        didSet {
            guard currentVillageNameTextField != oldValue else { return }
            if currentVillageNameTextField {
                currentCountryNameTextField = false
                currentProvinceNameTextField = false
                currentRegencyNameTextField = false
                currentDistrictNameTextField = false
                currentPostalCodeNameTextField = false
                currentRtNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    @Published public var currentPostalCodeNameTextField = false {
        didSet {
            guard currentPostalCodeNameTextField != oldValue else { return }
            if currentPostalCodeNameTextField {
                currentCountryNameTextField = false
                currentProvinceNameTextField = false
                currentRegencyNameTextField = false
                currentDistrictNameTextField = false
                currentVillageNameTextField = false
                currentRtNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    @Published public var currentRtNameTextField = false {
        didSet {
            guard currentRtNameTextField != oldValue else { return }
            if currentRtNameTextField {
                currentCountryNameTextField = false
                currentProvinceNameTextField = false
                currentRegencyNameTextField = false
                currentDistrictNameTextField = false
                currentVillageNameTextField = false
                currentPostalCodeNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    @Published public var currentRwNameTextField = false {
        didSet {
            guard currentRwNameTextField != oldValue else { return }
            if currentRwNameTextField {
                currentCountryNameTextField = false
                currentProvinceNameTextField = false
                currentRegencyNameTextField = false
                currentDistrictNameTextField = false
                currentVillageNameTextField = false
                currentPostalCodeNameTextField = false
                currentRtNameTextField = false
                currentAddressNameTextField = false
            }
        }
    }
    
    @Published public var currentAddressNameTextField = false {
        didSet {
            guard currentAddressNameTextField != oldValue else { return }
            if currentAddressNameTextField {
                currentCountryNameTextField = false
                currentProvinceNameTextField = false
                currentRegencyNameTextField = false
                currentDistrictNameTextField = false
                currentVillageNameTextField = false
                currentPostalCodeNameTextField = false
                currentRtNameTextField = false
                currentRwNameTextField = false
            }
        }
    }
    
    
    
    
    
    // Combine
    private var isValidNumberIdentityPublisher: AnyPublisher<Bool, Never> {
        $identityNumber
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { number in
                return number.count == 0 || number.count == 16
            }
            .eraseToAnyPublisher()
    }
    
    public var isValidFormFirstCombinePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4($phoneNumber, $placeOfBirth, $address, $identityType)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { phone, place, address, type in
                return !phone.isEmpty && !place.isEmpty && !address.isEmpty && !type.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    public var isValidFormSecondCombinePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($identityType, $identityNumber, isValidNumberIdentityPublisher)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { type, number, validNumber in
                return !type.isEmpty && !number.isEmpty && validNumber
            }
            .eraseToAnyPublisher()
    }
    
    public var isValidFormFirstPagePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidFormFirstCombinePublisher, isValidFormSecondCombinePublisher)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { first, second in
                return first && second
            }
            .eraseToAnyPublisher()
    }
    
    // --
    
    public var isValidFormFirstCombineAddressPage: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($provinceId, $regencyId, $districtId)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { first, second, third in
                return !first.isEmpty && first != "-" && !second.isEmpty && second != "-" && !third.isEmpty && third != "-"
            }
            .eraseToAnyPublisher()
    }
    
    public var isValidFormSecondCombineAddressPage: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($rt, $rw)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { first, second in
                return !first.isEmpty && !second.isEmpty
            }
            .eraseToAnyPublisher()
    }
    

    
    public var isValidFormSecondPagePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidFormFirstCombineAddressPage, isValidFormSecondCombineAddressPage)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { first, second in
                return first && second
            }
            .eraseToAnyPublisher()
    }
    
    // --
    
    
    public var isValidFormFirstCombineCurrentAddressPage: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($currentProvinceId, $currentRegencyId, $currentDistrictId)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { first, second, third in
                return !first.isEmpty && first != "-" && !second.isEmpty && second != "-" && !third.isEmpty && third != "-"
            }
            .eraseToAnyPublisher()
    }
    
    public var isValidFormSecondCombineCurrentAddressPage: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($currentRt, $currentRw, $currentAddress)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { first, second, third in
                return !first.isEmpty && !second.isEmpty && !third.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    public var isValidFormThirdPagePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidFormFirstCombineCurrentAddressPage, isValidFormSecondCombineCurrentAddressPage)
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { first, second in
                return first && second
            }
            .eraseToAnyPublisher()
    }

    
    // Init
    public init(conComProUseCase: ConComProUseCase, userUseCase: UserUseCase){
        _conComProUseCase = conComProUseCase
        _userUseCase = userUseCase
        
        isValidNumberIdentityPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Number Indentity must be at 16 characters log"
            }
            .assign(to: \.identityNumberMessage, on: self)
            .store(in: &cancellableSet)
        
        isValidFormFirstPagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidFormFirstPage, on: self)
            .store(in: &cancellableSet)
        
        isValidFormSecondPagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidFormSecondPage, on: self)
            .store(in: &cancellableSet)
        
        isValidFormThirdPagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidFormThirdPage, on: self)
            .store(in: &cancellableSet)
    }
    
    
    
    public func getUser(){
        _userUseCase.execute(request: "")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.userErrorMessage = String(describing: completion)
                    
                case .finished:
                    self.userErrorMessage = ""
                }
            }, receiveValue: { item in
                
                self.userItem = item
                self.name = item.name!
                self.gender = item.gender! == "laki-laki" ? "Male" : "Female"
                self.dateOfBirth = dateFormatterDateOfBirthFromString(dateVal: item.date_of_birth!)
            })
            .store(in: &cancellableSet)
    }
    
    public func updateProfile(request: ConComProUseCase.Request){
        self.isLoading = true
        _conComProUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.isError = true
                    self.errorMessage = String(describing: completion)
                    self.isLoading = false
                    self.navSelection = 2
                case .finished:
                    self.isSuccess = true
                    self.navSelection = 1
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellableSet)
    }
}
