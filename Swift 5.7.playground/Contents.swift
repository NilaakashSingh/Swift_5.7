import UIKit

/// Whats new in Swift 5.7

/// Most of the changes might break projects.
/// So, to avoid causing too much disruption, the Swift team have decided to delay enabling some of these changes until Swift 6 lands
/// The changes will be available from Swift 5.7, but you might need to enable them using compiler flags `for eg: -enable-bare-slash-regex.`

// MARK: - /**** Unwrapping Optionals  ****/

// Unwrapping is quite simplier now
var optionalInt: Int? = 4

if let optionalInt {
    print("Unwrapping Optionals:", optionalInt)
}

// Doesn't applies to optional chained unwrapping.
struct GenericModel {
    var id: Int
    var name: String?
}

let optionalmodel1: GenericModel? = GenericModel(id: 1, name: "Chris")
let model1 = GenericModel(id: 1, name: "Chris")
let model2 = GenericModel(id: 2, name: "George")
let model3 = GenericModel(id: 3, name: "Neel")
let model4 = GenericModel(id: 4, name: "Marcell")
let model5 = GenericModel(id: 5, name: "Pavol")

if let id = optionalmodel1?.id {
    print("Unwrapping Optionals:", id)
}

if let name = model2.name {
    print("Unwrapping Optionals", name)
}


// MARK: - /**** Mutistatement closure type  ****/
let models = [model1, model2, model3, model4, model5]

// Earlier we had to specify return for map like this `models.map { model -> String?`
let names = models.map { model in
    if let id = model.id, id > 4 {
        return model.name ?? ""
    } else {
        return model.name?.uppercased() ?? ""
    }
}


// MARK: - /**** Components such as clock, instant and duration  ****/
// Instead of adding millisecond we can directly now add .seconds, .nanoSeconds etc
DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
    print("Components such as clock, instant and duration: Control is here")
})

// We can also measure complex task with below code
let clock = ContinuousClock()
let time = clock.measure {
    // This can meaure some complex task
}

print("Components such as clock, instant and duration: Took \(time.components.seconds) seconds")


// MARK: - /**** Type inference from default expressions  ****/
// T can now have default expressions in Generics as shown below
func randomWinner<T: Sequence>(from options: T = 10...50) -> T.Element? {
    options.shuffled().first
}

if let randomWinner = randomWinner() {
    print("Type inference from default expressions int:", randomWinner)
}

if let randomModelWinner = randomWinner(from: names) {
    print("Type inference from default expressions names:", randomModelWinner)
}


// MARK: - /**** Opaque parameter declarations  ****/
// `func isSortedOld<T: Comparable>(array: [T]) -> Bool {` old implementation.
func isSorted(array: [some Comparable]) -> Bool {
    array == array.sorted()
}

print("Opaque parameter declarations:", isSorted(array: names))


// MARK: - /**** Structural opaque result types  ****/
// Now we can return more than one opaque type
func returnOpaqueType<T: Sequence>(from options: T = 10...50) -> ([T.Element], [T.Element]) {
    (options.shuffled(), options.shuffled())
}

// We can also return array of opaque type
func returnOpaqueTypeArray<T: Sequence>(from options: T = 10...50) -> [[T.Element]] {
    [options.shuffled(), options.shuffled(), options.shuffled()]
}

// We can also return a closure or function that return opaque type
func returnOpaqueTypeMethod<T: Sequence>(from options: T = 10...50) -> () -> [[T.Element]] {
    return {
        [options.shuffled(), options.shuffled(), options.shuffled()]
    }
}
// `This whole above thing are also applied to SwiftUI View, Text`


// MARK: - /**** Unlock existentials for all protocols  ****/
let aboutMe: [any Equatable] = ["Nilaakash", "Singh", 27, "Age"]
aboutMe.forEach { element in
    if let element = element as? String {
        print("Unlock existentials for all protocols - String element", element)
    } else {
        print("Unlock existentials for all protocols - Int element", element)
    }
}

// MARK: - /**** Implicitly opened existentials  ****/
// Introducing Numeric which can take any type of integer, float, double, decimal
let first = 1
let second = 2.0
let third: Float = 3

let numbers: [any Numeric] = [first, second, third]

for number in numbers {
    print(mutipliedBy(number))
}

func mutipliedBy(_ number: any Numeric) -> any Numeric {
    number
}

// MARK: - /**** Swift Snippets ****/
// We now have:
//! For Documentation of small snippets

// MARK: Hide
let a = 10
let b = 20
let c = 30
// MARK: Show

let d = 40
let e = 50

// This will hide the unnecessary implementation and show necessary implementation when required

// MARK: - /**** Swift Regex  ****/

// MARK: - /**** Distributed actor isolation  ****/
// This was introduced for Swift server side development where we can make method distributed if we get data in async manner, no need to await from client side. For more information and implementation do refer below link:
// https://www.swift.org/blog/distributed-actors/

// MARK: - /**** BuildPartialBlock for result builders  ****/
// SE-0348 Dramatically simplifies the overloads required to implement complex result builders, which is part of the reason Swift’s advanced regular expression support was possible. However, it also theoretically removes the 10-view limit for SwiftUI without needing to add variadic generics, so if it’s adopted by the SwiftUI team it will make a lot of folks happy.


// MARK: - /**** Distributed actor isolation  ****/
// MARK: - Command line support
/// For command line support, we have three new commands
/// `Swift build --build-snippets`: To build all your source targets including all your snippets includes Builds source targets, including snippets.
/// `Swift build SomeSnippet`: To build SomeSnippet.swift as a standalone executable.
/// `Swift run SomeSnippet`: To run SomeSnippet.swift immediately.
