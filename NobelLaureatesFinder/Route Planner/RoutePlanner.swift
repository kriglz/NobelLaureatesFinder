//
//  NobelData.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/4/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import CoreLocation

struct RoutePlanner {
    
    private var destinationList: [Destination] = []
    
    init() {
        guard let path = Bundle.main.path(forResource: "nobel-prize-laureates", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
            let nobelPrizeLaureateList = jsonObject as? [Dictionary<String, AnyObject>] else { return }
        
        for laureate in nobelPrizeLaureateList {
            guard let firstname = laureate["firstname"] as? String,
                let surname = laureate["surname"] as? String,
                let yearObject = laureate["year"] as? String,
                let year = Double(yearObject),
                let location = laureate["location"] as? Dictionary<String, Double>,
                let latitude = location["lat"],
                let longitude = location["lng"] else { return }
            
            let nobelLaureate = NobelPrizeLaureate(name: "\(firstname) \(surname)",
                year: year,
                location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            let destination = Destination(cost: 0, nobelPrizeLaureate: nobelLaureate)
            destinationList.append(destination)
        }
    }
    
    func bestRoute(forYear year: Double, location: CLLocationCoordinate2D) -> [Destination] {
        return []
    }
}