

import Foundation

protocol ShoppingItem {
  var title: String { get }
  var imageName: String { get }
}

struct IPhone: ShoppingItem {
  let title: String
  let imageName: String
}
