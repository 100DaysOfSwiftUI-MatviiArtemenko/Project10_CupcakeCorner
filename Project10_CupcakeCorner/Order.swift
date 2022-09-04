//
//  Order.swift
//  Project10_CupcakeCorner
//
//  Created by admin on 21.08.2022.
//

import SwiftUI

class OrderClass: ObservableObject {
    @Published var order: Order
    
    init(order: Order) {
        self.order = order
    }
}

struct Order: Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, extraSprinkles, name, streetAddress, city, zipCode
    }
    
    static let types = ["Vanila", "Strawberry", "Chocolate", "Rainbow"]
    
     var type = 0
     var quantity = 3
    
     var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
     var extraFrosting = false
     var extraSprinkles = false
    
     var name = ""
     var streetAddress = ""
     var city = ""
     var zipCode = ""
    
    var isValid: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else {
            return true
        }
    }
        
    var cost: Double {
        var cost = Double(quantity) * 2 // $2 per cake
        
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        if extraSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
   // init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(extraSprinkles, forKey: .extraSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zipCode, forKey: .zipCode)
    }
    
//  MARK:    if useing only class we would need to use this method ->
//    required init(from decoder: Decoder) throws {
//        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try conteiner.decode(Int.self, forKey: .type)
//        quantity = try conteiner.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try conteiner.decode(Bool.self, forKey: .extraFrosting)
//        extraSprinkles = try conteiner.decode(Bool.self, forKey: .extraSprinkles)
//
//        name = try conteiner.decode(String.self, forKey: .name)
//        streetAddress = try conteiner.decode(String.self, forKey: .streetAddress)
//        city = try conteiner.decode(String.self, forKey: .city)
//        zipCode = try conteiner.decode(String.self, forKey: .zipCode)
//
//    }
    
}
