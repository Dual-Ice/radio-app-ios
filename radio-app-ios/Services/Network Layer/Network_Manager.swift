//
//  Network Manager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import Foundation

enum NetworkError: Error {
    case transportError (Error)
    case serverError (statusCode: Int) // апи предоставляет коды?
    case noData
    case decodingError (Error)
}

class NetworkManager {

    private func createURL(for endpoint: Endpoints, with query: String? = nil) -> URL? {

        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endpoint.path

        components.queryItems = makeParameters(for: endpoint).compactMap({
            URLQueryItem(name: $0.key, value: $0.value)
        })

        return components.url
    }

    private func makeParameters(for endpoint: Endpoints) -> [String: String] {

        var parameters = [String: String]()

        switch endpoint {

        case .getPopular:
            parameters ["limit"] = "10"
        case .getSingleStation(uuids: let uuids):
            parameters ["uuids"] = "\(uuids)"
        case .getCountriesList:
            parameters ["limit"] = "30"
        case .getLanguagesList:
            parameters ["limit"] = "15"
        case .getTags:
            parameters ["limit"] = "10"
        case .doSearch(request: let request):
            parameters ["name"] = "\(request)"
            parameters ["limit"] = "15"
        }

        return parameters
    }

    private func makeTask<T: Codable>(for url: URL, using session: URLSession = .shared, completion: @escaping(Result<T, NetworkError>) -> Void) {

        session.dataTask(with: url) { data, response, error in

            /// check if there's we can connect to the server (ex. no internet connection)
            if let error = error {
                completion(.failure(.transportError(error)))
                print ("Can't connect to the server. Check your internet connection")
                return
            }

            /// check if the response is in http format
            guard response is HTTPURLResponse else {
                let error = NSError(domain: "Not a http response", code: 0, userInfo: nil)
                completion(.failure(.serverError(statusCode: error.code)))
                return
            }

            /// getting data
            guard let data = data else {
                _ = NSError (domain: "No data", code: 0, userInfo: nil)
                completion(.failure(.noData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                print (decodedData)
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }

    // to move to separated class RadioAPI
    func getPopular(completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = createURL(for: .getPopular) else { return }
        makeTask(for: url, completion: completion)
    }

    func getCountries(completion: @escaping(Result<[Country], NetworkError>) -> Void) {
        guard let url = createURL(for: .getCountriesList) else { return }
        makeTask(for: url, completion: completion)
    }

    func getLanguages(completion: @escaping(Result<[Language], NetworkError>) -> Void) {
        guard let url = createURL(for: .getLanguagesList) else { return }
        makeTask(for: url, completion: completion)
    }

    func getTags(completion: @escaping(Result<[Tag], NetworkError>) -> Void) {
        guard let url = createURL(for: .getTags) else { return }
        makeTask(for: url, completion: completion)
    }

    func doSearch(request: String, completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = createURL(for: .doSearch(request: request)) else { return }
        makeTask(for: url, completion: completion)
    }

    // возможно лишнее
    func getStation(for id: String, completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = createURL(for: .getSingleStation(uuids: id)) else { return }
        makeTask(for: url, completion: completion)
    }
}
