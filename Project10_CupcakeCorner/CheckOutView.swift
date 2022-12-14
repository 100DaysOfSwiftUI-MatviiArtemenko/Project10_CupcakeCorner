//
//  CheckOutView.swift
//  Project10_CupcakeCorner
//
//  Created by admin on 21.08.2022.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: OrderClass
    
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string:"https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total: \(order.order.cost, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    .font(.title)
                
                Button {
                    Task { await placeOrder() }
                } label: {
                    Text("Place order.")
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
            
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Didnt work ")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type]) cupcakes is on its way."
            confirmationTitle = "Thank you."
            showingConfirmation = true
            
        } catch {
            print("Check out failed")
            confirmationTitle = "Error."
            confirmationMessage = "Enternet connection is failed or data is invalid."
            showingConfirmation = true
            
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: OrderClass(order: Order()))
    }
}
