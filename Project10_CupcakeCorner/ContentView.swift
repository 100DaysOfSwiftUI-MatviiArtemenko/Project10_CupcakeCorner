//
//  ContentView.swift
//  Project10_CupcakeCorner
//
//  Created by admin on 21.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = OrderClass(order: Order())
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cupcake", selection:  $order.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cupcakes: \(order.order.quantity)", value: $order.order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.order.specialRequestEnabled.animation())
                    if order.order.specialRequestEnabled {
                        Toggle("Additional frosting?", isOn: $order.order.extraFrosting)
                        Toggle("Additional sprinkles?", isOn: $order.order.extraSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("CupcakeCorner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
