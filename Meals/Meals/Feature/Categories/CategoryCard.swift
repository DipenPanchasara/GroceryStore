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
    ZStack(alignment: .bottom) {
//        Image(.init(name: "placeholder", bundle: .main))
//          .resizable()
//          .aspectRatio(contentMode: .fit)
      Rectangle()
        .fill(Color.pink)
      VStack(spacing: .zero) {
        HStack(spacing: .zero) {
          Text(categoryModel.name)
            .font(.title)
            .bold()
            .foregroundStyle(Color.white)
          Spacer()
        }
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 16)
    }
    .cornerRadius(16)
    .shadow(color: Color.white.opacity(0.8), radius: 2, y: 4)
    .padding(.top, 2)
    .frame(height: 200)
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
