//
//  SimpleSpec.swift
//  SwiftCheck
//
//  Created by Robert Widmann on 8/3/14.
//  Copyright (c) 2014 Robert Widmann. All rights reserved.
//

import XCTest
import SwiftCheck
import func Swiftz.<^>

public struct ArbitraryFoo {
	let x : Int
	let y : Int
	
	public static func create(x : Int) -> Int -> ArbitraryFoo {
		return { y in ArbitraryFoo(x: x, y: y) }
	} 
	
	public var description : String {
		return "Arbitrary Foo!"
	}
}

extension ArbitraryFoo : Arbitrary {
	public static func arbitrary() -> Gen<ArbitraryFoo> {
		return ArbitraryFoo.create <^> Int.arbitrary() <*> Int.arbitrary()
	}
	
	public static func shrink(x : ArbitraryFoo) -> [ArbitraryFoo] {
		return shrinkNone(x)
	}
}


class SimpleSpec : XCTestCase {
	func testAll() {
		property["Integer Equality is Reflexive"] = forAll { (i : Int) in
			return i == i
		}

		property["Unsigned Integer Equality is Reflexive"] = forAll { (i : UInt) in
			return i == i
		}

		property["Float Equality is Reflexive"] = forAll { (i : Float) in
			return i == i
		}

		property["Double Equality is Reflexive"] = forAll { (i : Double) in
			return i == i
		}
		
		property["ArbitraryFoo Properties are Reflexive"] = forAll { (i : ArbitraryFoo) in
			return i.x == i.x && i.y == i.y
		}
	}
}
