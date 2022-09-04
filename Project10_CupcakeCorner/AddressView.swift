//
//  AdressView.swift
//  Project10_CupcakeCorner
//
//  Created by admin on 21.08.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderClass
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                TextField("Street address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip code", text: $order.order.zipCode)
            }
            Section {
                NavigationLink {
                    CheckOutView(order: order)
                } label: {
                    Text("Check out.")
                }
            }
            .disabled(order.order.isValid == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderClass(order: Order()))
    }
}
