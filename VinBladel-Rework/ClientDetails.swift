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
            List{
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
            NavigationLink(destination: ContactInfoView(contactData: $contactData, contact: $contact, contactInfo: $contactInfo)){
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
    @State var client: Client
    @State var carNameAdd: String = ""
    @State var vinAdd: String? = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Name: \(client.name)").font(.headline)
            
            Text("Contact Info").font(.subheadline).bold()
            VStack{
                List{
                    ForEach(client.contactInfo.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        Text("\(key): \(value)")
                    }
                }
                .frame(maxHeight: 150)
                .padding()
            }
            
            Text("Cars").font(.subheadline).bold()
            HStack{
                Text("May need to exit and re-enter this view to see changes")
                    .frame(maxWidth: 200)
                List{
                    ForEach(client.cars.sorted(by: { $0.key < $1.key }), id: \.key) { nickname, vin in
                        Text("\(nickname): \(vin)")
                    }
                }
                .frame(maxHeight: 150)
                .padding()
                Button(action:{}, label: {Image(systemName: "plus")})
                
                }
            NavigationLink(destination: AddCar(client: $client, carNameAdd: $carNameAdd, vinAdd: $vinAdd)) {
                Text("Add Car")
            }
            }
        }
}
struct AddCar: View {
    @Binding var client: Client
    @Binding var carNameAdd: String
    @State var showVINAdd: Bool = false
    @Binding var vinAdd: String?
    var body: some View {
        Button("Scan VIN"){
            showVINAdd = true
        }
        .sheet(isPresented: $showVINAdd) {
            VINScannerView(scannedVIN: $vinAdd)
        }
        .padding()
        Text("OR")
            .padding()
        TextField("Type Vin", text: Binding(
            get: { vinAdd ?? "" },
            set: { vinAdd = $0 }
        ))
        .padding()
        .textFieldStyle(.roundedBorder)
        //needed to unwrap the variable first
        TextField("Enter Car Name", text: $carNameAdd)
            .padding()
            .textFieldStyle(.roundedBorder)
        Button("Add car"){
            addCar()
            carNameAdd = ""
            vinAdd = ""
        }
        .padding()
    }
    func addCar(){
        if let vinAdd = vinAdd, !carNameAdd.isEmpty {
            CustomerStore().addCar(customer: client.name, carName: carNameAdd, vin: vinAdd)
        }
    }
}
