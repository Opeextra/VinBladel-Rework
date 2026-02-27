//
//  StorageFile.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI
import FirebaseDatabase

@Observable
@MainActor
final class VinBladelViewModel {
    var parts: [Part] = []
    
    private var ref: DatabaseReference!
    private var handle: DatabaseHandle?
    
    init(){
        ref = Database.database().reference(withPath: "parts")
        startListening()
    }
    
    func startListening() {
        stopListening()
        
        handle = ref.observe(.value) { [weak self] snapshot in
            guard let self else { return }

            var newParts: [Part] = []

            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                for child in children {
                    guard let value = child.value as? [String: Any] else { continue }

                    do {
                        let data = try JSONSerialization.data(withJSONObject: value, options: [])
                        let part = try JSONDecoder().decode(Part.self, from: data)
                        newParts.append(part)
                    } catch {
                        print("Failed - Line 41")
                        continue
                    }
                }
            }
            self.parts = newParts
        }
    }
    
    func stopListening() {
        if let handle {
            ref.removeObserver(withHandle: handle)
            self.handle = nil
        }
    }
}

