//
//  Helpers.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

final class StationHelper {
    static private let dotColors: [UIColor] = [.red, .blue, .green, .purple, .yellow, .systemCyan, .orange]
    
    static func getGenreFromStationTags(_ tags: String?) -> String {
        guard let value = tags else {
            return "Unknown Genre"
        }

        let elements: [String]
        
        if value.contains(",") {
            elements = value.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        } else {
            elements = value.split(separator: " ").map { $0.trimmingCharacters(in: .whitespaces) }
        }
        
        return elements.first ?? "Unknown Genre"
    }
    
    static func makeDotColorsForStations(stations: [Station]) -> [IndexPath: UIColor] {
        
        var cellDotColors: [IndexPath: UIColor] = [:]
        for (index, _) in stations.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            cellDotColors[indexPath] = dotColors[index % (dotColors.count ?? 1)]
        }
        
        return cellDotColors
    }
}
