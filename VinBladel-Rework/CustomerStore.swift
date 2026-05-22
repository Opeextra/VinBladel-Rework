//
//  CustomerStore.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 12/15/25.
//
import Foundation
import FirebaseDatabase

@Observable
final class CustomerStore {
    var clients: [Client] = []

    private let ref = Database.database().reference().child("Customers")
    private var handle: DatabaseHandle?

    func startListening() {
        guard handle == nil else { return }
        handle = ref.observe(.value) { [weak self] snapshot in
            guard let dict = snapshot.value as? [String: [String: Any]] else {
                self?.clients = []
                return
            }
            self?.clients = dict.map { name, payload in
                Client(
                    id: name,
                    name: name,
                    contactInfo: payload["Contact Info"] as? [String: String] ?? [:],
                    cars: payload["Cars"] as? [String: String] ?? [:]
                )
            }
            .sorted { $0.name < $1.name }
        }
    }

    func stopListening() {
        if let handle { ref.removeObserver(withHandle: handle) }
        handle = nil
    }

    func addCustomer(name: String, contactInfo: [String: String]) {
        ref.child(name).setValue([
            "Contact Info": contactInfo,
            "Cars": [:] as [String: String]
        ])
    }

    func addCar(customer: String, nickname: String, vin: String) {
        ref.child(customer).child("Cars").child(nickname).setValue(vin)
    }
}
