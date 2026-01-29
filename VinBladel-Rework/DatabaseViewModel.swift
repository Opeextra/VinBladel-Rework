//
//  DatabaseViewModel.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 1/21/26.
//
import SwiftUI
import FirebaseDatabase

struct DatabaseViewModelTest: View {
    @Environment(DatabaseViewModel.self) private var viewModel
    var body: some View {
        List {
            // Convert dictionary values to an array of Clients (Client is Identifiable)
            ForEach(Array(viewModel.clients.values)) { client in
                VStack(alignment: .leading) {
                    Text(client.name)
                        .font(.headline)
                    if !client.contactInfo.isEmpty {
                        // Show a simple concatenation of key/value pairs
                        Text(client.contactInfo.map { "\($0.key): \($0.value)" }.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

struct Client: Identifiable, Decodable {
    let id: String
    var name: String
    var contactInfo: [String: String]
}

@Observable class DatabaseViewModel {
    var clients: [String: Client] = [:]
    
    init() {
        getData()
    }
    
    func getData(){
        Database.database().reference().child("clients").observe(.value) { snapshot in
            var loaded: [String: Client] = [:]

            for child in snapshot.children {
                guard
                    let snap = child as? DataSnapshot,
                    let dict = snap.value as? [String: Any]
                else { continue }

                // Map dictionary to Client manually since Firebase returns [String: Any]
                if let id = dict["id"] as? String,
                   let name = dict["name"] as? String,
                   let contactInfo = dict["contactInfo"] as? [String: String] {
                    loaded[snap.key] = Client(id: id, name: name, contactInfo: contactInfo)
                } else {
                    // Fallback: if no `id` field stored, use the snapshot key as id
                    let id = dict["id"] as? String ?? snap.key
                    let name = dict["name"] as? String ?? ""
                    let contactInfo = dict["contactInfo"] as? [String: String] ?? [:]
                    loaded[snap.key] = Client(id: id, name: name, contactInfo: contactInfo)
                }
            }

            self.clients = loaded
        }
    }
}


