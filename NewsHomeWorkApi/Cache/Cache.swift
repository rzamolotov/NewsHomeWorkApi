//
//  Cache.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 06.11.2022.
//

import Foundation


protocol Cache: Actor {
    
    associatedtype V
    var expirationInterval: TimeInterval { get } //срок работы кэша
    
    func setValue(_ value: V?, forKey key: String) //выбор значений
    func value(forKey key: String) -> V? //значение
    
    func removeValue(forKey key: String)//удалить значение
    func removeAllValues()//удалить все значения
}
