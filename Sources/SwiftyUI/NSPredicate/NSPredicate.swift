//
//  NSPredicate.swift
//  
//
//  Created by devonly on 2022/02/26.
//

import Foundation

extension NSPredicate {
    /// 前後方一致検索
    public convenience init(_ property: String, contains q: String) {
        self.init(format: "\(property) CONAINS \(q.escepedString)")
    }
    
    /// 前方一致検索
    public convenience init(_ property: String, beginWith q: String) {
        self.init(format: "\(property) BEGINWITH \(q.escepedString)")
    }
    
    /// 後方一致検索
    public convenience init(_ property: String, endWith q: String) {
        self.init(format: "\(property) ENDWITH \(q.escepedString)")
    }
    
    /// WHERE検索
    public convenience init(_ property: String, equal value: Any) {
        self.init(format: "\(property) == %@", argumentArray: [value])
    }
    
    /// WHERE検索
    public convenience init(_ property: String, lessThan value: Any) {
        self.init(format: "\(property) <= %@", argumentArray: [value])
    }
    
    /// WHERE検索
    public convenience init(_ property: String, less value: Any) {
        self.init(format: "\(property) < %@", argumentArray: [value])
    }
    
    /// WHERE検索
    public convenience init(_ property: String, greatThan value: Any) {
        self.init(format: "\(property) >= %@", argumentArray: [value])
    }
    
    /// WHERE検索
    public convenience init(_ property: String, great value: Any) {
        self.init(format: "\(property) > %@", argumentArray: [value])
    }
    
    /// IN検索
    public convenience init(_ property: String, valuesIn values: [Any]) {
        self.init(format: "\(property) IN %@", argumentArray: [values])
    }
    
    /// BETWEEN検索
    public convenience init(_ property: String, between min: AnyObject, to max: Any) {
        self.init(format: "\(property) BETWEEN {%@, %@}", argumentArray: [min, max])
    }
}

extension String {
    var escepedString: String {
        self.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "'", with: "\\'")
    }
}
