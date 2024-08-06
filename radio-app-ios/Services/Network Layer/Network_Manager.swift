//
//  Network Manager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import Foundation

enum NetworkError: Error {
    case transportError (Error)
    case serverError (statusCode: Int)
    case noData
    case decodingError (Error)
}

class NetworkManager {

    func createURL(for endpoint: Endpoints, with query: String? = nil) -> URL? {

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
        case .doSearchByCountry(parameter: let parameter):
            parameters ["country"] = "\(parameter)"
            parameters ["limit"] = "10"
        case .doSearchByLanguageOrTag(parameter: let parameter):
            parameters ["tag"] = "\(parameter)"
            parameters ["limit"] = "10"
        }

        return parameters
    }

    func makeTask<T: Codable>(for url: URL, using session: URLSession = .shared, completion: @escaping(Result<T, NetworkError>) -> Void) {

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
}
