
import SwiftUI

struct BeverageList: View {
    
    @StateObject var viewModel: BeverageListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    }else if viewModel.beverages.isEmpty && viewModel.networkError != nil {
                        Text(viewModel.networkError?.errorDescription ?? "")
                    }else {
                        List(viewModel.beverages) { beverage in
                            NavigationLink {
                                BeverageDetailView(beverage: beverage)
                            } label: {
                                HStack{
                                    BeverageListCell(beverage: beverage)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Beverages")
            .task {
                await viewModel.fetchBeverages()
            }
        }
    }
}
