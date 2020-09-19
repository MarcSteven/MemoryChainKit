//  Created by Marc Steven on 2020/8/21.
//  Copyright © 2020 Marc Steven All rights reserved.
//


public extension IndexSet {
  // Create an array of index paths from an index set
  func indexPaths(for section: Int) -> [IndexPath] {
    let indexPaths = map { (i) -> IndexPath in
      return IndexPath(item: i, section: section)
    }
    return indexPaths
  }
}
