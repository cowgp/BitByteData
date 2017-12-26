// Copyright (c) 2017 Timofey Solomko
// Licensed under MIT License
//
// See LICENSE for license information

import Foundation

public final class LsbBitWriter: BitWriter {

    public private(set) var data: Data = Data()

    private var bitMask: UInt8 = 1
    private var currentByte: UInt8 = 0

    public var isAligned: Bool {
        return self.bitMask == 1
    }

    public init() { }

    public func write(bit: UInt8) {
        precondition(bit <= 1, "A bit must be either 0 or 1.")

        self.currentByte += self.bitMask * bit

        if self.bitMask == 128 {
            self.bitMask = 1
            self.data.append(self.currentByte)
            self.currentByte = 0
        } else {
            self.bitMask <<= 1
        }
    }

    public func write(bits: [UInt8]) {
        for bit in bits {
            precondition(bit <= 1, "A bit must be either 0 or 1.")

            self.currentByte += self.bitMask * bit

            if self.bitMask == 128 {
                self.bitMask = 1
                self.data.append(self.currentByte)
                self.currentByte = 0
            } else {
                self.bitMask <<= 1
            }
        }
    }

    public func write(number: Int, bitsCount: Int) {
        var mask = 1
        for _ in 0..<bitsCount {
            self.write(bit: number & mask > 0 ? 1 : 0)
            mask <<= 1
        }
    }

    public func finish() {
        self.data.append(self.currentByte)
        self.currentByte = 0
        self.bitMask = 1
    }

}
