//
//  Part.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 2/27/26.
//

import Foundation

public struct Part: Identifiable, Codable, Hashable {
    public var id: String
    public var category: String
    public var name: String
    public var price: Int

    // Default id is deterministic based on category and name to avoid duplicates across categories
    public init(
        id: String? = nil,
        category: String,
        name: String,
        price: Int = 0
    ) {
        self.category = category
        self.name = name
        self.price = price
        // If a custom id is provided, use it; otherwise derive from category and name
        self.id = id ?? "\(category)|\(name)"
    }
}
