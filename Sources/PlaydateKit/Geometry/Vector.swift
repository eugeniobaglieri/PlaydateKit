public import CPlaydate

public typealias Vector2 = SIMD2<Float>

public extension Vector2 {
    init(_ collisionVector: CollisionVector) {
        self.init(x: Float(collisionVector.x), y: Float(collisionVector.y))
    }
    
    init(radius: Float, theta: Float) {
        self.init(radius * cosf(theta), radius * sinf(theta))
    }
    
    static var zero: Self { Vector2(x: 0.0, y: 0.0) }
}

public extension Vector2 {
    
    var lenght: Float { return sqrtf(x * x + y * y) }
    
    func reflected(along normal: Self) -> Self {
        self - (2 * (self • normal)) * normal
    }
    
    mutating func reflect(along normal: Self) {
        self = self.reflected(along: normal)
    }
    
    func rotated(by theta: Float) -> Self {
        .init(
            x: x * cosf(theta) + y * -sinf(theta),
            y: x * sinf(theta) + y * +cosf(theta)
        )
    }
    
    mutating func rotate(by theta: Float) {
        self = rotated(by: theta)
    }
    
    func normalized() -> Self {
        guard lenght > 0 else { return Self.zero }
        return .init(
            x: x / lenght,
            y: y / lenght
        )
    }
    
    mutating func normalize() {
        self = lenght != 0 ? normalized() : Self.zero
    }
    
}

infix operator • : MultiplicationPrecedence
public extension Vector2 {
    static func • (lhs: Self, rhs: Self) -> Float {
        (lhs.x * rhs.x) + (lhs.y * rhs.y)
    }
}
