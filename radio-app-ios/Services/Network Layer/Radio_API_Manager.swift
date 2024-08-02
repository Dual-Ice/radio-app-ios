//
//  Radio_API_Manager.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 02.08.2024.
//

import Foundation
import UIKit

class Radio_API_Manager {

    private let networkManager = NetworkManager()

    /// getting collection of popular stations
    func getPopular(completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getPopular) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }

    /// getting list of countries
    func getCountries(completion: @escaping(Result<[Country], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getCountriesList) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }

    /// getting list of languages
    func getLanguages(completion: @escaping(Result<[Language], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getLanguagesList) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }

    /// gettings list of tags
    func getTags(completion: @escaping(Result<[Tag], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getTags) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }

    /// fuzzy search by name of stations
    func doSearch(request: String, completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .doSearch(request: request)) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }

    /// search by counties
    func doSearchByCountry(parameter: String, completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .doSearchByCountry(parameter: parameter)) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }

    /// универсальная функция для поиска и по тэгам, и по языку, т.к. по языку приходят пустые ответы
    func doSearchByLanguageOrTag(parameter: String, completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .doSearchByLanguageOrTag(parameter: parameter)) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }

    // возможно лишнее
    /// get a single station
    func getStation(for id: String, completion: @escaping(Result<[Station], NetworkError>) -> Void) {
        guard let url = networkManager.createURL(for: .getSingleStation(uuids: id)) else { return }
        networkManager.makeTask(for: url, completion: completion)
    }
}
