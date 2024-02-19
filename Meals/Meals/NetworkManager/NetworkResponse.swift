//
//  NetworkResponse.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/02/2024.
//

import Foundation

struct NetworkResponse: Equatable {
  let data: Data?
  let urlResponse: HTTPURLResponse
}
