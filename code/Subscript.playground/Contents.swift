/////서브스크립트 정의문법
//subscript(index: Int) -> Int{
//    get{
//        // 적절한 서브스크립트 결과값 반환
//    }
//    set(newValue){
//        // 적절한 설정자 역할 수행
//    }
//}
//
//
/////읽기전용 서브스크립트 정의 문법
//subscript(index: Int) -> Int{
//    get{
//        // 적절한 서브스크립트 값 반환
//    }
//}
//
//subscript(index: Int) -> Int{
//     // 적절한 서브스크립트 결과값 반환
//}


///School클래스 서브스크립트 구현
//struct Student{
//    var name: String
//    var number: Int
//}
//
//class School{
//    var number: Int = 0
//    var students: [Student] = [Student]()
//
//    func addStudent(name: String){
//        let student: Student = Student(name: name, number: self.number)
//        self.students.append(student)
//        self.number += 1
//    }
//
//    func addStudents(names: String...){
//        for name in names{
//            self.addStudent(name: name)
//        }
//    }
//
//    subscript(index: Int) -> Student?{
//        if index < self.number{
//            return self.students[index]
//        }
//        return nil
//    }
//}
//
//let highSchool: School = School()
//highSchool.addStudents(names: "MiJeong", "JuHyun", "Jiyoung", "SeongUk", "MooonDuk")
//
//let aStudent: Student? = highSchool[1]
//print("\(aStudent?.number) \(aStudent?.name)") // Optional(1) Optional("JuHyun")


///복수의 서브스크립트 구현
//struct Student{
//    var name: String
//    var number: Int
//}
//
//class School{
//    var number: Int = 0
//    var students: [Student] = [Student]()
//
//    func addStudent(name: String){
//        let student: Student = Student(name: name, number: self.number)
//        self.students.append(student)
//        self.number += 1
//    }
//
//    func addStudents(names: String...){
//        for name in names{
//            self.addStudent(name: name)
//        }
//    }
//
//    subscript(index: Int) -> Student?{ // 첫번째 서브스크립트
//        get{
//            if index < self.number{
//                return self.students[index]
//            }
//            return nil
//        }
//
//        set{
//            guard var newStudent: Student = newValue else{
//                return
//            }
//
//            var number: Int = index
//
//            if index > self.number{
//                number = self.number
//                self.number += 1
//            }
//
//            newStudent.number = number
//            self.students[number] = newStudent
//        }
//
//    }
//
//    subscript(name: String) -> Int?{ // 두번째 서브스크립트
//        get{
//            return self.students.filter{ $0.name == name }.first?.number
//        }
//
//        set{
//            guard var number: Int = newValue else{
//                return
//            }
//
//            if number > self.number{
//                number = self.number
//                self.number += 1
//            }
//
//            let newStudent: Student = Student(name: name, number: number)
//            self.students[number] = newStudent
//        }
//    }
//
//    subscript(name: String, number: Int) -> Student?{ // 세번째 서브스크립트
//        return self.students.filter{ $0.name == name && $0.number == number}.first
//    }
//
////    subscript(name: String, number: Int) -> Student?{ // 네번째 서브스크립트 // error: invalid redeclaration of 'subscript(_:_:)'
////           return self.students.filter{ $0.name == name && $0.number == number}.first
////    }
//}
//
//let highSchool: School = School()
//highSchool.addStudents(names: "MiJeong", "JuHyun", "Jiyoung", "SeongUk", "MooonDuk")
//
//let aStudent: Student? = highSchool[1]
//print("\(aStudent?.number) \(aStudent?.name)") // Optional(1) Optional("JuHyun")
//
//print(highSchool["MiJeong"]) // Optional(0)
//print(highSchool["wimes"]) // nil
//
//highSchool[0] = Student(name: "HongEui", number: 0)
//highSchool["MangGu"] = 1
//
//print(highSchool["JuHyun"]) // nil
//print(highSchool["MangGu"]) // Optional(1)
//print(highSchool["SeongUk", 3]) // Optional(__lldb_expr_1.Student(name: "SeongUk", number: 3))
//print(highSchool["HeeJin", 3]) // nil


///타입 서브스크립트 구현
enum School: Int{
    case elementary = 1, middle, high, university
    
    static subscript(level: Int) -> School?{
        return Self(rawValue: level)
        //return School(rawValue: level)과 같은 표현
    }
}

let school: School? = School[2]
print(school) // Optional(__lldb_expr_1.School.middle)
