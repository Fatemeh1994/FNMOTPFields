//
//  File.swift
//  
//
//  Created by Reza Khonsari on 4/20/21.
//

import Foundation

infix operator ..

func ..<T: AnyObject>(lhs: T, rhs: (T) -> ()) -> T { rhs(lhs); return lhs }
