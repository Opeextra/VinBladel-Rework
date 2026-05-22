//
//  ClientDetails.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 12/15/25.
//
import SwiftUI

struct Client: Identifiable {
    var id: String
    let name: String
    let contactInfo: [String: String]
    let cars: [String: String]
}

struct ClientDetailsView: View {
    @State private var store = CustomerStore()
    @State var showAlert: Bool = false
    var body: some View {
        NavigationStack {
            NavigationLink(destination: AddClient(store: store)) {
                Text("Add Client")
            }
            Text("Previous Clients")
            ScrollView {
                ForEach(store.clients) { client in
                    NavigationLink(destination: ClientView(client: client)) {
                        Text(client.name)
                    }
                }
            }
        }
        .onAppear { store.startListening() }
    }
}

struct AddClient: View {
    let store: CustomerStore
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var contactInfo: [String: String] = [:]
    @State var contact: String = ""
    @State var contactData: String = ""
    var body: some View {
        NavigationStack {
            TextField("Name", text: $name)
            NavigationLink(destination: ContactInfoView(
                contactData: $contactData,
                contact: $contact,
                contactInfo: $contactInfo
            )) {
                Text("Add contact Info")
            }
            Button("Add Client") {
                store.addCustomer(name: name, contactInfo: contactInfo)
                dismiss()
            }
            .padding()
        }
    }
}

struct ContactInfoView: View {
    @Binding var contactData: String
    @Binding var contact: String
    @Binding var contactInfo: [String: String]

    var body: some View {
        VStack {
            TextField("Enter info name. ex: Phone number, email", text: $contact)
            TextField("Enter info data. ex: +1 (847) 732-3491", text: $contactData)
        }
        Button("Add") {
            contactInfo[contact] = contactData
            contact = ""
            contactData = ""
        }
    }
}

struct ClientView: View {
    let client: Client
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Name: \(client.name)").font(.headline)

            Text("Contact Info").font(.subheadline).bold()
            ForEach(client.contactInfo.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Text("\(key): \(value)")
            }

            Text("Cars").font(.subheadline).bold()
            ForEach(client.cars.sorted(by: { $0.key < $1.key }), id: \.key) { nickname, vin in
                Text("\(nickname): \(vin)")
            }
        }
        .padding()
    }
}
