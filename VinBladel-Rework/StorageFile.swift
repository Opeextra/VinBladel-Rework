//
//  StorageFile.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI
import FirebaseDatabase

struct car: Identifiable{
    let ownerID: String
    let id: String
    let make: String
    let model: String
    let vin: String
    let year: String
}
struct customer: Identifiable {
    let id: String
    let name: String
}

struct PARS: Identifiable{
    let id: String
    let example: String
}


