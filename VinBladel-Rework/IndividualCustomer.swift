//
//  IndividualCustomer.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//
import FirebaseDatabase
import SwiftUI

struct IndividualCustomer: View {
    @Binding var customer: Client
  
    var body: some View {
        NavigationStack{
            
            List{
                Text("Test")
                
            }
            NavigationLink(destination: Existing()) {
                Text("List")
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.black)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.orange))
                    .padding()
            }
        }
    }
   
}


