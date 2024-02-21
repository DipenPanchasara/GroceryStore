//
//  CategoryCard.swift
//  Meals
//
//  Created by Dipen Panchasara on 03/02/2024.
//

import SwiftUI

struct CategoryCard: View {
  let categoryModel: CategoryModel
  
  var body: some View {
//    ZStack(alignment: .bottom) {
//        Image(.init(name: "placeholder", bundle: .main))
//          .resizable()
//          .aspectRatio(contentMode: .fit)
    VStack(spacing: .zero) {
      HStack {
        if let thumbnailURL = categoryModel.thumbnailURL {
          RemoteImage(source: thumbnailURL)
        } else {
          Rectangle()
            .fill(Color.pink)
        }
      }
      .padding(.vertical, 4)
//      .padding(.bottom, 2)
      VStack(spacing: .zero) {
        HStack(spacing: .zero) {
          Text(categoryModel.name)
            .font(.title)
            .bold()
            .foregroundStyle(Color.pink)
          Spacer()
        }
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 16)
    }
    .background(Color.white)
    .cornerRadius(16)
    .frame(height: 200)
    .shadow(color: .gray,radius: 4)
  }
}

#if DEBUG
struct CategoryCard_Previews: PreviewProvider {
  static var previews: some View {
    CategoryCard(
      categoryModel: CategoryModel(
        id: "anyId",
        name: "Vegetarian",
        thumbnailURL: nil
      )
    )
    .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 220))
    .preferredColorScheme(.dark)
    .previewDisplayName("Category Card")
    .previewLayout(.sizeThatFits)
  }
}
#endif
