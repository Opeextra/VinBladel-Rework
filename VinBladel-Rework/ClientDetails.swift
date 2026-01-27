//
//  ClientDetails.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 12/15/25.
//
import SwiftUI

struct ClientDetailsView: View {
    @State var clients: [Client] = []
    @State var showAlert: Bool = false
    var body: some View {
        NavigationStack{
            NavigationLink(destination: AddClient(clients: $clients), label: {
                Text("Add Client")
            })
            Text("Previous Clients")
            ScrollView{
                ForEach(clients, id: \.id) { client in
                    NavigationLink(destination: ClientView(id: "\(client.name)", name: "\(client.name)", contactInfo: client.contactInfo)) {
                        Text(client.name)
                    }
                }
            }
        }
    }
}
struct AddClient: View {
    @Binding var clients: [Client]
    @State var name: String = ""
    @State var contactInfo: [String: String] = [:]
    @State var contact: String = ""
    @State var contactData: String = ""
    var body: some View {
        NavigationStack{
            TextField("Name", text: $name)
            NavigationLink(destination: ContactInfoView(contactData: $contactData, contact: $contact, contactInfo: $contactInfo, clients: $clients), label: {Text("Add contact Info")})
            Button("Add Client"){
                clients.append(Client(id: name, name:  name, contactInfo: contactInfo))
            }
            .padding()
        }
    }
}
struct ContactInfoView: View {
    @Binding var contactData: String
    @Binding var contact: String
    @Binding var contactInfo: [String: String]
    @Binding var clients: [Client]
    
    var body: some View {
        VStack{
            TextField("Enter info name. ex: Phone number, email", text: $contact)
            TextField("Enter info data. ex: +1 (847) 732-3491", text: $contactData)
        }
        Button("Add"){
            contactInfo[contact] = contactData
            contact = ""
            contactData = ""
        }
    }
}
struct ClientView: View {
    let id: String
    let name: String
    let contactInfo: [String: String]
    @State var contact: String = ""
    var body: some View {
        VStack{
            Text("Name: \(name)")
            Text("Contact Info: \(contact)")
        }
        .padding()
        .onAppear(){
            load()
        }
    }
    func load(){
        for (key, value) in contactInfo{
            contact += "\(key): \(value)\n"
        }
    }
}
