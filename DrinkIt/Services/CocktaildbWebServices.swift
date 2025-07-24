//
//  CocktaildbWebServices.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import Alamofire
import Combine

class CocktaildbWebServices {
    // MARK: - Random cocktail request
    static func random() async -> DrinkResponse? {
        do {
            let data = try await WebServiceManager.shared.get(
                path: "/random.php", parameters: nil
            )
            let result: DrinkResponse = try WebServiceManager.parseData(data: data)
            return result
        } catch let error {
            return DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil)
        }
    }
    
    // MARK: - List request
    static func list(parameters: Parameters) async -> DrinkResponse? {
        do {
            let data = try await WebServiceManager.shared.get(
                path: "/list.php", parameters: parameters
            )
            let result: DrinkResponse = try WebServiceManager.parseData(data: data)
            return result
        } catch let error {
            return DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil)
        }
    }
    
    // MARK: - Search request
    static func search<T: Decodable>(parameters: Parameters) async -> T? {
        do {
            let data = try await WebServiceManager.shared.get(
                path: "/search.php", parameters: parameters
            )
            let result: T = try WebServiceManager.parseData(data: data)
            return result
        } catch let error {
            if T.self == DrinkResponse.self {
                return DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil) as? T
            } else if T.self == IngredientResponse.self {
                return IngredientResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], ingredients: nil) as? T
            } else {
                return nil
            }
        }
    }
    
    // MARK: - Search request(Publisher)
    static func searchPublisher(parameters: Parameters) -> AnyPublisher<DrinkResponse, Never> {
        WebServiceManager.shared.getPublisher(path: "/search.php", parameters: parameters)
            .tryMap { data in
                try WebServiceManager.parseData(data: data) as DrinkResponse
            }
            .catch { error in
                Just(DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil))
                    .setFailureType(to: Never.self)
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Filter request
    static func filter(parameters: Parameters) async -> DrinkResponse? {
        do {
            let data = try await WebServiceManager.shared.get(
                path: "/filter.php", parameters: parameters
            )
            let result: DrinkResponse = try WebServiceManager.parseData(data: data)
            return result
        } catch let error {
            return DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil)
        }
    }
    
    // MARK: - Filter request (Publisher)
    static func filterPublisher(parameters: Parameters) -> AnyPublisher<DrinkResponse, Never> {
        WebServiceManager.shared.getPublisher(path: "/filter.php", parameters: parameters)
            .tryMap { data in
                try WebServiceManager.parseData(data: data) as DrinkResponse
            }
            .catch { error in
                Just(DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil))
                    .setFailureType(to: Never.self)
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - lookup request
    static func lookup(parameters: Parameters) async -> DrinkResponse? {
        do {
            let data = try await WebServiceManager.shared.get(
                path: "/lookup.php", parameters: parameters
            )
            let result: DrinkResponse = try WebServiceManager.parseData(data: data)
            return result
        } catch let error {
            return DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil)
        }
    }
}
