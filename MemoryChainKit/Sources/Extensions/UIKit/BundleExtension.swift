//
//  BundleExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/11.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
public extension Bundle {
    /// Returns the `Bundle` object with which the specified class name is associated.
    ///
    /// The `Bundle` object that dynamically loaded `forClassName` (a loadable bundle),
    /// the `Bundle` object for the framework in which `forClassName` is defined, or the
    /// main bundle object if `forClassName` was not dynamically loaded or is not defined
    /// in a framework.
    ///
    /// This method creates and returns a new `Bundle` object if there is no existing
    /// bundle associated with `forClassName`. Otherwise, the existing instance is returned.
    convenience init?(forClassName className: String) {
        guard let aClass = NSClassFromString(className) else {
            return nil
        }

        self.init(for: aClass)
    }
}

public extension Bundle {
    private func info(forKey key: String) -> String {
        infoDictionary?[key] as? String ?? ""
    }

    private func info(forKey key: CFString) -> String {
        info(forKey: key as String)
    }

    /// The name of the executable in this bundle (if any).
     var executable: String {
        info(forKey: kCFBundleExecutableKey)
    }

    /// The bundle identifier.
     var identifier: String {
        info(forKey: kCFBundleIdentifierKey)
    }

    /// The version number of the bundle.
     var versionNumber: String {
        info(forKey: "CFBundleShortVersionString")
    }

    /// The build number of the bundle.
    var buildNumber: String {
        info(forKey: kCFBundleVersionKey)
    }

    }

public extension Bundle {
    /// Returns the first URL for the specified common directory in the user domain.
     static func url(for directory: FileManager.SearchPathDirectory) -> URL? {
        FileManager.default.url(for: directory)
    }
}

public extension Bundle {
    func decode<T:Decodable>( _ type:T.Type,from fileName:String) ->T {
        guard let json = url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in app bundle")
        }
        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("failed to locate \(fileName) in app bundle")
        }
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("failed to locate \(fileName) in app bundle")
        }
        return result
    }
}


