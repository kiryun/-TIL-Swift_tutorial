///Foundation 프레임워크에 정의되어 있는 개방 접근수준의 NSString 클래스
//import Foundation
//
//open class NSString: NSObject, NSCopying, NSMutableCopying, NSSecureCoding{
//    open var length: Int {get}
//    open func character(at index: Int) -> unichar
//    public init()
//    public init?(coder aDecoder: NSCoder)
//}


///잘못된ㄴ 접근수준 부여
//private class AClass{
//    // 공개 접근수준을 부여해도 AClass의 접근수준이 비공개 접근수준이므로 이 메서드의 접근수준도 비공개 접근수준으로 취급됩니다.
//    public func someMethod(){
//        // ...
//    }
//}
//
//// AClass의 접근수준이 비공개 접근수준이므로
//// 공개 접근수준 함수의 매개변수나 반환값 타입으로 사용할 수 없습니다.
//public func someFunction(a: AClass) -> AClass { // Error! Function cannot be declared public because its parameter uses a private type
//    return a
//}


///설정자의 접근수준 지정
public struct SomeType{
    // 비공개 접근수준 저장 프로퍼티 count
    private var count: Int = 0
    
    // 공개 접근수준 저장프로퍼티 publicStoredProperty
    public var publicStoredProperty: Int = 0
    
    // 공개 접근수준 저장프로퍼티 publicGetOnlyStoredProperty
    // 설정자는 비공개 접근수준
    public private(set) var publicGetOnlyStoredProperty: Int = 0
    
    // 내부 접근수준 저장 프로퍼티 internalComputedProperty
    internal var internalComputedProperty: Int {
        get{
            return count
        }
        set{
            count += 1
        }
    }
    
    // 내부 접근수준 저장 프로퍼티 internalGetOnlyComptedProperty
    // 설정자는 비공개 접근수준
    internal private(set) var internalGetOnlyComptedProperty: Int{
        get{
            return count
        }
        set{
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    public subscript() -> Int{
        get{
            return count
        }
        set{
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    // 설정자는 내부 접근수준
    public internal(set) subscript(some: Int) -> Int {
        get{
            return count
        }
        
        set{
            count += 1
        }
    }
}

var someInstance: SomeType = SomeType()

// 외부에서 접근자, 설정자 모두 사용가능
print(someInstance.publicStoredProperty) // 0
someInstance.publicStoredProperty = 100

// 외부에서 접근자만 사용 가능
print(someInstance.publicGetOnlyStoredProperty) // 0
//someInstance.publicGetOnlyStoredProperty = 100 // Error!

// 외부에서 접근자, 설정자 모두 사용가능
print(someInstance.internalComputedProperty) // 0
someInstance.internalComputedProperty = 100

// 외부에서 접근자만 사용가능
print(someInstance.internalGetOnlyComptedProperty) // 1
//someInstance.internalGetOnlyComptedProperty = 100 // Error!

// 외부에서 접근자, 설정자 모두 사용가능
print(someInstance[]) // 1
someInstance[] = 100

// 외부에서 접근자만, 같은 모듈 내에서는 설정자도 사용가능
print(someInstance[0]) // 2
someInstance[0] = 100
