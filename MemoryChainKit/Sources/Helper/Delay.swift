//
//Delay.swift
//MemoryChainkit
//Created by Marc Steven on 2020/4/19
// @copyright 2020 Marc Steven
import Foundation

/**
 Holds information about stanza delayed delivery as described in [XEP-0203: Delayed Delivery]
 
 [XEP-0203: Delayed Delivery]: http://xmpp.org/extensions/xep-0203.html
 */
open class Delay {
    
    fileprivate static let stampFormatter = ({()-> DateFormatter in
        var f = DateFormatter();
        f.locale = Locale(identifier: "en_US_POSIX");
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        f.timeZone = TimeZone(secondsFromGMT: 0);
        return f;
    })();
    
    fileprivate static let stampWithMilisFormatter = ({()-> DateFormatter in
        var f = DateFormatter();
        f.locale = Locale(identifier: "en_US_POSIX");
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
        f.timeZone = TimeZone(secondsFromGMT: 0);
        return f;
    })();
    
    /// Holds timestamp when delay started. In most cases it is very close to time when stanza was sent.
    public let stamp:Date?;
    /// JID of entity responsible for delay
    public let from:JID?;
    
    public init(element:Element) {
        if let stampStr = element.getAttribute("stamp") {
            stamp = Delay.stampFormatter.date(from: stampStr) ?? Delay.stampWithMilisFormatter.date(from: stampStr);
        } else {
            stamp = nil;
        }
        if let fromStr = element.getAttribute("from") {
            from = JID(fromStr);
        } else {
            from = nil
        }
    }
    
}
