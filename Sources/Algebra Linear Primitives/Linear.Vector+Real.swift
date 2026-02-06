// Linear.Vector+Real.swift
// Angle and rotation operations for 2D vectors with Real scalar types.

public import Dimension_Primitives
public import Real_Primitives

// MARK: - Numeric.Transcendental

extension Linear.Vector where N == 2, Scalar: BinaryFloatingPoint & Numeric.Transcendental {
    /// The angle of this vector from the positive X-axis.
    @inlinable
    public static func angle(_ vector: Self) -> Radian<Scalar> {
        .atan2(y: vector.dy, x: vector.dx)
    }

    /// The angle of this vector from the positive X-axis.
    @inlinable
    public var angle: Radian<Scalar> {
        Self.angle(self)
    }

    /// Creates a unit vector at the given angle from the positive X-axis.
    @inlinable
    public static func unit(at angle: Radian<Scalar>) -> Self {
        Self(dx: Linear.Dx(__unchecked: (),angle.cos.value), dy: Linear.Dy(__unchecked: (),angle.sin.value))
    }

    /// Creates a vector from polar coordinates (length and angle).
    @inlinable
    public static func polar(length: Linear.Length, angle: Radian<Scalar>) -> Self {
        let r = length.rawValue
        return Self(dx: Linear.Dx(__unchecked: (),r * angle.cos.value), dy: Linear.Dy(__unchecked: (),r * angle.sin.value))
    }

    /// Computes the unsigned angle between this vector and another.
    ///
    /// Returns an angle in the range [0, π].
    @inlinable
    public static func angle(_ lhs: Self, to rhs: Self) -> Radian<Scalar> {
        let dotProduct = dot(lhs, rhs)
        let magnitudes = lhs.length.rawValue * rhs.length.rawValue
        guard magnitudes > 0 else { return .zero }
        return .acos(Scale(dotProduct / magnitudes))
    }

    /// Computes the unsigned angle between this vector and another.
    @inlinable
    public func angle(to other: Self) -> Radian<Scalar> {
        Self.angle(self, to: other)
    }

    /// Computes the signed angle from this vector to another.
    ///
    /// Returns an angle in (-π, π], positive for counter-clockwise rotation.
    @inlinable
    public static func signedAngle(_ lhs: Self, to rhs: Self) -> Radian<Scalar> {
        Radian(__unchecked: (),Scalar._atan2(Self.cross(lhs, rhs).rawValue, dot(lhs, rhs)))
    }

    /// Computes the signed angle from this vector to another.
    @inlinable
    public func signedAngle(to other: Self) -> Radian<Scalar> {
        Self.signedAngle(self, to: other)
    }

    /// Rotates this vector by an angle in radians.
    @inlinable
    public static func rotated(_ vector: Self, by angle: Radian<Scalar>) -> Self {
        let c = angle.cos.value
        let s = angle.sin.value
        let x = vector.dx.rawValue
        let y = vector.dy.rawValue
        return Self(dx: Linear.Dx(__unchecked: (),x * c - y * s), dy: Linear.Dy(__unchecked: (),x * s + y * c))
    }

    /// Rotates this vector by an angle in radians.
    @inlinable
    public func rotated(by angle: Radian<Scalar>) -> Self {
        Self.rotated(self, by: angle)
    }

    /// Rotates this vector by an angle in degrees.
    @inlinable
    public static func rotated(_ vector: Self, by angle: Degree<Scalar>) -> Self {
        rotated(vector, by: angle.radians)
    }

    /// Rotates this vector by an angle in degrees.
    @inlinable
    public func rotated(by angle: Degree<Scalar>) -> Self {
        Self.rotated(self, by: angle)
    }
}
