// Copyright (c) 2018 Timofey Solomko
// Licensed under MIT License
//
// See LICENSE for license information

import Foundation

/// A type that contains functions for reading `Data` bit-by-bit and byte-by-byte.
public protocol BitReader where Self: ByteReader {

    /// True, if reader's BIT pointer is aligned with the BYTE border.
    var isAligned: Bool { get }

    /// Amount of bits left to read.
    var bitsLeft: Int { get }

    /// Amount of bits that were already read.
    var bitsRead: Int { get }

    /**
     Converts a `ByteReader` instance into `BitReader`, enabling bits reading capabilities. Current `offset` value of
     `byteReader` is preserved.
     */
    init(_ byteReader: ByteReader)

    /// Reads bit and returns it, advancing by one BIT position.
    func bit() -> UInt8

    /// Reads `count` bits and returns them as an array of `UInt8`, advancing by `count` BIT positions.
    func bits(count: Int) -> [UInt8]

    /// Reads `fromBits` bits and returns them as an `Int` number, advancing by `fromBits` BIT positions.
    func int(fromBits count: Int) -> Int

    /// Reads `fromBits` bits and returns them as an `UInt8` number, advancing by `fromBits` BIT positions.
    func byte(fromBits count: Int) -> UInt8

    /// Reads `fromBits` bits and returns them as an `UInt16` number, advancing by `fromBits` BIT positions.
    func uint16(fromBits count: Int) -> UInt16

    /// Reads `fromBits` bits and returns them as an `UInt32` number, advancing by `fromBits` BIT positions.
    func uint32(fromBits count: Int) -> UInt32

    /// Reads `fromBits` bits and returns them as an `UInt64` number, advancing by `fromBits` BIT positions.
    func uint64(fromBits count: Int) -> UInt64

    /// Aligns reader's BIT pointer to the BYTE border, i.e. moves BIT pointer to the first BIT of the next BYTE.
    func align()

}
