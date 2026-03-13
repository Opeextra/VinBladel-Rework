//
//  InProgress.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//
import FirebaseDatabase
import SwiftUI
import FirebaseCore

struct InProgress: View {
    @Binding var customer: Client
    @State var data = Database.database().reference().child("Customers")
    @State private var isSaving = false
    @State private var saveMessage: String? = nil

    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                Button{
                    addData()
                } label: {
                    Text(isSaving ? "Saving..." : "Add Stuff")
                }
                .disabled(isSaving)

                if let saveMessage = saveMessage {
                    Text(saveMessage)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                List{
                    NavigationLink("Test", destination: PartsandServices())
                }
            }
        }
    }
    func addData(){
        // Prevent multiple taps
        isSaving = true
        saveMessage = nil

        // Convert the Client to a dictionary suitable for Realtime Database
        let customerDict = clientDictionary(from: customer)

        // Ensure we have a valid key to update
        guard !customer.id.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.isSaving = false
            self.saveMessage = "Save failed: Missing customer id."
            return
        }
        
        data.child(customer.id).updateChildValues(customerDict) { error, _ in
            DispatchQueue.main.async {
                self.isSaving = false
                if let error = error {
                    self.saveMessage = "Save failed: \(error.localizedDescription)"
                } else {
                    self.saveMessage = "Saved successfully."
                }
            }
        }
    }

    private func clientDictionary(from client: Client) -> [String: Any] {
        // Manually map known fields of Client to a dictionary suitable for Firebase.
        // Update these keys/values to match your Client model.
        let dict: [String: Any] = [
            "id": client.id
        ]
        // TODO: Map other Client fields here, e.g.:
        // dict["name"] = client.name
        // dict["email"] = client.email
        return dict
    }
}

