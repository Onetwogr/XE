//
//  PropertyActionView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

struct PropertyActionView: View {
    
    var actionType: ActionType

    @StateObject private var sellViewModel = SellPropertyViewModel()
    //@StateObject private var buyViewModel: BuyPropertyViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if actionType == .sell {
                        // Sell Section
                        SellSectionView(
                            title: $sellViewModel.title,
                            location: $sellViewModel.location,
                            price: $sellViewModel.price,
                            description: $sellViewModel.description,
                            isLocationSelected: $sellViewModel.isLocationSelected
                        )
                    } else {
                        // Placeholder for Buy section
                        // BuySectionView(
                        // )
                    }

                    // Submit/Search button
                    ActionSectionView(
                        title: actionType == .sell ? "Submit" : "Search",
                        isFormValid: actionType == .sell ? sellViewModel.isFormValid : false,
                        submitForm: actionType == .sell ? sellViewModel.submitForm : {}
                    )
                }
            }
            .navigationTitle(actionType == .sell ? "Add Property" : "Buy Property")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if actionType == .sell {
                        ClearButton(action: sellViewModel.clearForm)
                    } else {
                        // Placeholder for Buy ViewModel ClearButton
                        // ClearButton(action: buyViewModel.clearForm)
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.dismissKeyboard() // Dismiss keyboard when tapping outside
            }
            .alertView(
                title: "Submitted Ad",
                message: sellViewModel.submittedAd,
                isPresented: $sellViewModel.showAlert,
                onDismiss: { sellViewModel.submittedAd = "" } // Clear JSON after dismiss
            )
        }
    }
}

#Preview {
    PropertyActionView(actionType: .sell)
}

