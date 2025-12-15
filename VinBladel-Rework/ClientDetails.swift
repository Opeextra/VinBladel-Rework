//
//  ClientDetails.swift
//  VinBladel-Rework
//
//  Created by Jacob M. Caulfield on 12/15/25.
//
import SwiftUI

struct ClientDetailsView: View {
    @State var clients: [Client] = []
    @State var popOver: Bool = false
    var body: some View {
        NavigationStack{
            Button("Add New"){
                popOver.toggle()
            }
            .popover(isPresented: $popOver){
                AddClient(clients: $clients)
            }
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
    var body: some View {
        TextField("Name", text: $name)
    }
}
struct Client: Identifiable{
    let id: String
    var name: String
    var contactInfo: [String: String]
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
    }
    func load(){
        for (key, value) in contactInfo{
            contact += "\(key): \(value)\n"
        }
    }
}
