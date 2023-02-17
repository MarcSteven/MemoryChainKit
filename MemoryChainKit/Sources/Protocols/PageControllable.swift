


//
//  Created by Marc Steven on 2023/2/3.
//


import Foundation
import CoreGraphics
import UIKit

public protocol PageControllable: AnyObject {
    var numberOfPages: Int { get set }
    var currentPage: Int { get }
    var progress: Double { get set }
    var hidesForSinglePage: Bool { get set }
    var borderWidth: CGFloat { get set }

    func set(progress: Int, animated: Bool)
}
