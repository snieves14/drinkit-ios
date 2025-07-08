//
//  CocktaildbWebServices.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import Alamofire

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
    static func search(parameters: Parameters) async -> DrinkResponse? {
        do {
            let data = try await WebServiceManager.shared.get(
                path: "/search.php", parameters: parameters
            )
            let result: DrinkResponse = try WebServiceManager.parseData(data: data)
            return result
        } catch let error {
            return DrinkResponse(errors: [ErrorResponse(code: error.localizedDescription, field: "", data: "")], drinks: nil)
        }
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
}
