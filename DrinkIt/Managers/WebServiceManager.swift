//
//  WebServiceManager.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import Foundation
import Combine
import Alamofire

private let API_BASE_URL = "https://www.thecocktaildb.com"
private let API_VERSION_PATH = "/api/json/v1"
private let API_KEY = "1"
let refreshInterval: TimeInterval = 300 /// 5 minutos

enum ErrorCode: String {
    case unknown = "unknown"
    case invalid = "invalid"
}

enum RequestStatus {
    case unknown
    case success
    case empty
    case failure
}

enum RefreshPolicy {
    case always
    case ifNeeded
    case never
}

actor WebServiceManager: GlobalActor {
    
    static let shared = WebServiceManager()
    private init() {}
    
    private let maxWaitTime = 15.0
    
    nonisolated private func fullURL(with path: String) -> String {
        return "\(API_BASE_URL)\(API_VERSION_PATH)/\(API_KEY)\(path)"
    }
    
    func request(
        method: HTTPMethod,
        path: String,
        parameters: Parameters?,
        encoding: ParameterEncoding = JSONEncoding.default
    ) async throws -> Data {
        print("Requesting URL(request): \(fullURL(with: path))")
        print("parameters: \(parameters ?? [:])")
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                fullURL(with: path),
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: nil,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON recibido: \(jsonString)")
                    }
                    continuation.resume(returning: data)
                case let .failure(error):
                    print("request error:\(error.localizedDescription)")
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    nonisolated func requestPublisher(
        method: HTTPMethod,
        path: String,
        parameters: Parameters?,
        encoding: ParameterEncoding = URLEncoding.default
    ) -> AnyPublisher<Data, Error> {
        print("Requesting URL(requestPublisher): \(fullURL(with: path))")
        print("parameters: \(parameters ?? [:])")
        return AF.request(
            fullURL(with: path),
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: nil,
            requestModifier: { $0.timeoutInterval = self.maxWaitTime }
        )
        .validate()
        .publishData()
        .value()
        .handleEvents(
            receiveOutput: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON recibido: \(jsonString)")
                }
            },
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("requestPublisher error: \(error.localizedDescription)")
                }
            }
        )
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
    
    func get(path: String, parameters: Parameters?) async throws -> Data {
        return try await request(method: .get, path: path, parameters: parameters, encoding: URLEncoding(destination: .queryString))
    }
    
    func post(path: String, parameters: Parameters?) async throws -> Data {
        return try await request(method: .post, path: path, parameters: parameters, encoding: URLEncoding.default)
    }
    
    func delete(path: String, parameters: Parameters?) async throws -> Data {
        return try await request(method: .delete, path: path, parameters: parameters, encoding: URLEncoding.default)
    }
    
    nonisolated func getPublisher(path: String, parameters: Parameters?) -> AnyPublisher<Data, Error> {
        requestPublisher(method: .get, path: path, parameters: parameters, encoding: URLEncoding(destination: .queryString))
    }

    nonisolated func postPublisher(path: String, parameters: Parameters?) -> AnyPublisher<Data, Error> {
        requestPublisher(method: .post, path: path, parameters: parameters, encoding: URLEncoding.default)
    }
    
    nonisolated private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
    
    static func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}
