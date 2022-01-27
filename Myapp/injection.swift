//
//  injection.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/25/22.
//

// File: App/AppDelegate+Injection.swift
import Foundation
import Resolver

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
      register { EventRepository() as IEventRepository }.scope(.application)
  }
}
