//
//  DRCountedSet.swift
//  Dragon Dispatch
//
//  Created by George Green on 05/10/2014.
//  Copyright (c) 2014 The Swift Guru. All rights reserved.
//

import Foundation

internal class DRCountedSet<T: Hashable>: SequenceType {
	private var _countsForValues: [T: Int] = [:]
	
	/// Increment the count for the specified value.
	/// @param value The value for which the count should be incremented.
	func incrementValue(value: T) {
		if let oldCount = _countsForValues[value] {
			if oldCount == -1 {
				_countsForValues.removeValueForKey(value)
			} else {
				_countsForValues[value] = oldCount + 1
			}
		} else {
			_countsForValues[value] = 1
		}
	}
	
	/// Decrement the count for the specified value.
	/// @param value The value for which the count should be decremented.
	func decrementValue(value: T) {
		if let oldCount = _countsForValues[value] {
			if oldCount == 1 {
				_countsForValues.removeValueForKey(value)
			} else {
				_countsForValues[value] = oldCount - 1
			}
		} else {
			_countsForValues[value] = -1
		}
	}
	
	/// Get the count for a specified value.
	/// @param The value for which to check the count.
	/// @return The count for the specified value.
	func countForValue(value: T) -> Int {
		if let count = _countsForValues[value] {
			return count
		} else { return 0 }
	}
	
	/// Sets the count for the specified value to 0.
	/// @param value The value for which the count will be set to 0.
	func zeroValue(value: T) {
		_countsForValues.removeValueForKey(value)
	}
	
	// MARK: - SequenceType Methods
	
	func generate() -> GeneratorOf<T> {
		var index = 0
		return GeneratorOf<T> {
			if index < self._countsForValues.keys.array.count {
				return self._countsForValues.keys.array[index]
			} else {
				return nil
			}
		}
	}
	
}
